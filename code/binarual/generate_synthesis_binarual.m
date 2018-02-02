%�������������ϳ����������˫���ź�
%wav_file_name: ������wav�ļ���
%subject_index:

%function binarual=generate_synthesis_binarual(wav_file_name,subject_index,source_theta,speaker_theta)
clear all;
hrtf_path='..\hrtf\';
addpath(genpath(hrtf_path))
subbands_path='..\subbands\';
addpath(genpath(subbands_path));


wav_file_name='../input/whitenoise/whitenoise_0dB.wav';
subject_index=1;
source_theta=[0,0];
speaker_theta=[-30,0;30,0;0,22.5];

[wav_data fs nbits]=wavread(wav_file_name);
wav_data_len=length(wav_data);
gain=calcu_speaker_gain(subject_index,source_theta,speaker_theta);

source_hrtf=get_hrtf(subject_index,source_theta(1),source_theta(2));
sp1_hrtf=get_hrtf(subject_index,speaker_theta(1,1),speaker_theta(1,2));
sp2_hrtf=get_hrtf(subject_index,speaker_theta(2,1),speaker_theta(2,2));
sp3_hrtf=get_hrtf(subject_index,speaker_theta(3,1),speaker_theta(3,2));

%25�Ӵ����ַ�ʽ ���Ӵ�����ʼ������� �� ��ֹ�������
%1024��fft�任������߳���Գƣ�ֻȡǰ513�����߼��ɣ����е�512��511..�����ߺ�514,515...������
%ʵ����ͬ,�鲿��Ϊ�෴��
start_index=[1 4 6 8 11 13 16 19 23 27 31 36 41 48 55 64 75 87 104 125 150 180 222 280 361];
end_index= [3 5 7 10 12 15 18 22 26 30 35 40 47 54 63 74 86 103 124 149 179 221 279 360 513];
subbands_num=length(start_index);

%�ϳ�hrtf
sp1_syn_hrir=zeros(1024,2);
sp2_syn_hrir=zeros(1024,2);
sp3_syn_hrir=zeros(1024,2);

for n=1:subbands_num
    istart=start_index(n);
    iend=end_index(n);
    for j=istart:iend
        sp1_syn_hrir(j,:)=gain(1,n)*(sp1_hrtf(j,:));
        sp2_syn_hrir(j,:)=gain(2,n)*(sp2_hrtf(j,:));
        sp3_syn_hrir(j,:)=gain(3,n)*(sp3_hrtf(j,:));
    end
end

%flipud �����鵹��imag(***)*i ǰ��Ĵ����в��ܳ���i������matlab�����Ϊ�˷�����
sp1_syn_hrir(514:1024,:)=flipud( real(sp1_syn_hrir(2:512,:))-imag(sp1_syn_hrir(2:512,:))*i);
sp2_syn_hrir(514:1024,:)=flipud( real(sp2_syn_hrir(2:512,:))-imag(sp2_syn_hrir(2:512,:))*i);
sp3_syn_hrir(514:1024,:)=flipud( real(sp3_syn_hrir(2:512,:))-imag(sp3_syn_hrir(2:512,:))*i);

%����������Ȩ���hrtf����ifft�任��ʱ��
sp1_syn_hrir=ifft(sp1_syn_hrir,1024);
sp2_syn_hrir=ifft(sp2_syn_hrir,1024);
sp3_syn_hrir=ifft(sp3_syn_hrir,1024);

sp1_syn_binarual=zeros(wav_data_len,2);
sp2_syn_binarual=zeros(wav_data_len,2);
sp3_syn_binarual=zeros(wav_data_len,2);

for n=1:2
    sp1_syn_binarual(:,n)=filter(sp1_syn_hrir(:,n),1,wav_data);
    sp2_syn_binarual(:,n)=filter(sp2_syn_hrir(:,n),1,wav_data);
    sp3_syn_binarual(:,n)=filter(sp3_syn_hrir(:,n),1,wav_data);
end
%



%end