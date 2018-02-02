clc;
clear all;
hrtf_path='.\hrtf\';
addpath(genpath(hrtf_path));
hrtf=get_hrtf(1,0,0);
%hrtf·ù¶ÈÆ×
%hrtf_amplitude=2*sqrt(hrtf.*conj(hrtf));
hrtf_amplitude=abs(hrtf);
plot(1:1024,hrtf_amplitude);
axis([1,1024,0,4+])

