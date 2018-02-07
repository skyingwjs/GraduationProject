%批量生成单声源双耳信号及扬声器合成的双耳信号


single_binarual_path='..\output\single\';
synthesis_binarual_path='..\output\three\';
hrtf_path='..\hrtf\';
addpath(genpath(hrtf_path));
subbands_path='..\subbands\';
addpath(genpath(subbands_path));
input_path='..\input\';
addpath(genpath(input_path));


subject_index=1;
subbands_type=25;
wav_file_name='whitenoise_0dB.wav';
[source_theta speaker_theta]=get_source_speaker_group();
source_num=length(source_theta);

for n=1:source_num
    s_theta=source_theta(n,:);
    sp_theta=speaker_theta(3*n-2:3*n,:);
    
    single_binarual_file_name=strcat(single_binarual_path,'single_',num2str(s_theta(1)),'_',num2str(s_theta(2)),'_',wav_file_name);
    synthesis_binarual_file_name=strcat(synthesis_binarual_path,'synthesis_',num2str(s_theta(1)),'_',num2str(s_theta(2)),'_',wav_file_name);
     
    generate_single_binarual(wav_file_name,subject_index,s_theta(1),s_theta(2),single_binarual_file_name);
    generate_synthesis_binarual(wav_file_name,subject_index,s_theta,sp_theta,subbands_type,synthesis_binarual_file_name);
    
end


