function varargout = single_double_binarual(varargin)
% SINGLE_DOUBLE_BINARUAL MATLAB code for single_double_binarual.fig
%      SINGLE_DOUBLE_BINARUAL, by itself, creates a new SINGLE_DOUBLE_BINARUAL or raises the existing
%      singleton*.
%
%      H = SINGLE_DOUBLE_BINARUAL returns the handle to a new SINGLE_DOUBLE_BINARUAL or the handle to
%      the existing singleton*.
%
%      SINGLE_DOUBLE_BINARUAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SINGLE_DOUBLE_BINARUAL.M with the given input arguments.
%
%      SINGLE_DOUBLE_BINARUAL('Property','Value',...) creates a new SINGLE_DOUBLE_BINARUAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before single_double_binarual_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to single_double_binarual_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help single_double_binarual

% Last Modified by GUIDE v2.5 19-May-2016 15:08:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @single_double_binarual_OpeningFcn, ...
                   'gui_OutputFcn',  @single_double_binarual_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


%————界面启动函数,初始化界面，在界面显示之前执行———————————————
function single_double_binarual_OpeningFcn(hObject, eventdata, handles, varargin)

initpath()%初始化路径
handles.scheme=2;%不同的方案
if handles.scheme==1
    set(handles.slider_gain_step,'Visible','off');
    handles.gain_step=[0.05 0.02 0.01];
else 
    set(handles.slider_gain_step,'Visible','on');
    set(handles.slider_gain_step,'Value',0.05);
    set(handles.txt_gain_step,'String',num2str(0.05));
    handles.gain_step=0.05;%初始增益步长
end

handles.listener_name='NERCMS';
handles.sheet=handles.listener_name;
handles.single_source_azi=15;
handles.left_loudspeaker_azi=-30;
handles.right_loudspeaker_azi=30;
handles.test_audio_name='whitenoise_0dB.wav';
% handles.gain_step=[0.05 0.02 0.01];
handles.left_gain=0.707;
handles.right_gain=0.707;

handles.input_file_path='E:\Matlab\单双声源双耳信号对比实验\signals\白噪声\';
handles.output_file_path='E:\Matlab\单双声源双耳信号对比实验\output\';
handles.input_file_name='whitenoise_0dB.wav';
handles.xls_file_name='E:\Matlab\单双声源双耳信号对比实验\output\result.xls';

[wav_data fs nbits]=wavread(strcat(handles.input_file_path,handles.input_file_name));
handles.wav_data=wav_data;
handles.fs=fs;
handles.nbits=nbits;
handles.test_count=20;
handles.current_count=0;
handles.count_set=[10 15 20];

set(handles.et_listener_name,'String',handles.listener_name);
set(handles.et_single_source_azi,'String',num2str(handles.single_source_azi));
set(handles.et_left_loudspeaker_azi,'String',num2str(handles.left_loudspeaker_azi));
set(handles.et_right_loudspeaker_azi,'String',num2str(handles.right_loudspeaker_azi));

set(handles.txt_test_audio_name,'String',handles.test_audio_name);
set(handles.txt_gain_step,'String',num2str(handles.gain_step(1)));
set(handles.txt_left_gain,'String',num2str(handles.left_gain));
set(handles.txt_right_gain,'String',num2str(handles.right_gain));

handles.output = hObject;
guidata(hObject, handles);



%%————输出函数——————————————————————————————————
function varargout = single_double_binarual_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


%%—————听音测试者姓名 文本编辑框 回调函数——————————————
function et_listener_name_Callback(hObject, eventdata, handles)
handles.listener_name=get(hObject,'String');
handles.sheet=handles.listener_name;
guidata(hObject,handles);

function et_listener_name_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%—————单声源方位角 文本编辑框 回调函数——————————————
function et_single_source_azi_Callback(hObject, eventdata, handles)
handles.single_source_azi=str2num(get(hObject,'String'));
guidata(hObject,handles);

function et_single_source_azi_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%—————左扬声器方位角 文本编辑框 回调函数——————————————
function et_left_loudspeaker_azi_Callback(hObject, eventdata, handles)
handles.left_loudspeaker_azi=str2num(get(hObject,'String'));
guidata(hObject,handles);

