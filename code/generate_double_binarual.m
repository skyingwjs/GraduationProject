function  [double_binarual]=generate_double_binarual(wav_data,subject_index,azi_loudspeaker,gain_factor)
%————————输入单声道音频数据 左右扬声器的方位角，增益因子 产生虚拟声像的双耳信号————————
%————————输入：azi_loudspeaker=[left_loudspeaker_azi,right_loudspeaker_azi]—————————
%————————输入：gain_factor=[left_gain,right_gain]———————————————————————
frame_size=1024;
frame_number = floor(length(wav_data) / frame_size);

azimuth_cipic = [-80 -65 -55 -45:5:45 55 65 80];%azimuth(13)==0 
for i=1:length(azi_loudspeaker)
    azimuth_index(i)=find(azimuth_cipic==azi_loudspeaker(i));
end

elevation_cipic=-45:360/64:235;
elevation=0;%高度角默认位0
for i=1:length(azi_loudspeaker)
    elevation_index(i)=find(elevation_cipic==elevation);%获取0度高度角 的索引值
end

% subject_index=1;%cipic subject的索引
gl=gain_factor(1);
gr=gain_factor(2);

%%加载HRTF数据
hrtf_loudspeaker_ll= read_cipic_hrtf(subject_index,azimuth_index(1),elevation_index(1),'l');%左扬声器左耳hrir数据
hrtf_loudspeaker_lr=  read_cipic_hrtf(subject_index,azimuth_index(1),elevation_index(1),'r');%左扬声器右耳hrir数据
hrtf_loudspeaker_rl= read_cipic_hrtf(subject_index,azimuth_index(2),elevation_index(2),'l');%右扬声器左耳hrir数据
hrtf_loudspeaker_rr=  read_cipic_hrtf(subject_index,azimuth_index(2),elevation_index(2),'r');  %右扬声器右耳hrir数据  
%%左右扬声器信号 乘以对应的增益
data_l = wav_data * gl;
data_r = wav_data * gr;

%%计算两扬声器形成的双耳信号
out_ll = zeros(length(wav_data),1); %% LL代表左扬声器在左耳的信号
out_lr = zeros(length(wav_data),1); %% LR代表左扬声器在右耳的信号
out_rl = zeros(length(wav_data),1);
out_rr = zeros(length(wav_data),1);
%卷积生成双耳信号
out_ll= filter(hrtf_loudspeaker_ll,1,data_l);
out_lr= filter(hrtf_loudspeaker_lr,1,data_l);
out_rl= filter(hrtf_loudspeaker_rl,1,data_r);
out_rr= filter(hrtf_loudspeaker_rr,1,data_r);

%线性分帧--加窗变换---频域叠加 ---反变换到时域--- 去窗--- 变为一维向量形式
[frames_data_ll,fpad_ll] = linframe(out_ll,512,1024,'sym');%线性分帧
frames_data_win_ll = winit(frames_data_ll,'kbdwin');      % kbd win is TDAC  加窗
fft_spectrum_data_ll = fft(frames_data_win_ll);           %fft变换   每列为一帧

[frames_data_lr,fpad_lr] = linframe(out_lr,512,1024,'sym');%线性分帧
frames_data_win_lr = winit(frames_data_lr,'kbdwin');      % kbd win is TDAC  加窗
fft_spectrum_data_lr = fft(frames_data_win_lr);           %fft变换   每列为一帧

[frames_data_rl,fpad_rl] = linframe(out_rl,512,1024,'sym');%线性分帧
frames_data_win_rl = winit(frames_data_rl,'kbdwin');      % kbd win is TDAC  加窗
fft_spectrum_data_rl = fft(frames_data_win_rl);           %fft变换   每列为一帧

[frames_data_rr,fpad_rr] = linframe(out_rr,512,1024,'sym');%线性分帧
frames_data_win_rr = winit(frames_data_rr,'kbdwin');      % kbd win is TDAC  加窗
fft_spectrum_data_rr = fft(frames_data_win_rr);           %fft变换   每列为一帧


ifft_time_data_l = ifft(fft_spectrum_data_ll+fft_spectrum_data_rl); %fft 反变换  每列为一帧
ifft_time_data_r = ifft(fft_spectrum_data_lr+fft_spectrum_data_rr); %fft 反变换  每列为一帧
time_data_rewin_l = winit(ifft_time_data_l,'kbdwin');      % rewindow 去窗
time_data_rewin_r = winit(ifft_time_data_r,'kbdwin');      % rewindow 去窗

fpad=fpad_ll;%特别注意
re_wav_data_l  = linunframe(time_data_rewin_l,512,fpad); % OLA  帧回归---->vector
re_wav_data_r  = linunframe(time_data_rewin_r,512,fpad); % OLA  帧回归---->vector

double_binarual=[re_wav_data_l re_wav_data_r];
end