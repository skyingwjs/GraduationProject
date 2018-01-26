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

%%��������������������������ʾǰ ���ݳ�ʼ����������������������������������
function single_double_binarualV2_OpeningFcn(hObject, eventdata, handles, varargin)
initpath()%��ʼ��·��
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

handles.input_file_path='E:\Matlab\��˫��Դ˫���źŶԱ�ʵ��\signals\������\';
handles.output_file_path='E:\Matlab\��˫��Դ˫���źŶԱ�ʵ��\output\';
handles.input_file_name='whitenoise_0dB.wav';
handles.xls_file_name='E:\Matlab\��˫��Դ˫���źŶԱ�ʵ��\output\result.xls';
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

%%�������������������������������ı�� �ص���������������������������������
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
test_start_btn_state(handles);
basicinfo2excel(handles);%���Ի�����Ϣд��excel��
handles.current_count=0;%��ǰ����Ϊ�ڼ���  ��ʼֵΪ1

selected_single_azi=handles.selected_single_azi;
selected_left_azi=handles.selected_left_azi;
selected_right_azi=handles.selected_right_azi;
loudspeaker_azi=[selected_left_azi,selected_right_azi];

[left_gain_vector right_gain_vector]=get_left_right_gain_vector(get_init_gain(loudspeaker_azi,selected_single_azi));
handles.left_gain_range=left_gain_vector;
handles.right_gain_range=right_gain_vector;
handles.test_count=length(handles.left_gain_range);


%���������������ʼʱ ��������������Ĭ��Ϊ��һ�����桪������������������
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

output_single_binarual(handles)%�������Դ˫���ź�

%���������洢����Դ˫���ź�����������������������������������������������
file_name=['s_b_' num2str(handles.selected_single_azi) '_' handles.input_file_name];
handles.single_binarual_name=file_name;
guidata(hObject,handles);


%%������������������λ�ж�ƫ��Ļص���������������������������������
function btn_left_Callback(hObject, eventdata, handles)
handles.current_count=handles.current_count+1;

if handles.current_count<=handles.test_count
%���������˫��Դ˫���źš���������������������������������������������������    
    output_double_binarual(handles,'left')     
%������ѡ����һ���������� ��������˫���ź� �����Ź���һ�η�λ�жϡ�������������������     
    handles.left_gain=handles.left_gain_range(handles.current_count);
    handles.right_gain=handles.right_gain_range(handles.current_count);
    update_left_right_gain(handles);
    gain_factor=[handles.left_gain handles.right_gain];
    loudspeaker_azi=[handles.selected_left_azi,handles.selected_right_azi];
    handles.double_binarual=generate_double_binarual(handles.wav_data,loudspeaker_azi,gain_factor);    
%�����������µ�˫��Դ˫���źš���������������������������������������������������       
    play_new_binarual(handles);
%��������λ�ж�ƫ�������Ϣд��excel��ȥ����������������������������������������    
    judgeinfo2excel(handles,'left');  
else
     msgbox('������ɣ�лл��');
end
guidata(hObject,handles);


    
%%������������������λ�ж�ƫ�ҵĻص�������������������������������������
function btn_right_Callback(hObject, eventdata, handles)
handles.current_count=handles.current_count+1;

if handles.current_count<=handles.test_count
%����������˴��жϵ�˫��Դ˫���źš�������������������������������������������������   
    output_double_binarual(handles,'right') 
%������ѡ����һ���������� ��������˫���ź� �����Ź���һ�η�λ�жϡ�������������������   
    handles.left_gain=handles.left_gain_range(handles.current_count);
    handles.right_gain=handles.right_gain_range(handles.current_count);
    update_left_right_gain(handles);
    gain_factor=[handles.left_gain handles.right_gain];
    loudspeaker_azi=[handles.selected_left_azi,handles.selected_right_azi];
    handles.double_binarual=generate_double_binarual(handles.wav_data,loudspeaker_azi,gain_factor);    
%�����������µ�˫��Դ˫���źš���������������������������������������������������       
    play_new_binarual(handles);
%��������λ�ж�ƫ�������Ϣд��excel��ȥ����������������������������������������    
    judgeinfo2excel(handles,'right');  
else
     msgbox('������ɣ�лл��');
end
guidata(hObject,handles);


%%������������������λ�޷��жϵĻص�������������������������������������
function btn_cannot_judge_Callback(hObject, eventdata, handles)
%���������˫��Դ˫���źš������������������������������������������������� 
handles.current_count=handles.current_count+1;
if handles.current_count<=handles.test_count
    output_double_binarual(handles,'nojudge')
    judgeinfo2excel(handles,'nojudge');
else
    msgbox('������ɣ�лл��');
end
test_end_btn_state(handles);
guidata(hObject,handles);