function et_left_loudspeaker_azi_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%—————右扬声器方位角 文本编辑框 回调函数——————————————
function et_right_loudspeaker_azi_Callback(hObject, eventdata, handles)
handles.right_loudspeaker_azi=str2num(get(hObject,'String'));
guidata(hObject,handles);

function et_right_loudspeaker_azi_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%—————偏左 按钮 回调函数——————————————————————————
function btn_left_Callback(hObject, eventdata, handles)
%% ————方案1——————————————————————————————
if handles.scheme==1
    if handles.current_count<handles.count_set(1)
        handles.current_count=handles.current_count+1;
        handles.left_gain=handles.left_gain-handles.gain_step(1);
        handles.right_gain=sqrt(1- handles.left_gain.^2);
        gain_factor=[handles.left_gain handles.right_gain];
        loudspeaker_azi=[handles.left_loudspeaker_azi,handles.right_loudspeaker_azi];
        handles.double_binarual=generate_double_binarual(handles.wav_data,loudspeaker_azi,gain_factor);    
%———播放新的双声源双耳信号——————————————————————————       
        play_new_binarual(handles);

    elseif handles.current_count<handles.count_set(2)
        handles.current_count=handles.current_count+1;
        handles.left_gain=handles.left_gain-handles.gain_step(2);
        handles.right_gain=sqrt(1- handles.left_gain.^2);
        gain_factor=[handles.left_gain handles.right_gain];
        loudspeaker_azi=[handles.left_loudspeaker_azi,handles.right_loudspeaker_azi];
        handles.double_binarual=generate_double_binarual(handles.wav_data,loudspeaker_azi,gain_factor);    
%———播放新的双声源双耳信号——————————————————————————       
        play_new_binarual(handles);
        
    elseif handles.current_count<handles.count_set(3)
        handles.current_count=handles.current_count+1;
        handles.left_gain=handles.left_gain-handles.gain_step(3);
        handles.right_gain=sqrt(1- handles.left_gain.^2);
        gain_factor=[handles.left_gain handles.right_gain];
        loudspeaker_azi=[handles.left_loudspeaker_azi,handles.right_loudspeaker_azi];
        handles.double_binarual=generate_double_binarual(handles.wav_data,loudspeaker_azi,gain_factor);    
%———播放新的双声源双耳信号——————————————————————————       
        play_new_binarual(handles);
    else 
        msgbox('测试完成，谢谢！');
    end
end

%% —————方案2————————————————————————————
if handles.scheme==2     
    handles.current_count=handles.current_count+1;
%———输出双声源双耳信号——————————————————————————    
    output_double_binarual(handles,'left') 
%———生成新的双耳信号———————————————————————————      
    handles.left_gain=handles.left_gain-handles.gain_step;
    handles.right_gain=sqrt(1- handles.left_gain.^2);
    update_left_right_gain(handles);
    gain_factor=[handles.left_gain handles.right_gain];
    loudspeaker_azi=[handles.left_loudspeaker_azi,handles.right_loudspeaker_azi];
    handles.double_binarual=generate_double_binarual(handles.wav_data,loudspeaker_azi,gain_factor);    
%———播放新的双声源双耳信号——————————————————————————       
    play_new_binarual(handles);
%———方位判断偏左相关信息写到excel中去————————————————————    
    judgeinfo2excel(handles,'left');   
end

guidata(hObject,handles);



%—————偏右 按钮 回调函数————————————————————————
function btn_right_Callback(hObject, eventdata, handles)
%% ————方案1—————————————————————————————
if handles.scheme==1
    if handles.current_count<handles.count_set(1)
        handles.current_count=handles.current_count+1;
        handles.right_gain=handles.right_gain-handles.gain_step(1);
        handles.left_gain=sqrt(1- handles.right_gain.^2);
        gain_factor=[handles.left_gain handles.right_gain];
        loudspeaker_azi=[handles.left_loudspeaker_azi,handles.right_loudspeaker_azi];
        handles.double_binarual=generate_double_binarual(handles.wav_data,loudspeaker_azi,gain_factor); 
