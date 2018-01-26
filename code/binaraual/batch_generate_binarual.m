%����������������wav�ļ���������Դazi��������������azi��������˫���źš�����������������
function batch_generate_binarual(wav_file_name,subject_index,azi_single,azi_loudspeaker,left_gain_vector,right_gain_vector)
%��������������˫��Դ˫���ź����·������������������������������������������������������
binarual_signal_path='.\binarualsignal\';

%���������������ݵ���Դazi��˫��Դ������������azi  �����ļ������������������������������� 
folder_name=['b_',num2str(azi_single),'_', num2str(azi_loudspeaker(1)),'_', num2str(azi_loudspeaker(2))];
binarual_signal_path=[binarual_signal_path,folder_name,'\'];


%�����������������ļ��С�������������������������������������������������������������������
mkdir(binarual_signal_path);
%���������������ȱ���left_gain_vector right_gain_vector    ��ָ�����ļ�����
save ([binarual_signal_path, 'left_gain_vector'],'left_gain_vector') ;
save ([binarual_signal_path, 'right_gain_vector'],'right_gain_vector') ;

%��������������ȡԭʼ��Ƶ�ļ�������������������������������������������������
[wav_data, fs, nbits]=wavread(wav_file_name);

%���������������ɵ���Դ˫���źš�����������������������������������������������������������
single_binarual=generate_single_binarual(wav_data,subject_index,azi_single);
file_name=[binarual_signal_path 's_b_' num2str(azi_single) '_' wav_file_name];
wavwrite(single_binarual,fs,nbits,file_name);

%������������VBAP��ȡ��ʼ���桪������������������������������������������������������������
% init_gain= get_init_gain(azi_loudspeaker,azi_single);

%�������������õ��������桪����������������������������������������������������������������
% [left_gain_vector ,right_gain_vector]=get_left_right_gain_vector(init_gain);


%��ÿ������������˫��Դ˫���ź�
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


