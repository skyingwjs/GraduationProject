%������������˫��wavfile ·��  ���Ÿ�·���µ�����˫��Դ˫��wav�ļ�����������������
function batch_play_wavfile(base_path)
folder_path=[base_path '*.wav'];
%��ȡ˫���ź��ļ���
[s_filename,d_filenames]=get_s_d_filenames(folder_path);

[single_wav_data,fs,nbits]=wavread([base_path,s_filename{1}]);
for i=1:length(d_filenames)
    sound(single_wav_data,fs,nbits);
    pause(1.2)
    [double_wav_data,fs,nbits]=wavread([base_path,d_filenames{i}]);
    sound(double_wav_data,fs,nbits);
    pause(2)
end