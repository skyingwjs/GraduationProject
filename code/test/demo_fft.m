clc;
clear all;
wav_file_name='E:\Matlab\时频变换\es01.wav';
% x=1:2048;
% x=x';
[x fs nbits]=wavread(wav_file_name);

% [fx,fpad] = linframe(x,512,1024,'sym');
% fx = winit(fx,'kbdwin'); % kbd win is TDAC  加窗
% FX = mdct4(fx);%mdct变换
% fy = imdct4(FX);%mdct 反变换
% fy = winit(fy,'kbdwin'); % rewindow 去窗
% y  = linunframe(fy,512,fpad); % OLA  帧回归---->vector
% e  = mean((x-y).^2);% so our error for mdct4
% sound(y,fs,nbits);

[fx,fpad] = linframe(x,512,1024,'sym');
fx = winit(fx,'kbdwin'); % kbd win is TDAC  加窗
FX = fft(fx);%fft变换   每列为一帧
fy = ifft(FX);%fft 反变换  每列为一帧
fy = winit(fy,'kbdwin'); % rewindow 去窗
y  = linunframe(fy,512,fpad); % OLA  帧回归---->vector
e  = mean((x-y).^2);% so our error for mdct4
sound(y,fs,nbits);

% subbands=subband_divide_1024(FX);%子带划分