%———播放新的双声源双耳信号——————————————————————————       
        play_new_binarual(handles); 

    elseif handles.current_count<handles.count_set(2)
        handles.current_count=handles.current_count+1;
        handles.right_gain=handles.right_gain-handles.gain_step(2);
        handles.left_gain=sqrt(1- handles.right_gain.^2);
        gain_factor=[handles.left_gain handles.right_gain];
        loudspeaker_azi=[handles.left_loudspeaker_azi,handles.right_loudspeaker_azi];
        handles.double_binarual=generate_double_binarual(handles.wav_data,loudspeaker_azi,gain_factor); 
%———播放新的双声源双耳信号——————————————————————————       
        play_new_binarual(handles); 
 
    elseif handles.current_count<handles.count_set(3)
        handles.current_count=handles.current_count+1;
        handles.right_gain=handles.right_gain-handles.gain_step(3);
        handles.left_gain=sqrt(1- handles.right_gain.^2);
        gain_factor=[handles.left_gain handles.right_gain];
        loudspeaker_azi=[handles.left_loudspeaker_azi,handles.right_loudspeaker_azi];
        handles.double_binarual=generate_double_binarual(handles.wav_data,loudspeaker_azi,gain_factor); 
%———播放新的双声源双耳信号——————————————————————————       
        play_new_binarual(handles); 
  
    else
        msgbox('测试完成，谢谢！');
    end
end

%% —————方案2———————————————————————————
if handles.scheme==2
     handles.current_count=handles.current_count+1;
%———判断为偏右   方法1：减少右扬声器的增益————————————————   
%     handles.right_gain=handles.right_gain-handles.gain_step;
%     handles.left_gain=sqrt(1- handles.right_gain.^2);
%     update_left_right_gain(handles);
%     generate_new_binarual_play(handles); 

%———判断为偏右   方法2：增加左扬声器的增益————————————————
%———输出双声源双耳信号——————————————————————————    
    output_double_binarual(handles,'right')
%———重新调节增益，生成新的双耳信号————————————————————    
    handles.left_gain=handles.left_gain+handles.gain_step;
    handles.right_gain=sqrt(1- handles.left_gain.^2);
    update_left_right_gain(handles);   
    gain_factor=[handles.left_gain handles.right_gain];
    loudspeaker_azi=[handles.left_loudspeaker_azi,handles.right_loudspeaker_azi];
    handles.double_binarual=generate_double_binarual(handles.wav_data,loudspeaker_azi,gain_factor); 
%———播放新的双声源双耳信号—————————————————————————    
    play_new_binarual(handles);  
%———方位判断偏右写到excel中去———————————————————————     
    judgeinfo2excel(handles,'right');
end
guidata(hObject,handles);


%—————无法判断 按钮 回调函数——————————————————————
function btn_cannot_judge_Callback(hObject, eventdata, handles)
%———输出双声源双耳信号——————————————————————————  
    handles.current_count=handles.current_count+1;
    output_double_binarual(handles,'nojudge')
    judgeinfo2excel(handles,'nojudge');
    msgbox('测试完成，谢谢！');
    test_end_btn_state(handles);
    
%—————开始测试 按钮 回调函数—————————————————————
function btn_start_test_Callback(hObject, eventdata, handles)

basicinfo2excel(handles);%测试基本信息写入excel中
handles.current_count=0;%当前测试为第几次  初始值为0
single_source_azi=handles.single_source_azi;

left_loudspeaker_azi=handles.left_loudspeaker_azi;
right_loudspeaker_azi=handles.right_loudspeaker_azi;
loudspeaker_azi=[left_loudspeaker_azi,right_loudspeaker_azi];

virtual_source_azi=handles.single_source_azi;

gain_factor=get_init_gain(loudspeaker_azi,virtual_source_azi);
handles.left_gain=gain_factor(1);
handles.right_gain=gain_factor(2);

set(handles.txt_left_gain,'String',num2str(handles.left_gain));
set(handles.txt_right_gain,'String',num2str(handles.right_gain));

handles.single_binarual=generate_single_binarual(handles.wav_data,single_source_azi);
handles.double_binarual=generate_double_binarual(handles.wav_data,loudspeaker_azi,gain_factor);

