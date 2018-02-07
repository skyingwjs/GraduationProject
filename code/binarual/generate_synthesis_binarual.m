%generate_synthesis_binarual��������������Ƶ���Ȩ��ϳɵ�˫���ź�
%wav_file_name:����ĵ�����wav�ļ���
%subject_index:CIPIC ��subject index
%source_theta: ԭʼ��Դ�ķ�λ��source_theta(1)���߶Ƚ�source_theta(2)
%speaker_theta:�������ķ�λ�Ǹ߶Ƚ�,speaker_theta(i,1)��ʾ��i���������ķ�λ�ǣ�speaker_theta(i,2)��ʾ��i���������ĸ߶Ƚ�
%type:�Ӵ���������
%binarual_file_name:�ϳɵ�˫���ź�wav


function binarual=generate_synthesis_binarual(wav_file_name,subject_index,source_theta,speaker_theta,type,binarual_file_name)



%��ӱ����ú������·��
hrtf_path='..\hrtf\';
addpath(genpath(hrtf_path))
subbands_path='..\subbands\';
addpath(genpath(subbands_path));
tf_path='..\tf\';
addpath(genpath(tf_path))

%��ʱ��������
% wav_file_name='../input/whitenoise/whitenoise_0dB.wav';
% output_wav_file_name='../output/three/whitenoise_0dB.wav';
% subject_index=1;
% source_theta=[0,0];
% speaker_theta=[-80,0;80,0;0,22.5];
% type=513;

%��ȡwav����
[wav_data fs nbits]=wavread(wav_file_name);
wav_data_len=length(wav_data);

%�������������ϳ���������� Ƶ�����ϵ��
start_end_index=subbands_type(type);
gain=calcu_speaker_gain(subject_index,source_theta,speaker_theta,start_end_index);

%��ȡ�������������������λ����hrtf
source_hrtf=get_hrtf(subject_index,source_theta(1),source_theta(2));
sp1_hrtf=get_hrtf(subject_index,speaker_theta(1,1),speaker_theta(1,2));
sp2_hrtf=get_hrtf(subject_index,speaker_theta(2,1),speaker_theta(2,2));
sp3_hrtf=get_hrtf(subject_index,speaker_theta(3,1),speaker_theta(3,2));

%���Ӵ�����ʼ������� �� ��ֹ�������
%1024��fft�任������ߣ��������Գƣ�ֻȡǰ513�����߼��ɣ����е�512��511..�����ߺ�514,515...������
%ʵ����ͬ,�鲿��Ϊ�෴��
start_index=start_end_index(:,1);
end_index=start_end_index(:,2);
subbands_num=length(start_index);


%Ƶ���Ȩ������Ҷ�hrtf
sp1_syn_hrir=zeros(1024,2);
sp2_syn_hrir=zeros(1024,2);
sp3_syn_hrir=zeros(1024,2);

for n=1:subbands_num
    istart=start_index(n);
    iend=end_index(n);
    for j=istart:iend
        sp1_syn_hrir(j,:)=gain(n,1)*(sp1_hrtf(j,:));
        sp2_syn_hrir(j,:)=gain(n,2)*(sp2_hrtf(j,:));
        sp3_syn_hrir(j,:)=gain(n,3)*(sp3_hrtf(j,:));
    end
end

%flipud �����鵹��imag(***)*i ǰ��Ĵ����в��ܳ���i������matlab�����Ϊ�˷�����
sp1_syn_hrir(514:1024,:)=flipud( real(sp1_syn_hrir(2:512,:))-imag(sp1_syn_hrir(2:512,:))*i);
sp2_syn_hrir(514:1024,:)=flipud( real(sp2_syn_hrir(2:512,:))-imag(sp2_syn_hrir(2:512,:))*i);
sp3_syn_hrir(514:1024,:)=flipud( real(sp3_syn_hrir(2:512,:))-imag(sp3_syn_hrir(2:512,:))*i);

%����������Ȩ���hrtf����ifft�任��ʱ��õ���Ȩ���hrir
sp1_syn_hrir=ifft(sp1_syn_hrir,1024);
sp2_syn_hrir=ifft(sp2_syn_hrir,1024);
sp3_syn_hrir=ifft(sp3_syn_hrir,1024);

sp1_syn_binarual=zeros(wav_data_len,2);
sp2_syn_binarual=zeros(wav_data_len,2);
sp3_syn_binarual=zeros(wav_data_len,2);

%wav_data����ƺ��hrir����õ�˫���ź�
for n=1:2
    sp1_syn_binarual(:,n)=filter(sp1_syn_hrir(:,n),1,wav_data);
    sp2_syn_binarual(:,n)=filter(sp2_syn_hrir(:,n),1,wav_data);
    sp3_syn_binarual(:,n)=filter(sp3_syn_hrir(:,n),1,wav_data);
end

%˫���ź� ���Է�֡--�Ӵ��任---Ƶ����� ---���任��ʱ��--- ȥ��--- ��Ϊһά������ʽ
[sp1_binarual_frames_l ,sp1_fpad_l]=linframe(sp1_syn_binarual(:,1),512,1024,'sym');%sp1 ����ź�
sp1_binarual_frames_l_win = winit(sp1_binarual_frames_l,'kbdwin');      % kbd win is TDAC  �Ӵ�
sp1_binarual_frames_l_freq = fft(sp1_binarual_frames_l_win);           %fft�任   ÿ��Ϊһ֡

[sp1_binarual_frames_r ,sp1_fpad_r]=linframe(sp1_syn_binarual(:,2),512,1024,'sym');%sp1 �Ҷ��ź�
sp1_binarual_frames_r_win = winit(sp1_binarual_frames_r,'kbdwin');      % kbd win is TDAC  �Ӵ�
sp1_binarual_frames_r_freq = fft(sp1_binarual_frames_r_win); 

[sp2_binarual_frames_l ,sp2_fpad_l]=linframe(sp2_syn_binarual(:,1),512,1024,'sym');%sp2 ����ź�
sp2_binarual_frames_l_win = winit(sp2_binarual_frames_l,'kbdwin');      % kbd win is TDAC  �Ӵ�
sp2_binarual_frames_l_freq = fft(sp2_binarual_frames_l_win); 

[sp2_binarual_frames_r ,sp2_fpad_r]=linframe(sp2_syn_binarual(:,2),512,1024,'sym');%sp2 �Ҷ��ź�
sp2_binarual_frames_r_win = winit(sp2_binarual_frames_r,'kbdwin');      % kbd win is TDAC  �Ӵ�
sp2_binarual_frames_r_freq = fft(sp2_binarual_frames_r_win); 

[sp3_binarual_frames_l ,sp3_fpad_l]=linframe(sp3_syn_binarual(:,1),512,1024,'sym');%sp3 ����ź�
sp3_binarual_frames_l_win = winit(sp3_binarual_frames_l,'kbdwin');      % kbd win is TDAC  �Ӵ�
sp3_binarual_frames_l_freq = fft(sp3_binarual_frames_l_win); 

[sp3_binarual_frames_r ,sp3_fpad_r]=linframe(sp3_syn_binarual(:,2),512,1024,'sym');%sp3 �Ҷ��ź�
sp3_binarual_frames_r_win = winit(sp3_binarual_frames_r,'kbdwin');      % kbd win is TDAC  �Ӵ�
sp3_binarual_frames_r_freq = fft(sp3_binarual_frames_r_win); 

%Ƶ�����
ifft_time_data_l = ifft(sp1_binarual_frames_l_freq+sp2_binarual_frames_l_freq+sp3_binarual_frames_l_freq); %fft ���任  ÿ��Ϊһ֡
ifft_time_data_r = ifft(sp1_binarual_frames_r_freq+sp2_binarual_frames_r_freq+sp3_binarual_frames_r_freq); %fft ���任  ÿ��Ϊһ֡

time_data_rewin_l = winit(ifft_time_data_l,'kbdwin');      % rewindow ȥ��
time_data_rewin_r = winit(ifft_time_data_r,'kbdwin');      % rewindow ȥ��

fpad=sp1_fpad_l;%�ر�ע��
re_wav_data_l  = linunframe(time_data_rewin_l,512,fpad); % OLA  ֡�ع�---->vector
re_wav_data_r  = linunframe(time_data_rewin_r,512,fpad); % OLA  ֡�ع�---->vector

%�ϳ�˫���ź�
syn_binarual=[re_wav_data_l re_wav_data_r];

wavwrite(syn_binarual,fs,binarual_file_name);

end