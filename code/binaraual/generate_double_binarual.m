function  [double_binarual]=generate_double_binarual(wav_data,subject_index,azi_loudspeaker,gain_factor)
%�������������������뵥������Ƶ���� �����������ķ�λ�ǣ��������� �������������˫���źš���������������
%�������������������룺azi_loudspeaker=[left_loudspeaker_azi,right_loudspeaker_azi]������������������
%�������������������룺gain_factor=[left_gain,right_gain]����������������������������������������������
frame_size=1024;
frame_number = floor(length(wav_data) / frame_size);

azimuth_cipic = [-80 -65 -55 -45:5:45 55 65 80];%azimuth(13)==0 
for i=1:length(azi_loudspeaker)
    azimuth_index(i)=find(azimuth_cipic==azi_loudspeaker(i));
end

elevation_cipic=-45:360/64:235;
elevation=0;%�߶Ƚ�Ĭ��λ0
for i=1:length(azi_loudspeaker)
    elevation_index(i)=find(elevation_cipic==elevation);%��ȡ0�ȸ߶Ƚ� ������ֵ
end

% subject_index=1;%cipic subject������
gl=gain_factor(1);
gr=gain_factor(2);

%%����HRTF����
hrtf_loudspeaker_ll= read_cipic_hrtf(subject_index,azimuth_index(1),elevation_index(1),'l');%�����������hrir����
hrtf_loudspeaker_lr=  read_cipic_hrtf(subject_index,azimuth_index(1),elevation_index(1),'r');%���������Ҷ�hrir����
hrtf_loudspeaker_rl= read_cipic_hrtf(subject_index,azimuth_index(2),elevation_index(2),'l');%�����������hrir����
hrtf_loudspeaker_rr=  read_cipic_hrtf(subject_index,azimuth_index(2),elevation_index(2),'r');  %���������Ҷ�hrir����  
%%�����������ź� ���Զ�Ӧ������
data_l = wav_data * gl;
data_r = wav_data * gr;

%%�������������γɵ�˫���ź�
out_ll = zeros(length(wav_data),1); %% LL��������������������ź�
out_lr = zeros(length(wav_data),1); %% LR���������������Ҷ����ź�
out_rl = zeros(length(wav_data),1);
out_rr = zeros(length(wav_data),1);
%�������˫���ź�
out_ll= filter(hrtf_loudspeaker_ll,1,data_l);
out_lr= filter(hrtf_loudspeaker_lr,1,data_l);
out_rl= filter(hrtf_loudspeaker_rl,1,data_r);
out_rr= filter(hrtf_loudspeaker_rr,1,data_r);

%���Է�֡--�Ӵ��任---Ƶ����� ---���任��ʱ��--- ȥ��--- ��Ϊһά������ʽ
[frames_data_ll,fpad_ll] = linframe(out_ll,512,1024,'sym');%���Է�֡
frames_data_win_ll = winit(frames_data_ll,'kbdwin');      % kbd win is TDAC  �Ӵ�
fft_spectrum_data_ll = fft(frames_data_win_ll);           %fft�任   ÿ��Ϊһ֡

[frames_data_lr,fpad_lr] = linframe(out_lr,512,1024,'sym');%���Է�֡
frames_data_win_lr = winit(frames_data_lr,'kbdwin');      % kbd win is TDAC  �Ӵ�
fft_spectrum_data_lr = fft(frames_data_win_lr);           %fft�任   ÿ��Ϊһ֡

[frames_data_rl,fpad_rl] = linframe(out_rl,512,1024,'sym');%���Է�֡
frames_data_win_rl = winit(frames_data_rl,'kbdwin');      % kbd win is TDAC  �Ӵ�
fft_spectrum_data_rl = fft(frames_data_win_rl);           %fft�任   ÿ��Ϊһ֡

[frames_data_rr,fpad_rr] = linframe(out_rr,512,1024,'sym');%���Է�֡
frames_data_win_rr = winit(frames_data_rr,'kbdwin');      % kbd win is TDAC  �Ӵ�
fft_spectrum_data_rr = fft(frames_data_win_rr);           %fft�任   ÿ��Ϊһ֡


ifft_time_data_l = ifft(fft_spectrum_data_ll+fft_spectrum_data_rl); %fft ���任  ÿ��Ϊһ֡
ifft_time_data_r = ifft(fft_spectrum_data_lr+fft_spectrum_data_rr); %fft ���任  ÿ��Ϊһ֡
time_data_rewin_l = winit(ifft_time_data_l,'kbdwin');      % rewindow ȥ��
time_data_rewin_r = winit(ifft_time_data_r,'kbdwin');      % rewindow ȥ��

fpad=fpad_ll;%�ر�ע��
re_wav_data_l  = linunframe(time_data_rewin_l,512,fpad); % OLA  ֡�ع�---->vector
re_wav_data_r  = linunframe(time_data_rewin_r,512,fpad); % OLA  ֡�ع�---->vector

double_binarual=[re_wav_data_l re_wav_data_r];
end