clear all;
clc;
initpath();  
generate_flag=0;
play_flag=0;
sub_num={'003';'017';'018';'019';'033';'040';'155'};
subject_index= get_subject_index('017');

% sub_num(7)
% for i=1:length(sub_num)
%     subject_index_list(i)= get_subject_index('155');
% end
% 
% subject_index=subject_index_list(1);


if generate_flag==1
    wav_file_name='whitenoise_0dB.wav';
    azi_single=0:5:25;
    azi_loudspeaker=[-25 25];
    for i=1:length(azi_single)
        batch_generate_binarual(wav_file_name,subject_index,azi_single(i),azi_loudspeaker);
    end
end

if play_flag==1
    base_path='.\binarualsignal\b_0_-25_25\';
    batch_play_wavfile(base_path);
end

if play_flag==2
    base_path='.\binarualsignal\b_5_-25_25\';
    batch_play_wavfile(base_path);
end
if play_flag==3
    base_path='.\binarualsignal\b_10_-25_25\';
    batch_play_wavfile(base_path);
end

if play_flag==4
    base_path='.\binarualsignal\b_15_-25_25\';
    batch_play_wavfile(base_path);
end

if play_flag==5
    base_path='.\binarualsignal\b_20_-25_25\';
    batch_play_wavfile(base_path);
end
if play_flag==6
    base_path='.\binarualsignal\b_25_-25_25\';
    batch_play_wavfile(base_path);
end
