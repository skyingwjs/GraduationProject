clc;
clear all;

subject_index=1;
source_theta=[0,0];
speaker_theta=[-30,0;30,0;0,22.5];

gain=calcu_speaker_gain(subject_index,source_theta,speaker_theta);
