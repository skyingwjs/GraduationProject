%generate_synthesis_binarual生成由三扬声器频域加权后合成的双耳信号
%wav_file_name:输入的单声道wav文件名
%subject_index:CIPIC 库subject index
%source_theta: 原始声源的方位角source_theta(1)，高度角source_theta(2)
%speaker_theta:扬声器的方位角高度角,speaker_theta(i,1)表示第i个扬声器的方位角，speaker_theta(i,2)表示第i个扬声器的高度角
%type:子带划分类型
%binarual_file_name:合成的双耳信号wav


function binarual=generate_synthesis_binarual(wav_file_name,subject_index,source_theta,speaker_theta,type,binarual_file_name)



%添加被调用函数相关路径
hrtf_path='..\hrtf\';
addpath(genpath(hrtf_path))
subbands_path='..\subbands\';
addpath(genpath(subbands_path));
tf_path='..\tf\';
addpath(genpath(tf_path))

%临时测试数据
% wav_file_name='../input/whitenoise/whitenoise_0dB.wav';
% output_wav_file_name='../output/three/whitenoise_0dB.wav';
% subject_index=1;
% source_theta=[0,0];
% speaker_theta=[-80,0;80,0;0,22.5];
% type=513;

%读取wav数据
[wav_data fs nbits]=wavread(wav_file_name);
wav_data_len=length(wav_data);

%计算三扬声器合成虚拟声像的 频域调制系数
start_end_index=subbands_type(type);
gain=calcu_speaker_gain(subject_index,source_theta,speaker_theta,start_end_index);

%读取虚拟声像和扬声器个方位处的hrtf
source_hrtf=get_hrtf(subject_index,source_theta(1),source_theta(2));
sp1_hrtf=get_hrtf(subject_index,speaker_theta(1,1),speaker_theta(1,2));
sp2_hrtf=get_hrtf(subject_index,speaker_theta(2,1),speaker_theta(2,2));
sp3_hrtf=get_hrtf(subject_index,speaker_theta(3,1),speaker_theta(3,2));

%各子带的起始谱线序号 和 终止谱线序号
%1024点fft变换后的谱线（复数）对称，只取前513根谱线即可，其中第512，511..根谱线和514,515...根谱线
%实部相同,虚部互为相反数
start_index=start_end_index(:,1);
end_index=start_end_index(:,2);
subbands_num=length(start_index);


%频域加权后的左右耳hrtf
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

%flipud 将数组倒序，imag(***)*i 前面的代码中不能出现i，否则matlab会理解为乘法计算
sp1_syn_hrir(514:1024,:)=flipud( real(sp1_syn_hrir(2:512,:))-imag(sp1_syn_hrir(2:512,:))*i);
sp2_syn_hrir(514:1024,:)=flipud( real(sp2_syn_hrir(2:512,:))-imag(sp2_syn_hrir(2:512,:))*i);
sp3_syn_hrir(514:1024,:)=flipud( real(sp3_syn_hrir(2:512,:))-imag(sp3_syn_hrir(2:512,:))*i);

%各扬声器加权后的hrtf进行ifft变换到时域得到加权后的hrir
sp1_syn_hrir=ifft(sp1_syn_hrir,1024);
sp2_syn_hrir=ifft(sp2_syn_hrir,1024);
sp3_syn_hrir=ifft(sp3_syn_hrir,1024);

sp1_syn_binarual=zeros(wav_data_len,2);
sp2_syn_binarual=zeros(wav_data_len,2);
sp3_syn_binarual=zeros(wav_data_len,2);

%wav_data与调制后的hrir卷积得到双耳信号
for n=1:2
    sp1_syn_binarual(:,n)=filter(sp1_syn_hrir(:,n),1,wav_data);
    sp2_syn_binarual(:,n)=filter(sp2_syn_hrir(:,n),1,wav_data);
    sp3_syn_binarual(:,n)=filter(sp3_syn_hrir(:,n),1,wav_data);
end

%双耳信号 线性分帧--加窗变换---频域叠加 ---反变换到时域--- 去窗--- 变为一维向量形式
[sp1_binarual_frames_l ,sp1_fpad_l]=linframe(sp1_syn_binarual(:,1),512,1024,'sym');%sp1 左耳信号
sp1_binarual_frames_l_win = winit(sp1_binarual_frames_l,'kbdwin');      % kbd win is TDAC  加窗
sp1_binarual_frames_l_freq = fft(sp1_binarual_frames_l_win);           %fft变换   每列为一帧

[sp1_binarual_frames_r ,sp1_fpad_r]=linframe(sp1_syn_binarual(:,2),512,1024,'sym');%sp1 右耳信号
sp1_binarual_frames_r_win = winit(sp1_binarual_frames_r,'kbdwin');      % kbd win is TDAC  加窗
sp1_binarual_frames_r_freq = fft(sp1_binarual_frames_r_win); 

[sp2_binarual_frames_l ,sp2_fpad_l]=linframe(sp2_syn_binarual(:,1),512,1024,'sym');%sp2 左耳信号
sp2_binarual_frames_l_win = winit(sp2_binarual_frames_l,'kbdwin');      % kbd win is TDAC  加窗
sp2_binarual_frames_l_freq = fft(sp2_binarual_frames_l_win); 

[sp2_binarual_frames_r ,sp2_fpad_r]=linframe(sp2_syn_binarual(:,2),512,1024,'sym');%sp2 右耳信号
sp2_binarual_frames_r_win = winit(sp2_binarual_frames_r,'kbdwin');      % kbd win is TDAC  加窗
sp2_binarual_frames_r_freq = fft(sp2_binarual_frames_r_win); 

[sp3_binarual_frames_l ,sp3_fpad_l]=linframe(sp3_syn_binarual(:,1),512,1024,'sym');%sp3 左耳信号
sp3_binarual_frames_l_win = winit(sp3_binarual_frames_l,'kbdwin');      % kbd win is TDAC  加窗
sp3_binarual_frames_l_freq = fft(sp3_binarual_frames_l_win); 

[sp3_binarual_frames_r ,sp3_fpad_r]=linframe(sp3_syn_binarual(:,2),512,1024,'sym');%sp3 右耳信号
sp3_binarual_frames_r_win = winit(sp3_binarual_frames_r,'kbdwin');      % kbd win is TDAC  加窗
sp3_binarual_frames_r_freq = fft(sp3_binarual_frames_r_win); 

%频域叠加
ifft_time_data_l = ifft(sp1_binarual_frames_l_freq+sp2_binarual_frames_l_freq+sp3_binarual_frames_l_freq); %fft 反变换  每列为一帧
ifft_time_data_r = ifft(sp1_binarual_frames_r_freq+sp2_binarual_frames_r_freq+sp3_binarual_frames_r_freq); %fft 反变换  每列为一帧

time_data_rewin_l = winit(ifft_time_data_l,'kbdwin');      % rewindow 去窗
time_data_rewin_r = winit(ifft_time_data_r,'kbdwin');      % rewindow 去窗

fpad=sp1_fpad_l;%特别注意
re_wav_data_l  = linunframe(time_data_rewin_l,512,fpad); % OLA  帧回归---->vector
re_wav_data_r  = linunframe(time_data_rewin_r,512,fpad); % OLA  帧回归---->vector

%合成双耳信号
syn_binarual=[re_wav_data_l re_wav_data_r];

wavwrite(syn_binarual,fs,binarual_file_name);

end