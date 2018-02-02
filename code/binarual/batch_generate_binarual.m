%——————根据wav文件名，单声源azi，和左右扬声器azi批量生成双耳信号—————————
function batch_generate_binarual(wav_file_name,subject_index,azi_single,azi_loudspeaker,left_gain_vector,right_gain_vector)
%——————单双声源双耳信号输出路径——————————————————————————
binarual_signal_path='.\binarualsignal\';

%——————根据单声源azi和双声源左右扬声器的azi  生成文件夹名————————————— 
folder_name=['b_',num2str(azi_single),'_', num2str(azi_loudspeaker(1)),'_', num2str(azi_loudspeaker(2))];
binarual_signal_path=[binarual_signal_path,folder_name,'\'];


%——————创建文件夹——————————————————————————————————
mkdir(binarual_signal_path);
%——————首先保存left_gain_vector right_gain_vector    到指定的文件夹下
save ([binarual_signal_path, 'left_gain_vector'],'left_gain_vector') ;
save ([binarual_signal_path, 'right_gain_vector'],'right_gain_vector') ;

%——————读取原始音频文件————————————————————————
[wav_data, fs, nbits]=wavread(wav_file_name);

%——————生成单声源双耳信号——————————————————————————————
single_binarual=generate_single_binarual(wav_data,subject_index,azi_single);
file_name=[binarual_signal_path 's_b_' num2str(azi_single) '_' wav_file_name];
wavwrite(single_binarual,fs,nbits,file_name);

%——————VBAP获取初始增益———————————————————————————————
% init_gain= get_init_gain(azi_loudspeaker,azi_single);

%——————得到多组增益—————————————————————————————————
% [left_gain_vector ,right_gain_vector]=get_left_right_gain_vector(init_gain);


%在每组增益下生成双声源双耳信号
for i=1:length(left_gain_vector)
    gain_factor=[left_gain_vector(i) right_gain_vector(i)];
    double_binarual=generate_double_binarual(wav_data,subject_index,azi_loudspeaker,gain_factor);
    if i<=9
       file_name=[binarual_signal_path 'd_b_' num2str(azi_loudspeaker(1)) '_' num2str(azi_loudspeaker(2)) '_0' num2str(i) '_' wav_file_name]; 
    else
       file_name=[binarual_signal_path 'd_b_' num2str(azi_loudspeaker(1)) '_' num2str(azi_loudspeaker(2)) '_' num2str(i) '_' wav_file_name];
    end
    wavwrite(double_binarual,fs,nbits,file_name);
end


