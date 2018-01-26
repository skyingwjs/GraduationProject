%————————对双声源双耳信号坐能量补偿使得它与单声源双耳信号的能量相等————————————
clear all;
clc;
base_path='.\output\';
folder_path='.\output\*.wav';
[s_filename,d_filenames]=get_s_d_filenames(folder_path);
% s_filename='E:\Matlab\单双声源双耳信号对比实验\output\NERCMS_s_b_15_whitenoise_0dB.wav';
% d_filename='E:\Matlab\单双声源双耳信号对比实验\output\NERCMS_d_b_-30_30_1_left_whitenoise_0dB.wav';

[s_wav_data fs nbits]=wavread(s_filename{1});
s_energy=sum(s_wav_data.^2);
for i=1:length(d_filenames)
    [d_wav_data fs nbits]=wavread(d_filenames{i});
    d_energy=sum(d_wav_data.^2);
    %求解双声源的增益因子
    a=sqrt(sum(s_energy)/sum(d_energy));
    d_wav_data=a.*d_wav_data;
    file_name=[base_path d_filenames{i}];
    wavwrite(d_wav_data,fs, nbits,file_name);
end



% diff=sum((a.*d_wav_data).^2)-s_energy;