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

%%��������������������������ʾǰ ���ݳ�ʼ��������������������������
function single_double_binarualV3_OpeningFcn(hObject, eventdata, handles, varargin)
test_btn_init_state(handles);%��ֹ���Թ���  ֻ����У׼����
handles.listener_name='NERCMS';
set(handles.et_listener_name,'String',handles.listener_name);
handles.test_audio_name='whitenoise_0dB.wav';

handles.subject_index=8;
handles.xls_file_name='.\output\result.xls';
handles.sheet=handles.listener_name;
handles.basepath='.\binarualsignal\';

%����popmenu_single_azi���б��ֵ
handles.single_azi_list={'0','5','10','15','20','25','30','35','40','45'};
set(handles.popmenu_single_azi,'String',handles.single_azi_list);
%��ʼ��У׼����Դ��λ
handles.calibration_single_azi=0;

%����popmenu_loudspeaker_azi���б��ֵ
handles.loudspeaker_azi_list={'-15  15','-20  20','-25  25','-30  30','-35  35','-40  40','-45  45'};
set(handles.popmenu_loudspeaker_azi,'String',handles.loudspeaker_azi_list);
%��ʼ��У׼������������λ
handles.calibration_left_azi=-15;
handles.calibration_right_azi=15;
%��ʼ����ť״̬
% init_btn_state(handles);
handles.output = hObject;
guidata(hObject, handles);

%����������
function et_listener_name_Callback(hObject, eventdata, handles)
handles.listener_name=get(hObject,'String');
handles.sheet=handles.listener_name;
guidata(hObject,handles);


function et_listener_name_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%������������������ʼ���ԵĻص�����������������������������������������
function btn_start_test_Callback(hObject, eventdata, handles)
handles.end_test_flag=0;%reset

test_start_btn_state(handles);

%ȷ��ѡ�������һ��
list=get(handles.popmenu_test_group,'String');
value=get(handles.popmenu_test_group,'Value');
handles.selected_group=list{value};%ѡ��Ĳ�����  ��1��  ��2�� .....

switch handles.selected_group
    case '��1��'