sound(handles.single_binarual,handles.fs,handles.nbits);
pause(1.2);
sound(handles.double_binarual,handles.fs,handles.nbits);
% pause(3);
set(handles.btn_start_test,'Enable','off');

output_single_binarual(handles)%输出单声源双耳信号
%————存储单声源双耳信号名——————————————————————
file_name=['s_b_' num2str(handles.single_source_azi) '_' handles.input_file_name];
handles.single_binarual_name=file_name;
guidata(hObject, handles);

%—————重新播放 按钮 回调函数————————————————————
function btn_restart_play_Callback(hObject, eventdata, handles)

pause(0.2);
sound(handles.single_binarual,handles.fs,handles.nbits);
pause(1.2);
sound(handles.double_binarual,handles.fs,handles.nbits);

%—————增益步长滑动响应事件——————————————————————
function slider_gain_step_Callback(hObject, eventdata, handles)
handles.gain_step=get(hObject,'Value');
set(handles.txt_gain_step,'String',num2str(handles.gain_step));
guidata(hObject,handles);

function slider_gain_step_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%————根据新的增益因子生成新的双声源双耳信号，并和单声源双耳信号一起播放
function play_new_binarual(handles) 
sound(handles.single_binarual,handles.fs,handles.nbits);
pause(1.2);
sound(handles.double_binarual,handles.fs,handles.nbits);


%————更新左右扬声器增益————————————————————————
function update_left_right_gain(handles)
set(handles.txt_left_gain,'String',num2str(handles.left_gain));
set(handles.txt_right_gain,'String',num2str(handles.right_gain));

%————测试结束时各按钮状态———————————————————————
function test_end_btn_state(handles)
set(handles.btn_start_test,'Enable','on');
set(handles.btn_left,'Enable','off');
set(handles.btn_right,'Enable','off');
set(handles.btn_cannot_judge,'Enable','off');
set(handles.btn_restart_play,'Enable','off');

%————输出单声源双耳信号————————————————————————
function output_single_binarual(handles)
file_name=[ handles.listener_name '_s_b_' num2str(handles.single_source_azi) '_' handles.input_file_name];
handles.single_binarual_name=file_name;
file_name=[handles.output_file_path file_name];
wavwrite(handles.single_binarual,handles.fs,handles.nbits,file_name);

%————输出双声源双耳信号————————————————————————
function output_double_binarual(handles,position)
file_name=[handles.listener_name '_d_b_' num2str(handles.left_loudspeaker_azi) '_' num2str(handles.right_loudspeaker_azi)...
    '_' num2str(handles.current_count) '_' position  '_' handles.input_file_name];
handles.double_binarual_name=file_name;
file_name=[handles.output_file_path file_name];
wavwrite(handles.double_binarual,handles.fs,handles.nbits,file_name);

%————输出测试基本信息到excel表中——————————————————
function basicinfo2excel(handles)

xlRange={'B3','B4','B5','B6','B7'};
data={handles.listener_name,handles.test_audio_name,num2str(handles.single_source_azi),num2str(handles.left_loudspeaker_azi),num2str(handles.right_loudspeaker_azi)};
for i=1:length(xlRange)
    xlswrite(handles.xls_file_name,data(i),handles.sheet,xlRange{i});
end

%————输出方位判断的信息到excel中去————————————————
function judgeinfo2excel(handles,position)
range1=['D' num2str(handles.current_count+3)];
range2=['E' num2str(handles.current_count+3)];
range3=['F' num2str(handles.current_count+3)];
range4=['G' num2str(handles.current_count+3)];
range5=['H' num2str(handles.current_count+3)];
range6=['I' num2str(handles.current_count+3)];
xlRange={range1,range2,range3,range4,range5,range6};
file_name=[handles.listener_name,  '_d_b_' num2str(handles.left_loudspeaker_azi) '_' num2str(handles.right_loudspeaker_azi)...
'_' num2str(handles.current_count) '_' position  '_' handles.input_file_name];
handles.double_binarual_name=file_name;
data={handles.current_count,handles.left_gain,handles.right_gain,position,handles.single_binarual_name,handles.double_binarual_name};
for i=1:length(xlRange)
 xlswrite(handles.xls_file_name,data(i),handles.sheet,xlRange{i});
end
