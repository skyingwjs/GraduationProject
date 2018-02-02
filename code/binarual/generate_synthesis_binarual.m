%用三个扬声器合成虚拟声像的双耳信号
%wav_file_name: 单声道wav文件名
%subject_index:

%function binarual=generate_synthesis_binarual(wav_file_name,subject_index,source_theta,speaker_theta)
clear all;
hrtf_path='..\hrtf\';
addpath(genpath(hrtf_path))
subbands_path='..\subbands\';
addpath(genpath(subbands_path));


wav_file_name='../input/whitenoise/whitenoise_0dB.wav';
subject_index=1;
source_theta=[0,0];
speaker_theta=[-30,0;30,0;0,22.5];

[wav_data fs nbits]=wavread(wav_file_name);
wav_data_len=length(wav_data);
gain=calcu_speaker_gain(subject_index,source_theta,speaker_theta);

source_hrtf=get_hrtf(subject_index,source_theta(1),source_theta(2));
sp1_hrtf=get_hrtf(subject_index,speaker_theta(1,1),speaker_theta(1,2));
sp2_hrtf=get_hrtf(subject_index,speaker_theta(2,1),speaker_theta(2,2));
sp3_hrtf=get_hrtf(subject_index,speaker_theta(3,1),speaker_theta(3,2));

%25子带划分方式 各子带的起始谱线序号 和 终止谱线序号
%1024点fft变换后的谱线成奇对称，只取前513根谱线即可，其中第512，511..根谱线和514,515...根谱线
%实部相同,虚部互为相反数
start_index=[1 4 6 8 11 13 16 19 23 27 31 36 41 48 55 64 75 87 104 125 150 180 222 280 361];
end_index= [3 5 7 10 12 15 18 22 26 30 35 40 47 54 63 74 86 103 124 149 179 221 279 360 513];
subbands_num=length(start_index);

%合成hrtf
sp1_syn_hrir=zeros(1024,2);
sp2_syn_hrir=zeros(1024,2);
sp3_syn_hrir=zeros(1024,2);

for n=1:subbands_num
    istart=start_index(n);
    iend=end_index(n);
    for j=istart:iend
        sp1_syn_hrir(j,:)=gain(1,n)*(sp1_hrtf(j,:));
        sp2_syn_hrir(j,:)=gain(2,n)*(sp2_hrtf(j,:));
        sp3_syn_hrir(j,:)=gain(3,n)*(sp3_hrtf(j,:));
    end
end

%flipud 将数组倒序，imag(***)*i 前面的代码中不能出现i，否则matlab会理解为乘法计算
sp1_syn_hrir(514:1024,:)=flipud( real(sp1_syn_hrir(2:512,:))-imag(sp1_syn_hrir(2:512,:))*i);
sp2_syn_hrir(514:1024,:)=flipud( real(sp2_syn_hrir(2:512,:))-imag(sp2_syn_hrir(2:512,:))*i);
sp3_syn_hrir(514:1024,:)=flipud( real(sp3_syn_hrir(2:512,:))-imag(sp3_syn_hrir(2:512,:))*i);

%各扬声器加权后的hrtf进行ifft变换到时域
sp1_syn_hrir=ifft(sp1_syn_hrir,1024);
sp2_syn_hrir=ifft(sp2_syn_hrir,1024);
sp3_syn_hrir=ifft(sp3_syn_hrir,1024);

sp1_syn_binarual=zeros(wav_data_len,2);
sp2_syn_binarual=zeros(wav_data_len,2);
sp3_syn_binarual=zeros(wav_data_len,2);

for n=1:2
    sp1_syn_binarual(:,n)=filter(sp1_syn_hrir(:,n),1,wav_data);
    sp2_syn_binarual(:,n)=filter(sp2_syn_hrir(:,n),1,wav_data);
    sp3_syn_binarual(:,n)=filter(sp3_syn_hrir(:,n),1,wav_data);
end
%



%end