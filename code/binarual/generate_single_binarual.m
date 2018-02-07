% wav_file_name ����ĵ�����wav�ļ���
% subject_index CIPIC���е�subject index
% azimuth �������ɵ���������ķ�λ�ǣ�ֻ����CIPIC���д���HRIR���ݵķ�λ��
% elevation �������ɵ���������ĸ߶Ƚǣ�ֻ����CIPIC���д���HRIR���ݵĸ߶Ƚ�
% binarual_file_name �������Դ˫���źŵ�wav�ļ���

function single_binarual=generate_single_binarual(wav_file_name,subject_index,azimuth,elevation,binarual_file_name)

[wav_data fs nbits]=wavread(wav_file_name);

azimuth_cipic = [-80 -65 -55 -45:5:45 55 65 80];%azimuth(13)==0 
azimuth_index=find(azimuth_cipic==azimuth);%��÷�λ����CIPIC���ж�Ӧ�ĵ�����ֵ

elevation_cipic=-45:360/64:235;
elevation_index=find(elevation_cipic==elevation);%��ø߶Ƚ���CIPIC���ж�Ӧ�ĵ�����ֵ

%��ȡhrir����
hrir_l= read_cipic_hrir(subject_index,azimuth_index,elevation_index,'l');
hrir_r= read_cipic_hrir(subject_index,azimuth_index,elevation_index,'r');

%�˲�����˫���źţ��൱�ھ������
binarual_l=filter(hrir_l,1,wav_data);
binarual_r=filter(hrir_r,1,wav_data);

single_binarual=[binarual_l binarual_r];

wavwrite(single_binarual,fs,binarual_file_name);

end