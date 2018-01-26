function varargout = single_double_binarualV2(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @single_double_binarualV2_OpeningFcn, ...
                   'gui_OutputFcn',  @single_double_binarualV2_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

%%——————————界面显示前 数据初始化————————————————
function single_double_binarualV2_OpeningFcn(hObject, eventdata, handles, varargin)
initpath()%初始化路径
handles.listener_name='NERCMS';
set(handles.et_listener_name,'String',handles.listener_name);

handles.selected_single_azi=15;
handles.selected_left_azi=-30;
handles.selected_right_azi=30;
handles.test_audio_name='whitenoise_0dB.wav';

handles.left_gain=0;
handles.right_gain=0;
handles.test_count=20;
handles.current_count=0;

handles.input_file_path='E:\Matlab\单双声源双耳信号对比实验\signals\白噪声\';
handles.output_file_path='E:\Matlab\单双声源双耳信号对比实验\output\';
handles.input_file_name='whitenoise_0dB.wav';
handles.xls_file_name='E:\Matlab\单双声源双耳信号对比实验\output\result.xls';
handles.sheet=handles.listener_name;

set(handles.txt_test_audio_name,'String',handles.test_audio_name);
single_source_azi_range={'-30','-25','-20','-15','-10','-5','0','5','10','15','20','25','30'};
left_loudspeaker_azi_range={'-30','-25','-20','-15','-10','-5','0','5','10','15','20','25','30'};
right_loudspeaker_azi_range={'-30','-25','-20','-15','-10','-5','0','5','10','15','20','25','30'};
set(handles.popmenu_single_source_azi,'String',single_source_azi_range);
set(handles.popmenu_left_loudspeaker_azi,'String',left_loudspeaker_azi_range);
set(handles.popmenu_right_loudspeaker_azi,'String',right_loudspeaker_azi_range);
set(handles.txt_left_gain,'String',num2str(handles.left_gain));
set(handles.txt_right_gain,'String',num2str(handles.right_gain));

[wav_data fs nbits]=wavread(strcat(handles.input_file_path,handles.input_file_name));
handles.wav_data=wav_data;
handles.fs=fs;
handles.nbits=nbits;

handles.output = hObject;
guidata(hObject, handles);


function varargout = single_double_binarualV2_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

%%——————————听音者姓名改变的 回调函数——————————————
function et_listener_name_Callback(hObject, eventdata, handles)
handles.listener_name=get(hObject,'String');
handles.sheet=handles.listener_name;
guidata(hObject,handles);


function et_listener_name_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%————————开始测试的回调函数——————————————————
function btn_start_test_Callback(hObject, eventdata, handles)
test_start_btn_state(handles);
basicinfo2excel(handles);%测试基本信息写入excel中
handles.current_count=0;%当前测试为第几次  初始值为1

selected_single_azi=handles.selected_single_azi;
selected_left_azi=handles.selected_left_azi;
selected_right_azi=handles.selected_right_azi;
loudspeaker_azi=[selected_left_azi,selected_right_azi];

[left_gain_vector right_gain_vector]=get_left_right_gain_vector(get_init_gain(loudspeaker_azi,selected_single_azi));
handles.left_gain_range=left_gain_vector;
handles.right_gain_range=right_gain_vector;
handles.test_count=length(handles.left_gain_range);


%———————最开始时 扬声器左右增益默认为第一组增益——————————
handles.left_gain=handles.left_gain_range(1);
handles.right_gain=handles.right_gain_range(1);
set(handles.txt_left_gain,'String',num2str(handles.left_gain));
set(handles.txt_right_gain,'String',num2str(handles.right_gain));
gain_factor=[handles.left_gain handles.right_gain];

handles.single_binarual=generate_single_binarual(handles.wav_data,selected_single_azi);
handles.double_binarual=generate_double_binarual(handles.wav_data,loudspeaker_azi,gain_factor);

sound(handles.single_binarual,handles.fs,handles.nbits);
pause(1.2);
sound(handles.double_binarual,handles.fs,handles.nbits);
set(handles.btn_start_test,'Enable','off');

output_single_binarual(handles)%输出单声源双耳信号

%————存储单声源双耳信号名——————————————————————
file_name=['s_b_' num2str(handles.selected_single_azi) '_' handles.input_file_name];
handles.single_binarual_name=file_name;
guidata(hObject,handles);


%%————————方位判断偏左的回调函数——————————————
function btn_left_Callback(hObject, eventdata, handles)
handles.current_count=handles.current_count+1;

if handles.current_count<=handles.test_count
%———输出双声源双耳信号——————————————————————————    
    output_double_binarual(handles,'left')     
%———选择下一组增益因子 重新生成双耳信号 并播放供下一次方位判断——————————     
    handles.left_gain=handles.left_gain_range(handles.current_count);
    handles.right_gain=handles.right_gain_range(handles.current_count);
    update_left_right_gain(handles);
    gain_factor=[handles.left_gain handles.right_gain];
    loudspeaker_azi=[handles.selected_left_azi,handles.selected_right_azi];
    handles.double_binarual=generate_double_binarual(handles.wav_data,loudspeaker_azi,gain_factor);    
%———播放新的双声源双耳信号——————————————————————————       
    play_new_binarual(handles);
%———方位判断偏左相关信息写到excel中去————————————————————    
    judgeinfo2excel(handles,'left');  
else
     msgbox('测试完成，谢谢！');
end
guidata(hObject,handles);


    
%%————————方位判断偏右的回调函数————————————————
function btn_right_Callback(hObject, eventdata, handles)
handles.current_count=handles.current_count+1;

if handles.current_count<=handles.test_count
%———输出此次判断的双声源双耳信号—————————————————————————   
    output_double_binarual(handles,'right') 
%———选择下一组增益因子 重新生成双耳信号 并播放供下一次方位判断——————————   
    handles.left_gain=handles.left_gain_range(handles.current_count);
    handles.right_gain=handles.right_gain_range(handles.current_count);
    update_left_right_gain(handles);
    gain_factor=[handles.left_gain handles.right_gain];
    loudspeaker_azi=[handles.selected_left_azi,handles.selected_right_azi];
    handles.double_binarual=generate_double_binarual(handles.wav_data,loudspeaker_azi,gain_factor);    
%———播放新的双声源双耳信号——————————————————————————       
    play_new_binarual(handles);
%———方位判断偏左相关信息写到excel中去————————————————————    
    judgeinfo2excel(handles,'right');  
else
     msgbox('测试完成，谢谢！');
end
guidata(hObject,handles);


%%————————方位无法判断的回调函数————————————————
function btn_cannot_judge_Callback(hObject, eventdata, handles)
%———输出双声源双耳信号————————————————————————— 
handles.current_count=handles.current_count+1;
if handles.current_count<=handles.test_count
    output_double_binarual(handles,'nojudge')
    judgeinfo2excel(handles,'nojudge');
else
    msgbox('测试完成，谢谢！');
end
test_end_btn_state(handles);
guidata(hObject,handles);

%%————————重新播放的回调函数——————————————————
function btn_restart_play_Callback(hObject, eventdata, handles)
sound(handles.single_binarual,handles.fs,handles.nbits);
pause(1.2);
sound(handles.double_binarual,handles.fs,handles.nbits);


%%————————单声源方位角改变的回调函数——————————————
function popmenu_single_source_azi_Callback(hObject, eventdata, handles)
handles.selected_single_azi=get_selected_single_source_azi(handles);
guidata(hObject,handles);%%必须更新数据  才能保证handles中的数据能真正被改变了
function popmenu_single_source_azi_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%————————右扬声器方位角改变的回调函数——————————————
function popmenu_right_loudspeaker_azi_Callback(hObject, eventdata, handles)
handles.selected_right_azi=get_selected_right_loudspeaker_azi(handles);
guidata(hObject,handles);
function popmenu_right_loudspeaker_azi_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%————————左扬声器方位角改变的回调函数——————————————
function popmenu_left_loudspeaker_azi_Callback(hObject, eventdata, handles)
handles.selected_left_azi=get_selected_left_loudspeaker_azi(handles);
guidata(hObject,handles);
function popmenu_left_loudspeaker_azi_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%————————获取选中的单声源方位角————————————————
function selected_single_azi=get_selected_single_source_azi(handles)
list=get(handles.popmenu_single_source_azi,'String');
value=get(handles.popmenu_single_source_azi,'Value');
selected_single_azi=str2num(list{value});

%%————————获取选中的左扬声器方位角————————————————
function selected_left_azi=get_selected_left_loudspeaker_azi(handles)
list=get(handles.popmenu_left_loudspeaker_azi,'String');
value=get(handles.popmenu_left_loudspeaker_azi,'Value');
selected_left_azi=str2num(list{value});

%%————————获取选中的右扬声器方位角————————————————
function selected_right_azi=get_selected_right_loudspeaker_azi(handles)
list=get(handles.popmenu_right_loudspeaker_azi,'String');
value=get(handles.popmenu_right_loudspeaker_azi,'Value');
selected_right_azi=str2num(list{value});

%————————根据新的增益因子生成新的双声源双耳信号，并和单声源双耳信号一起播放
function play_new_binarual(handles) 
sound(handles.single_binarual,handles.fs,handles.nbits);
pause(1.2);
sound(handles.double_binarual,handles.fs,handles.nbits);

%————————更新左右扬声器增益————————————————————————
function update_left_right_gain(handles)
set(handles.txt_left_gain,'String',num2str(handles.left_gain));
set(handles.txt_right_gain,'String',num2str(handles.right_gain));

%————————测试开始时各按钮状态———————————————————————
function test_start_btn_state(handles)
set(handles.btn_start_test,'Enable','off');
set(handles.btn_left,'Enable','on');
set(handles.btn_right,'Enable','on');
set(handles.btn_cannot_judge,'Enable','on');
set(handles.btn_restart_play,'Enable','on');

%————————测试结束时各按钮状态———————————————————————
function test_end_btn_state(handles)
set(handles.btn_start_test,'Enable','on');
set(handles.btn_left,'Enable','off');
set(handles.btn_right,'Enable','off');
set(handles.btn_cannot_judge,'Enable','off');
set(handles.btn_restart_play,'Enable','off');

%————————输出单声源双耳信号————————————————————————
function output_single_binarual(handles)
file_name=[ handles.listener_name '_s_b_' num2str(handles.selected_single_azi) '_' handles.input_file_name];
handles.single_binarual_name=file_name;
file_name=[handles.output_file_path file_name];
wavwrite(handles.single_binarual,handles.fs,handles.nbits,file_name);

%————————输出双声源双耳信号————————————————————————
function output_double_binarual(handles,position)
file_name=[handles.listener_name '_d_b_' num2str(handles.selected_left_azi) '_' num2str(handles.selected_right_azi)...
    '_' num2str(handles.current_count) '_' position  '_' handles.input_file_name];
handles.double_binarual_name=file_name;
file_name=[handles.output_file_path file_name];
wavwrite(handles.double_binarual,handles.fs,handles.nbits,file_name);

%————————输出测试基本信息到excel表中——————————————————
function basicinfo2excel(handles)
xlRange={'B3','B4','B5','B6','B7'};
data={handles.listener_name,handles.test_audio_name,num2str(handles.selected_single_azi),num2str(handles.selected_left_azi),num2str(handles.selected_right_azi)};
for i=1:length(xlRange)
    xlswrite(handles.xls_file_name,data(i),handles.sheet,xlRange{i});
end

%————————输出方位判断的信息到excel中去————————————————
function judgeinfo2excel(handles,position)
range1=['D' num2str(handles.current_count+3)];
range2=['E' num2str(handles.current_count+3)];
range3=['F' num2str(handles.current_count+3)];
range4=['G' num2str(handles.current_count+3)];
range5=['H' num2str(handles.current_count+3)];
range6=['I' num2str(handles.current_count+3)];
xlRange={range1,range2,range3,range4,range5,range6};
file_name=[handles.listener_name,  '_d_b_' num2str(handles.selected_left_azi) '_' num2str(handles.selected_right_azi)...
'_' num2str(handles.current_count) '_' position  '_' handles.input_file_name];
handles.double_binarual_name=file_name;
data={handles.current_count,handles.left_gain,handles.right_gain,position,handles.single_binarual_name,handles.double_binarual_name};
for i=1:length(xlRange)
 xlswrite(handles.xls_file_name,data(i),handles.sheet,xlRange{i});
end
