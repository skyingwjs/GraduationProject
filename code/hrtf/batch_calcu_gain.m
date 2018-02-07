clc;
clear all;

subbands_path='..\subbands';
addpath(genpath(subbands_path));

utils_path='..\utils';
addpath(genpath(utils_path));

gain_path='..\output\gain\';
addpath(genpath(gain_path));


%扬声器分组方位
position={'front';'front';'left';'left';'right';'right';'back';'back';'up';'up'};

subject_index=1;
[source_theta,speaker_theta]=get_source_speaker_group();
start_end_index=subbands_type(25);

%原始声源的个数
source_num=length(source_theta);


for n=1:source_num
    s_theta=source_theta(n,:);
    sp_theta=speaker_theta(3*n-2:3*n,:);
    gain=calcu_speaker_gain(subject_index,s_theta,sp_theta,start_end_index);
    gain_file_name= strcat(gain_path,position{n},'_',num2str(s_theta(1)),'_',num2str(s_theta(2)),'.txt');   
    mat2txt(gain_file_name,gain);
end 







