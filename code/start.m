clear all;
clc;
initpath();  

input_noise_path='./input/whitenoise/'
output_single_path='./output/single/';
output_double_path='./output/double/';
output_three_path= './output/three/';

wav_file_name=strcat(input_noise_path,'whitenoise_0dB.wav');
binarual_file_name=strcat(output_single_path ,'s_0_0_whitenoise_0dB.wav');

generate_single_binarual(wav_file_name,1,80,0,binarual_file_name);
