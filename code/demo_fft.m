clc;
clear all;
wav_file_name='E:\Matlab\ʱƵ�任\es01.wav';
% x=1:2048;
% x=x';
[x fs nbits]=wavread(wav_file_name);

% [fx,fpad] = linframe(x,512,1024,'sym');
% fx = winit(fx,'kbdwin'); % kbd win is TDAC  �Ӵ�
% FX = mdct4(fx);%mdct�任
% fy = imdct4(FX);%mdct ���任
% fy = winit(fy,'kbdwin'); % rewindow ȥ��
% y  = linunframe(fy,512,fpad); % OLA  ֡�ع�---->vector
% e  = mean((x-y).^2);% so our error for mdct4
% sound(y,fs,nbits);

[fx,fpad] = linframe(x,512,1024,'sym');
fx = winit(fx,'kbdwin'); % kbd win is TDAC  �Ӵ�
FX = fft(fx);%fft�任   ÿ��Ϊһ֡
fy = ifft(FX);%fft ���任  ÿ��Ϊһ֡
fy = winit(fy,'kbdwin'); % rewindow ȥ��
y  = linunframe(fy,512,fpad); % OLA  ֡�ع�---->vector
e  = mean((x-y).^2);% so our error for mdct4
sound(y,fs,nbits);

% subbands=subband_divide_1024(FX);%�Ӵ�����



