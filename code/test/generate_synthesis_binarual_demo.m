clc;
clear all;

parent_path='..\';
addpath(genpath(parent_path));
initpath();

wav_file_name='../input/whitenoise/whitenoise_0dB.wav';
output_wav_file_name='../output/three/whitenoise_0dB.wav';
subject_index=1;
source_theta=[0,0];
speaker_theta=[-80,0;80,0;0,22.5];
type=513;
generate_synthesis_binarual(wav_file_name,subject_index,source_theta,speaker_theta,type,output_wav_file_name);
