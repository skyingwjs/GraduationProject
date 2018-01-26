function single_binarual=generate_single_binarual(wav_data,subject_index,azimuth)
%�������������������뵥������Ƶ����wav_data  ��λ��azimuth ���ɶ�Ӧ��λ��˫���ź�
%�����������������߶Ƚ�  Ĭ��Ϊ0
%��������������������single_binarual��single_binarual(1)��ʾ����źţ�single_binarual(2)��ʾ�Ҷ��ź�
azimuth_cipic = [-80 -65 -55 -45:5:45 55 65 80];%azimuth(13)==0 
azimuth_index=find(azimuth_cipic==azimuth);%��ȡ15�ȷ�λ�� ������ֵ

elevation_cipic=-45:360/64:235;
elevation=0;
elevation_index=find(elevation_cipic==elevation);%��ȡ0�ȸ߶Ƚ� ������ֵ

% subject_index=1;%cipic subject������
%��ȡazimuth=15��elevation=0�� hrir����
hrtf_l= read_cipic_hrtf(subject_index,azimuth_index,elevation_index,'l');
hrtf_r= read_cipic_hrtf(subject_index,azimuth_index,elevation_index,'r');
%�������˫���ź�
binarual_l=filter(hrtf_l,1,wav_data);
binarual_r=filter(hrtf_r,1,wav_data);
single_binarual=[binarual_l binarual_r];
end