%Ҫ���Ե�˫���ź��ļ��б�
        handles.b_filepath=[handles.basepath,handles.test_group_list{1},'\'] ; 
        [handles.s_filename,handles.d_filenames]=get_s_d_filenames([handles.b_filepath,'*.wav']); 
        handles.xls_file_name='.\output\result1.xls';
        basicinfo2excel(handles);

    case '��2��' 
        handles.b_filepath=[handles.basepath,handles.test_group_list{2},'\'] ; 
        [handles.s_filename,handles.d_filenames]=get_s_d_filenames([handles.b_filepath,'*.wav']);    
        handles.xls_file_name='.\output\result2.xls';
        basicinfo2excel(handles);
                    
    case '��3��'
        handles.b_filepath=[handles.basepath,handles.test_group_list{3},'\'] ; 
        [handles.s_filename,handles.d_filenames]=get_s_d_filenames([handles.b_filepath,'*.wav']);   
        handles.xls_file_name='.\output\result3.xls';
        basicinfo2excel(handles);
                
    case '��4��'
         handles.b_filepath=[handles.basepath,handles.test_group_list{4},'\'] ; 
        [handles.s_filename,handles.d_filenames]=get_s_d_filenames([handles.b_filepath,'*.wav']);   
        handles.xls_file_name='.\output\result4.xls';
        basicinfo2excel(handles);
                
    case '��5��'
        handles.b_filepath=[handles.basepath,handles.test_group_list{5},'\'] ; 
        [handles.s_filename,handles.d_filenames]=get_s_d_filenames([handles.b_filepath,'*.wav']);     
        handles.xls_file_name='.\output\result5.xls';
        basicinfo2excel(handles);
        
    case '��6��' 
        handles.b_filepath=[handles.basepath,handles.test_group_list{6},'\'] ; 
        [handles.s_filename,handles.d_filenames]=get_s_d_filenames([handles.b_filepath,'*.wav']);   
        handles.xls_file_name='.\output\result6.xls';
        basicinfo2excel(handles);
        
    case '��7��' 
        handles.b_filepath=[handles.basepath,handles.test_group_list{7},'\'] ; 
        [handles.s_filename,handles.d_filenames]=get_s_d_filenames([handles.b_filepath,'*.wav']);   
        handles.xls_file_name='.\output\result7.xls';
        basicinfo2excel(handles);
    otherwise 
        warning('δѡ������飡����');
                
end

%��ȡ�ڿ�ʼ�ĵ�˫��Դ˫���ź�
[handles.single_wav_data, handles.fs, handles.nbits]=wavread([handles.b_filepath,handles.s_filename{1}]);
[handles.double_wav_data, handles.fs, handles.nbits]=wavread([handles.b_filepath,handles.d_filenames{1}]);

%�洢��˫��Դ˫���ź��ļ���        
handles.single_binarual_name=handles.s_filename{1};
handles.double_binarual_name=handles.d_filenames{1};

%�ܹ��Ĳ��Դ���
handles.test_count=length(handles.d_filenames);

%position ������ÿ���жϵķ�λ���о���
handles.position=cell(handles.test_count,1);
        
%���ŵ�һ�������������µĶԱ�˫���ź�
sound(handles.single_wav_data, handles.fs, handles.nbits);
pause(1.3);
sound(handles.double_wav_data, handles.fs, handles.nbits);
handles.current_count=1;%��ǰ���Դ���

handles.output = hObject;
guidata(hObject, handles);


function varargout = single_double_binarualV3_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

%��������ѡ������顪����������������������������������������������
function popmenu_test_group_Callback(hObject, eventdata, handles)
%������������ѡ��Ĳ�����  ����single_azi �� loudspeaker_azi

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


%�������������ж�ƫ�󡪡�������������������������������������������
function btn_left_Callback(hObject, eventdata, handles)
handles.end_test_flag=0;
handles.position{handles.current_count}='left';
if handles.current_count<handles.test_count
     
    handles.current_count=handles.current_count+1;%��ǰ���Դ���+1
    [handles.double_wav_data, handles.fs, handles.nbits]=wavread([handles.b_filepath,handles.d_filenames{handles.current_count}]);
    handles.double_binarual_name=handles.d_filenames{handles.current_count};
    
    sound(handles.single_wav_data, handles.fs, handles.nbits);
    pause(2);
    sound(handles.double_wav_data, handles.fs, handles.nbits);
else
    test_end_btn_state(handles);
    judgeinfo2excel(handles);    
    msgbox('������ɣ�');
end
guidata(hObject, handles);


%�������������ж�ƫ�ҡ���������������������������������������������
function btn_right_Callback(hObject, eventdata, handles)
handles.end_test_flag=0;
handles.position{handles.current_count}='right';
if handles.current_count<handles.test_count
   
    handles.current_count=handles.current_count+1;%��ǰ���Դ���+1
    [handles.double_wav_data, handles.fs, handles.nbits]=wavread([handles.b_filepath,handles.d_filenames{handles.current_count}]);
   
    sound(handles.single_wav_data, handles.fs, handles.nbits);
    pause(2);
    sound(handles.double_wav_data, handles.fs, handles.nbits);
else
    test_end_btn_state(handles);    
    judgeinfo2excel(handles);
    msgbox('������ɣ�');
end
guidata(hObject, handles);

%�������������޷��жϡ���������������������������������������������
function btn_cannot_judge_Callback(hObject, eventdata, handles)
handles.position{handles.current_count}='cannot_judge';

if handles.end_test_flag==0
    msgbox('�������²��Ű�ť������һ�Σ�ȷ������жϣ�');
    handles.end_test_flag=1;
    set(handles.btn_left,'Enable','off');
    set(handles.btn_right,'Enable','off');
    set(handles.btn_cannot_judge,'Enable','off');
    set(handles.btn_restart_play,'Enable','on');
    
else
    test_end_btn_state(handles);   
    judgeinfo2excel(handles);
    msgbox('������ɣ�');
end

guidata(hObject, handles);

%���������������²��š���������������������������������������������
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

%���������������Կ�ʼʱ����ť״̬����������������������������������
function test_start_btn_state(handles)
set(handles.btn_start_test,'Enable','off');
set(handles.btn_left,'Enable','on');
set(handles.btn_right,'Enable','on');
set(handles.btn_cannot_judge,'Enable','on');
set(handles.btn_restart_play,'Enable','on');
set(handles.et_listener_name,'Enable','off');
set(handles.popmenu_test_group,'Enable','off');

%���������������Խ���ʱ����ť״̬����������������������������������
function test_end_btn_state(handles)
set(handles.btn_start_test,'Enable','on');
set(handles.btn_left,'Enable','off');
set(handles.btn_right,'Enable','off');
set(handles.btn_cannot_judge,'Enable','off');
set(handles.btn_restart_play,'Enable','off');
set(handles.et_listener_name,'Enable','on');
set(handles.popmenu_test_group,'Enable','on');

%������������������Ի�����Ϣ��excel���С�����������������������������������
function basicinfo2excel(handles)
xlRange={'B3','B4','B5','B6','B7','B8'};
data={handles.listener_name,handles.test_audio_name,num2str(handles.selected_single_azi),num2str(handles.selected_left_azi),num2str(handles.selected_right_azi),handles.selected_group_folder_name};
for i=1:length(xlRange)
    xlswrite(handles.xls_file_name,data(i),handles.sheet,xlRange{i});
end

%�����������������λ�жϵ���Ϣ��excel��ȥ��������������������������������
function judgeinfo2excel(handles)

%VBAP��ȡ��ʼ����
loudspeaker_azi=[handles.selected_left_azi,handles.selected_right_azi];
single_azi=handles.selected_single_azi;
init_gain= get_init_gain(loudspeaker_azi,single_azi);
%�õ���������
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

%����������������Ϊʲô����һ����д�룿����������
xlswrite(handles.xls_file_name,test_count_no,handles.sheet,'D4');
xlswrite(handles.xls_file_name,left_gain_vector,handles.sheet,'E4');
xlswrite(handles.xls_file_name,right_gain_vector,handles.sheet,'F4');
xlswrite(handles.xls_file_name,handles.position,handles.sheet,'G4');
xlswrite(handles.xls_file_name,s_filenames,handles.sheet,'H4');
xlswrite(handles.xls_file_name,d_filenames,handles.sheet,'I4');


%����������������У׼��ʼ����������������������������������������
function btn_calibration_Callback(hObject, eventdata, handles)
%��VBAP�õ��ĳ�ʼ����Ϊ��׼  ����˫���ź� ����У׼
handles.calibration_result='init';%reset  handles.calibration_result
azi_loudspeaker=[handles.calibration_left_azi,handles.calibration_right_azi];
azi_single=handles.calibration_single_azi;

handles.azi_loudspeaker=azi_loudspeaker;
handles.azi_single=azi_single;
% save azi_loudspeaker.mat azi_loudspeaker
% save azi_single.mat azi_single
init_gain= get_init_gain(handles.azi_loudspeaker,handles.azi_single);%��vbap��ó�ʼ��������
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


%����������������У׼ƫ�󡪡�������������������������������������
function btn_calibration_left_Callback(hObject, eventdata, handles)
pause(1);
init_gain=handles.init_gain;% save init_gain.mat init_gain

if strcmp(handles.calibration_result,'right')
    left_gain=init_gain(1);
    if left_gain+0.025<1
        left_gain=left_gain+0.025;%�ʵ��򿿽�1��  ��չ�ڶ������� 
    else
        left_gain=1;
    end
    handles.init_left_gain2=left_gain;%��¼�µڶ���������  
%     left_gain_range=[handles.init_left_gain1,handles.init_left_gain2];%�����淶Χ
    left_gain_vector=handles.init_left_gain1:0.005:handles.init_left_gain2;
        
    right_gain_vector=sqrt(1-left_gain_vector.^2);
    handles.right_gain_vector=right_gain_vector;
    handles.left_gain_vector=left_gain_vector;
    save right_gain_vector.mat right_gain_vector
    save left_gain_vector.mat  left_gain_vector
    msgbox('У׼����������˫����Ƶ���ɣ�Ȼ��ʼ���ԣ�');
%   calibration_end_state(handles);
else 
    handles.calibration_result='left';%У׼���ƫ��  ���¼�µ�һ��������   Ȼ������������ ���жϷ�λ
    right_gain=init_gain(2);    
    if right_gain-0.025>0
       handles.init_right_gain1=right_gain-0.025;%��¼�µ�һ��������  �ʵ�����Χ
    else
       handles.init_right_gain1=0;
    end
         
    right_gain=right_gain+0.05;
    if right_gain>=1%��֤������1
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


%����������������У׼ƫ�ҡ���������������������������������������
function btn_calibration_right_Callback(hObject, eventdata, handles)
pause(1);
init_gain=handles.init_gain;% save init_gain.mat init_gain
if strcmp(handles.calibration_result,'left')
    right_gain=init_gain(2);
    if right_gain+0.025<1
        right_gain=right_gain+0.025;%�ʵ��򿿽�1��  ��չ�ڶ������� 
    else
        right_gain=1;
    end
    handles.init_right_gain2=right_gain;%��¼�µڶ���������  
%   right_gain_range=[handles.init_right_gain1,handles.init_right_gain2];%�����淶Χ

    right_gain_vector=handles.init_right_gain1:0.005:handles.init_right_gain2;
    left_gain_vector=sqrt(1-right_gain_vector.^2);
    handles.right_gain_vector=right_gain_vector;
    handles.left_gain_vector=left_gain_vector;
    save right_gain_vector.mat right_gain_vector
    save left_gain_vector.mat left_gain_vector

    msgbox('У׼����������˫����Ƶ���ɣ�Ȼ��ʼ���ԣ�');
%   calibration_end_state(handles);
else    
    handles.calibration_result='right';%У׼���ƫ��  ���¼�µ�һ��������   Ȼ������������ ���жϷ�λ
    left_gain=init_gain(1);
    if left_gain-0.025>0
       handles.init_left_gain1=left_gain-0.025;%��¼�µ�һ��������  �ʵ�����Χ 
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


%��������������������˫����Ƶ����������������������������������������
function btn_generate_double_binarual_Callback(hObject, eventdata, handles)
pause(1);
wav_file_name=handles.test_audio_name;
subject_index=handles.subject_index;
azi_single=handles.azi_single;
azi_loudspeaker=handles.azi_loudspeaker;
left_gain_vector=handles.left_gain_vector;
right_gain_vector=handles.right_gain_vector;
batch_generate_binarual(wav_file_name,subject_index,azi_single,azi_loudspeaker,left_gain_vector,right_gain_vector)


%����������������У׼ʱ   ѡ����Դ��λ����������������������������������������
function popmenu_single_azi_Callback(hObject, eventdata, handles)
selected_value=get(handles.popmenu_single_azi,'Value');
str=handles.single_azi_list{selected_value};
handles.calibration_single_azi=str2num(str);

if handles.calibration_single_azi>=handles.calibration_right_azi
    msgbox('����ѡ����Դ��λ�ѳ����������нǷ�Χ��������ѡ��')
else
   
end
handles.output = hObject;
guidata(hObject, handles);


function popmenu_single_azi_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%����������������У׼ʱ  ѡ����������λ�нǡ���������������������������������������
function popmenu_loudspeaker_azi_Callback(hObject, eventdata, handles)

selected_value=get(handles.popmenu_loudspeaker_azi,'Value');
str=handles.loudspeaker_azi_list{selected_value};
str=deblank(str);
s=regexp(str,'\s+','split');%��һ���ո�����ո�Ϊ�ָ��� �ָ��ַ���
handles.calibration_left_azi=str2num(s{1});
handles.calibration_right_azi=str2num(s{2});

if handles.calibration_single_azi>=handles.calibration_right_azi
    msgbox('����ѡ����Դ��λ�ѳ����������нǷ�Χ��������ѡ��')
else
    
end
handles.output = hObject;
guidata(hObject, handles);

function popmenu_loudspeaker_azi_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%У׼  ���²���
function btn_calibration_replay_Callback(hObject, eventdata, handles)
sound(handles.calibration_single_binarual,handles.fs,handles.nbits);
pause(1.2)
sound(handles.calibration_double_binarual,handles.fs,handles.nbits);
pause(2)

%���ò���  ���ò����� popmenu_test_group
function btn_config_paramater_Callback(hObject, eventdata, handles)
%��ʼ���������б�  ÿ����Ե��ļ��е�����
handles.test_group_list=get_sub_folders(handles.basepath);
handles.end_test_flag=0;%�Ƿ���ɲ��Ա�־λ

%��ʼ��Ϊ��һ���single_azi ��  double_azi
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
    test_group{i}=['��' num2str(i) '��'];
end
set(handles.popmenu_test_group,'String',test_group);
guidata(hObject, handles);


%У׼��ť��ʼ��״̬
function  calibration_btn_init_state(handles)
set(handles.btn_calibration,'Enable','off');
set(handles.btn_calibration_left,'Enable','off');
set(handles.btn_calibration_right,'Enable','off');
set(handles.btn_calibration_replay,'Enable','off');
set(handles.btn_generate_double_binarual,'Enable','off');

% ������ذ�ť��ʼ��״̬
function  test_btn_init_state(handles)

set(handles.btn_config_paramater,'Enable','off');
set(handles.popmenu_test_group,'Enable','off');
set(handles.btn_start_test,'Enable','off');
set(handles.btn_left,'Enable','off');
set(handles.btn_right,'Enable','off');
set(handles.btn_cannot_judge,'Enable','off');
set(handles.btn_restart_play,'Enable','off');














%��ť��ʼ��״̬
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




