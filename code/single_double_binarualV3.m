function varargout = single_double_binarualV3(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @single_double_binarualV3_OpeningFcn, ...
                   'gui_OutputFcn',  @single_double_binarualV3_OutputFcn, ...
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

%%——————————界面显示前 数据初始化————————————
function single_double_binarualV3_OpeningFcn(hObject, eventdata, handles, varargin)
test_btn_init_state(handles);%禁止测试功能  只开启校准功能
handles.listener_name='NERCMS';
set(handles.et_listener_name,'String',handles.listener_name);
handles.test_audio_name='whitenoise_0dB.wav';

handles.subject_index=8;
handles.xls_file_name='.\output\result.xls';
handles.sheet=handles.listener_name;
handles.basepath='.\binarualsignal\';

%设置popmenu_single_azi的列表的值
handles.single_azi_list={'0','5','10','15','20','25','30','35','40','45'};
set(handles.popmenu_single_azi,'String',handles.single_azi_list);
%初始的校准单声源方位
handles.calibration_single_azi=0;

%设置popmenu_loudspeaker_azi的列表的值
handles.loudspeaker_azi_list={'-15  15','-20  20','-25  25','-30  30','-35  35','-40  40','-45  45'};
set(handles.popmenu_loudspeaker_azi,'String',handles.loudspeaker_azi_list);
%初始的校准左右扬声器方位
handles.calibration_left_azi=-15;
handles.calibration_right_azi=15;
%初始化按钮状态
% init_btn_state(handles);
handles.output = hObject;
guidata(hObject, handles);

%测试者姓名
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
handles.end_test_flag=0;%reset

test_start_btn_state(handles);

%确认选择的是哪一组
list=get(handles.popmenu_test_group,'String');
value=get(handles.popmenu_test_group,'Value');
handles.selected_group=list{value};%选择的测试组  第1组  第2组 .....

switch handles.selected_group
    case '第1组'
%要测试的双耳信号文件列表
        handles.b_filepath=[handles.basepath,handles.test_group_list{1},'\'] ; 
        [handles.s_filename,handles.d_filenames]=get_s_d_filenames([handles.b_filepath,'*.wav']); 
        handles.xls_file_name='.\output\result1.xls';
        basicinfo2excel(handles);

    case '第2组' 
        handles.b_filepath=[handles.basepath,handles.test_group_list{2},'\'] ; 
        [handles.s_filename,handles.d_filenames]=get_s_d_filenames([handles.b_filepath,'*.wav']);    
        handles.xls_file_name='.\output\result2.xls';
        basicinfo2excel(handles);
                    
    case '第3组'
        handles.b_filepath=[handles.basepath,handles.test_group_list{3},'\'] ; 
        [handles.s_filename,handles.d_filenames]=get_s_d_filenames([handles.b_filepath,'*.wav']);   
        handles.xls_file_name='.\output\result3.xls';
        basicinfo2excel(handles);
                
    case '第4组'
         handles.b_filepath=[handles.basepath,handles.test_group_list{4},'\'] ; 
        [handles.s_filename,handles.d_filenames]=get_s_d_filenames([handles.b_filepath,'*.wav']);   
        handles.xls_file_name='.\output\result4.xls';
        basicinfo2excel(handles);
                
    case '第5组'
        handles.b_filepath=[handles.basepath,handles.test_group_list{5},'\'] ; 
        [handles.s_filename,handles.d_filenames]=get_s_d_filenames([handles.b_filepath,'*.wav']);     
        handles.xls_file_name='.\output\result5.xls';
        basicinfo2excel(handles);
        
    case '第6组' 
        handles.b_filepath=[handles.basepath,handles.test_group_list{6},'\'] ; 
        [handles.s_filename,handles.d_filenames]=get_s_d_filenames([handles.b_filepath,'*.wav']);   
        handles.xls_file_name='.\output\result6.xls';
        basicinfo2excel(handles);
        
    case '第7组' 
        handles.b_filepath=[handles.basepath,handles.test_group_list{7},'\'] ; 
        [handles.s_filename,handles.d_filenames]=get_s_d_filenames([handles.b_filepath,'*.wav']);   
        handles.xls_file_name='.\output\result7.xls';
        basicinfo2excel(handles);
    otherwise 
        warning('未选择测试组！！！');
                
end

%读取在开始的单双声源双耳信号
[handles.single_wav_data, handles.fs, handles.nbits]=wavread([handles.b_filepath,handles.s_filename{1}]);
[handles.double_wav_data, handles.fs, handles.nbits]=wavread([handles.b_filepath,handles.d_filenames{1}]);

%存储单双声源双耳信号文件名        
handles.single_binarual_name=handles.s_filename{1};
handles.double_binarual_name=handles.d_filenames{1};

%总共的测试次数
handles.test_count=length(handles.d_filenames);

%position 保存了每次判断的方位，列矩阵
handles.position=cell(handles.test_count,1);
        
%播放第一种扬声器增益下的对比双耳信号
sound(handles.single_wav_data, handles.fs, handles.nbits);
pause(1.3);
sound(handles.double_wav_data, handles.fs, handles.nbits);
handles.current_count=1;%当前测试次数

handles.output = hObject;
guidata(hObject, handles);


function varargout = single_double_binarualV3_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

%————选择测试组————————————————————————
function popmenu_test_group_Callback(hObject, eventdata, handles)
%————根据选择的测试组  更新single_azi 和 loudspeaker_azi

list=get(handles.popmenu_test_group,'String');
value=get(handles.popmenu_test_group,'Value');

str=handles.test_group_list{value};
str=deblank(str);
s=regexp(str,'_','split');
set(handles.txt_single_azi,'String',s{2});
set(handles.txt_loudspeaker_azi,'String',['[ ',s{3},' , ',s{4},' ]']);

handles.selected_group_folder_name=str;
handles.selected_single_azi=str2num(s{2});
handles.selected_left_azi=str2num(s{3});
handles.selected_right_azi=str2num(s{4});

handles.output = hObject;
guidata(hObject, handles);

function popmenu_test_group_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%——————判断偏左———————————————————————
function btn_left_Callback(hObject, eventdata, handles)
handles.end_test_flag=0;
handles.position{handles.current_count}='left';
if handles.current_count<handles.test_count
     
    handles.current_count=handles.current_count+1;%当前测试次数+1
    [handles.double_wav_data, handles.fs, handles.nbits]=wavread([handles.b_filepath,handles.d_filenames{handles.current_count}]);
    handles.double_binarual_name=handles.d_filenames{handles.current_count};
    
    sound(handles.single_wav_data, handles.fs, handles.nbits);
    pause(2);
    sound(handles.double_wav_data, handles.fs, handles.nbits);
else
    test_end_btn_state(handles);
    judgeinfo2excel(handles);    
    msgbox('测试完成！');
end
guidata(hObject, handles);


%——————判断偏右———————————————————————
function btn_right_Callback(hObject, eventdata, handles)
handles.end_test_flag=0;
handles.position{handles.current_count}='right';
if handles.current_count<handles.test_count
   
    handles.current_count=handles.current_count+1;%当前测试次数+1
    [handles.double_wav_data, handles.fs, handles.nbits]=wavread([handles.b_filepath,handles.d_filenames{handles.current_count}]);
   
    sound(handles.single_wav_data, handles.fs, handles.nbits);
    pause(2);
    sound(handles.double_wav_data, handles.fs, handles.nbits);
else
    test_end_btn_state(handles);    
    judgeinfo2excel(handles);
    msgbox('测试完成！');
end
guidata(hObject, handles);

%——————无法判断———————————————————————
function btn_cannot_judge_Callback(hObject, eventdata, handles)
handles.position{handles.current_count}='cannot_judge';

if handles.end_test_flag==0
    msgbox('请点击重新播放按钮，再听一次，确认你的判断！');
    handles.end_test_flag=1;
    set(handles.btn_left,'Enable','off');
    set(handles.btn_right,'Enable','off');
    set(handles.btn_cannot_judge,'Enable','off');
    set(handles.btn_restart_play,'Enable','on');
    
else
    test_end_btn_state(handles);   
    judgeinfo2excel(handles);
    msgbox('测试完成！');
end

guidata(hObject, handles);

%——————重新播放———————————————————————
function btn_restart_play_Callback(hObject, eventdata, handles)
if  handles.end_test_flag==1;
    set(handles.btn_left,'Enable','on');
    set(handles.btn_right,'Enable','on');
    set(handles.btn_cannot_judge,'Enable','on');
    set(handles.btn_restart_play,'Enable','on');
end
sound(handles.single_wav_data, handles.fs, handles.nbits);
pause(2);
sound(handles.double_wav_data, handles.fs, handles.nbits);

%——————测试开始时各按钮状态—————————————————
function test_start_btn_state(handles)
set(handles.btn_start_test,'Enable','off');
set(handles.btn_left,'Enable','on');
set(handles.btn_right,'Enable','on');
set(handles.btn_cannot_judge,'Enable','on');
set(handles.btn_restart_play,'Enable','on');
set(handles.et_listener_name,'Enable','off');
set(handles.popmenu_test_group,'Enable','off');

%——————测试结束时各按钮状态—————————————————
function test_end_btn_state(handles)
set(handles.btn_start_test,'Enable','on');
set(handles.btn_left,'Enable','off');
set(handles.btn_right,'Enable','off');
set(handles.btn_cannot_judge,'Enable','off');
set(handles.btn_restart_play,'Enable','off');
set(handles.et_listener_name,'Enable','on');
set(handles.popmenu_test_group,'Enable','on');

%——————输出测试基本信息到excel表中——————————————————
function basicinfo2excel(handles)
xlRange={'B3','B4','B5','B6','B7','B8'};
data={handles.listener_name,handles.test_audio_name,num2str(handles.selected_single_azi),num2str(handles.selected_left_azi),num2str(handles.selected_right_azi),handles.selected_group_folder_name};
for i=1:length(xlRange)
    xlswrite(handles.xls_file_name,data(i),handles.sheet,xlRange{i});
end

%——————输出方位判断的信息到excel中去————————————————
function judgeinfo2excel(handles)

%VBAP获取初始增益
loudspeaker_azi=[handles.selected_left_azi,handles.selected_right_azi];
single_azi=handles.selected_single_azi;
init_gain= get_init_gain(loudspeaker_azi,single_azi);
%得到多组增益
[left_gain_vector ,right_gain_vector]=get_left_right_gain_vector(init_gain);
left_gain_vector=left_gain_vector';
right_gain_vector=right_gain_vector';
gain_factor=[left_gain_vector,right_gain_vector];
% save gain_fator.mat gain_factor;

test_count_no=1:length(left_gain_vector);
test_count_no=test_count_no';
for i=1:length(left_gain_vector)
    s_filenames{i}=handles.s_filename{1};
    
end
s_filenames=s_filenames';
d_filenames=handles.d_filenames;

%————————为什么不能一次性写入？？？？？？
xlswrite(handles.xls_file_name,test_count_no,handles.sheet,'D4');
xlswrite(handles.xls_file_name,left_gain_vector,handles.sheet,'E4');
xlswrite(handles.xls_file_name,right_gain_vector,handles.sheet,'F4');
xlswrite(handles.xls_file_name,handles.position,handles.sheet,'G4');
xlswrite(handles.xls_file_name,s_filenames,handles.sheet,'H4');
xlswrite(handles.xls_file_name,d_filenames,handles.sheet,'I4');


%——————试听校准开始————————————————————
function btn_calibration_Callback(hObject, eventdata, handles)
%以VBAP得到的初始增益为基准  生成双耳信号 进行校准
handles.calibration_result='init';%reset  handles.calibration_result
azi_loudspeaker=[handles.calibration_left_azi,handles.calibration_right_azi];
azi_single=handles.calibration_single_azi;

handles.azi_loudspeaker=azi_loudspeaker;
handles.azi_single=azi_single;
% save azi_loudspeaker.mat azi_loudspeaker
% save azi_single.mat azi_single
init_gain= get_init_gain(handles.azi_loudspeaker,handles.azi_single);%由vbap获得初始增益因子
% save init_gain_calibration_start.mat  init_gain 
handles.init_gain=init_gain;
[handles.wav_data,handles.fs,handles.nbits]=wavread(handles.test_audio_name);
handles.calibration_single_binarual=generate_single_binarual(handles.wav_data,handles.subject_index,handles.azi_single);
[handles.calibration_double_binarual]=generate_double_binarual(handles.wav_data,handles.subject_index,handles.azi_loudspeaker,handles.init_gain);

sound(handles.calibration_single_binarual,handles.fs,handles.nbits);
pause(1.2)
sound(handles.calibration_double_binarual,handles.fs,handles.nbits);
pause(2)
guidata(hObject, handles);


%——————试听校准偏左————————————————————
function btn_calibration_left_Callback(hObject, eventdata, handles)
pause(1);
init_gain=handles.init_gain;% save init_gain.mat init_gain

if strcmp(handles.calibration_result,'right')
    left_gain=init_gain(1);
    if left_gain+0.025<1
        left_gain=left_gain+0.025;%适当向靠近1处  扩展第二左增益 
    else
        left_gain=1;
    end
    handles.init_left_gain2=left_gain;%记录下第二个左增益  
%     left_gain_range=[handles.init_left_gain1,handles.init_left_gain2];%左增益范围
    left_gain_vector=handles.init_left_gain1:0.005:handles.init_left_gain2;
        
    right_gain_vector=sqrt(1-left_gain_vector.^2);
    handles.right_gain_vector=right_gain_vector;
    handles.left_gain_vector=left_gain_vector;
    save right_gain_vector.mat right_gain_vector
    save left_gain_vector.mat  left_gain_vector
    msgbox('校准结束，请点击双耳音频生成，然后开始测试！');
%   calibration_end_state(handles);
else 
    handles.calibration_result='left';%校准结果偏左  则记录下第一个右增益   然后增加右增益 再判断方位
    right_gain=init_gain(2);    
    if right_gain-0.025>0
       handles.init_right_gain1=right_gain-0.025;%记录下第一个右增益  适当扩大范围
    else
       handles.init_right_gain1=0;
    end
         
    right_gain=right_gain+0.05;
    if right_gain>=1%保证不超过1
        right_gain=1;
    end
    left_gain=sqrt(1-right_gain^2);
    handles.init_gain=[left_gain,right_gain];
    [handles.calibration_double_binarual]=generate_double_binarual(handles.wav_data,handles.subject_index,handles.azi_loudspeaker,handles.init_gain);

    sound(handles.calibration_single_binarual,handles.fs,handles.nbits);
    pause(1.2)
    sound(handles.calibration_double_binarual,handles.fs,handles.nbits);
    pause(2)
end
guidata(hObject, handles);


%——————试听校准偏右————————————————————
function btn_calibration_right_Callback(hObject, eventdata, handles)
pause(1);
init_gain=handles.init_gain;% save init_gain.mat init_gain
if strcmp(handles.calibration_result,'left')
    right_gain=init_gain(2);
    if right_gain+0.025<1
        right_gain=right_gain+0.025;%适当向靠近1处  扩展第二左增益 
    else
        right_gain=1;
    end
    handles.init_right_gain2=right_gain;%记录下第二个右增益  
%   right_gain_range=[handles.init_right_gain1,handles.init_right_gain2];%右增益范围

    right_gain_vector=handles.init_right_gain1:0.005:handles.init_right_gain2;
    left_gain_vector=sqrt(1-right_gain_vector.^2);
    handles.right_gain_vector=right_gain_vector;
    handles.left_gain_vector=left_gain_vector;
    save right_gain_vector.mat right_gain_vector
    save left_gain_vector.mat left_gain_vector

    msgbox('校准结束，请点击双耳音频生成，然后开始测试！');
%   calibration_end_state(handles);
else    
    handles.calibration_result='right';%校准结果偏右  则记录下第一个左增益   然后增加左增益 再判断方位
    left_gain=init_gain(1);
    if left_gain-0.025>0
       handles.init_left_gain1=left_gain-0.025;%记录下第一个左增益  适当扩大范围 
    else
       handles.init_left_gain1=0;
    end
 
    left_gain=left_gain+0.05;
    if left_gain>=1
        left_gain=1;
    end

    right_gain=sqrt(1-left_gain^2);
    handles.init_gain=[left_gain,right_gain];
    [handles.calibration_double_binarual]=generate_double_binarual(handles.wav_data,handles.subject_index,handles.azi_loudspeaker,handles.init_gain);

    sound(handles.calibration_single_binarual,handles.fs,handles.nbits);
    pause(1.2)
    sound(handles.calibration_double_binarual,handles.fs,handles.nbits);
    pause(2)   
end    
guidata(hObject, handles);



function calibration_end_state(handles)
set(handles.btn_calibration,'Enable','off');
set(handles.btn_calibration_left,'Enable','off');
set(handles.btn_calibration_right,'Enable','off');


%————————生成双耳音频————————————————————
function btn_generate_double_binarual_Callback(hObject, eventdata, handles)
pause(1);
wav_file_name=handles.test_audio_name;
subject_index=handles.subject_index;
azi_single=handles.azi_single;
azi_loudspeaker=handles.azi_loudspeaker;
left_gain_vector=handles.left_gain_vector;
right_gain_vector=handles.right_gain_vector;
batch_generate_binarual(wav_file_name,subject_index,azi_single,azi_loudspeaker,left_gain_vector,right_gain_vector)


%————————校准时   选择单声源方位————————————————————
function popmenu_single_azi_Callback(hObject, eventdata, handles)
selected_value=get(handles.popmenu_single_azi,'Value');
str=handles.single_azi_list{selected_value};
handles.calibration_single_azi=str2num(str);

if handles.calibration_single_azi>=handles.calibration_right_azi
    msgbox('你所选的声源方位已超出扬声器夹角范围，请重新选择！')
else
   
end
handles.output = hObject;
guidata(hObject, handles);


function popmenu_single_azi_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%————————校准时  选择扬声器方位夹角————————————————————
function popmenu_loudspeaker_azi_Callback(hObject, eventdata, handles)

selected_value=get(handles.popmenu_loudspeaker_azi,'Value');
str=handles.loudspeaker_azi_list{selected_value};
str=deblank(str);
s=regexp(str,'\s+','split');%以一个空格或多个空格为分隔符 分割字符串
handles.calibration_left_azi=str2num(s{1});
handles.calibration_right_azi=str2num(s{2});

if handles.calibration_single_azi>=handles.calibration_right_azi
    msgbox('你所选的声源方位已超出扬声器夹角范围，请重新选择！')
else
    
end
handles.output = hObject;
guidata(hObject, handles);

function popmenu_loudspeaker_azi_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%校准  重新播放
function btn_calibration_replay_Callback(hObject, eventdata, handles)
sound(handles.calibration_single_binarual,handles.fs,handles.nbits);
pause(1.2)
sound(handles.calibration_double_binarual,handles.fs,handles.nbits);
pause(2)

%配置参数  配置测试组 popmenu_test_group
function btn_config_paramater_Callback(hObject, eventdata, handles)
%初始化测试组列表  每组测试的文件夹的名称
handles.test_group_list=get_sub_folders(handles.basepath);
handles.end_test_flag=0;%是否完成测试标志位

%初始的为第一组的single_azi 和  double_azi
str=handles.test_group_list{1};
str=deblank(str);
s=regexp(str,'_','split');
set(handles.txt_single_azi,'String',s{2});
set(handles.txt_loudspeaker_azi,'String',['[ ',s{3},' , ',s{4},' ]']);

handles.selected_group_folder_name=str;
handles.selected_single_azi=str2num(s{2});
handles.selected_left_azi=str2num(s{3});
handles.selected_right_azi=str2num(s{4});

for i=1:length(handles.test_group_list)
    test_group{i}=['第' num2str(i) '组'];
end
set(handles.popmenu_test_group,'String',test_group);
guidata(hObject, handles);


%校准按钮初始化状态
function  calibration_btn_init_state(handles)
set(handles.btn_calibration,'Enable','off');
set(handles.btn_calibration_left,'Enable','off');
set(handles.btn_calibration_right,'Enable','off');
set(handles.btn_calibration_replay,'Enable','off');
set(handles.btn_generate_double_binarual,'Enable','off');

% 测试相关按钮初始化状态
function  test_btn_init_state(handles)

set(handles.btn_config_paramater,'Enable','off');
set(handles.popmenu_test_group,'Enable','off');
set(handles.btn_start_test,'Enable','off');
set(handles.btn_left,'Enable','off');
set(handles.btn_right,'Enable','off');
set(handles.btn_cannot_judge,'Enable','off');
set(handles.btn_restart_play,'Enable','off');














%按钮初始化状态
% function  test_btn_init_state(handles)
% set(handles.popmenu_single_azi,'Enable','off');
% set(handles.btn_calibration,'Enable','off');
% set(handles.btn_calibration_left,'Enable','off');
% set(handles.btn_calibration_right,'Enable','off');
% set(handles.btn_calibration_replay,'Enable','off');
% 
% set(handles.btn_generate_double_binarual,'Enable','off');
% set(handles.btn_config_paramater,'Enable','off');
% set(handles.popmenu_test_group,'Enable','off');
% set(handles.btn_start_test,'Enable','off');
% set(handles.btn_left,'Enable','off');
% set(handles.btn_right,'Enable','off');
% set(handles.btn_cannot_judge,'Enable','off');
% set(handles.btn_restart_play,'Enable','off');