%%�������������������²��ŵĻص�����������������������������������������
function btn_restart_play_Callback(hObject, eventdata, handles)
sound(handles.single_binarual,handles.fs,handles.nbits);
pause(1.2);
sound(handles.double_binarual,handles.fs,handles.nbits);


%%��������������������Դ��λ�Ǹı�Ļص���������������������������������
function popmenu_single_source_azi_Callback(hObject, eventdata, handles)
handles.selected_single_azi=get_selected_single_source_azi(handles);
guidata(hObject,handles);%%�����������  ���ܱ�֤handles�е��������������ı���
function popmenu_single_source_azi_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%��������������������������λ�Ǹı�Ļص���������������������������������
function popmenu_right_loudspeaker_azi_Callback(hObject, eventdata, handles)
handles.selected_right_azi=get_selected_right_loudspeaker_azi(handles);
guidata(hObject,handles);
function popmenu_right_loudspeaker_azi_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%��������������������������λ�Ǹı�Ļص���������������������������������
function popmenu_left_loudspeaker_azi_Callback(hObject, eventdata, handles)
handles.selected_left_azi=get_selected_left_loudspeaker_azi(handles);
guidata(hObject,handles);
function popmenu_left_loudspeaker_azi_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%������������������ȡѡ�еĵ���Դ��λ�ǡ�������������������������������
function selected_single_azi=get_selected_single_source_azi(handles)
list=get(handles.popmenu_single_source_azi,'String');
value=get(handles.popmenu_single_source_azi,'Value');
selected_single_azi=str2num(list{value});

%%������������������ȡѡ�е�����������λ�ǡ�������������������������������
function selected_left_azi=get_selected_left_loudspeaker_azi(handles)
list=get(handles.popmenu_left_loudspeaker_azi,'String');
value=get(handles.popmenu_left_loudspeaker_azi,'Value');
selected_left_azi=str2num(list{value});

%%������������������ȡѡ�е�����������λ�ǡ�������������������������������
function selected_right_azi=get_selected_right_loudspeaker_azi(handles)
list=get(handles.popmenu_right_loudspeaker_azi,'String');
value=get(handles.popmenu_right_loudspeaker_azi,'Value');
selected_right_azi=str2num(list{value});

%���������������������µ��������������µ�˫��Դ˫���źţ����͵���Դ˫���ź�һ�𲥷�
function play_new_binarual(handles) 
sound(handles.single_binarual,handles.fs,handles.nbits);
pause(1.2);
sound(handles.double_binarual,handles.fs,handles.nbits);

%���������������������������������桪����������������������������������������������
function update_left_right_gain(handles)
set(handles.txt_left_gain,'String',num2str(handles.left_gain));
set(handles.txt_right_gain,'String',num2str(handles.right_gain));

%�������������������Կ�ʼʱ����ť״̬����������������������������������������������
function test_start_btn_state(handles)
set(handles.btn_start_test,'Enable','off');
set(handles.btn_left,'Enable','on');
set(handles.btn_right,'Enable','on');
set(handles.btn_cannot_judge,'Enable','on');
set(handles.btn_restart_play,'Enable','on');

%�������������������Խ���ʱ����ť״̬����������������������������������������������
function test_end_btn_state(handles)
set(handles.btn_start_test,'Enable','on');
set(handles.btn_left,'Enable','off');
set(handles.btn_right,'Enable','off');
set(handles.btn_cannot_judge,'Enable','off');
set(handles.btn_restart_play,'Enable','off');

%�����������������������Դ˫���źš�����������������������������������������������
function output_single_binarual(handles)
file_name=[ handles.listener_name '_s_b_' num2str(handles.selected_single_azi) '_' handles.input_file_name];
handles.single_binarual_name=file_name;
file_name=[handles.output_file_path file_name];
wavwrite(handles.single_binarual,handles.fs,handles.nbits,file_name);

%�������������������˫��Դ˫���źš�����������������������������������������������
function output_double_binarual(handles,position)
file_name=[handles.listener_name '_d_b_' num2str(handles.selected_left_azi) '_' num2str(handles.selected_right_azi)...
    '_' num2str(handles.current_count) '_' position  '_' handles.input_file_name];
handles.double_binarual_name=file_name;
file_name=[handles.output_file_path file_name];
wavwrite(handles.double_binarual,handles.fs,handles.nbits,file_name);

%����������������������Ի�����Ϣ��excel���С�����������������������������������
function basicinfo2excel(handles)
xlRange={'B3','B4','B5','B6','B7'};
data={handles.listener_name,handles.test_audio_name,num2str(handles.selected_single_azi),num2str(handles.selected_left_azi),num2str(handles.selected_right_azi)};
for i=1:length(xlRange)
    xlswrite(handles.xls_file_name,data(i),handles.sheet,xlRange{i});
end

%���������������������λ�жϵ���Ϣ��excel��ȥ��������������������������������
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
