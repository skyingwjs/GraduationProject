%�������ɵ���Դ˫���źż��������ϳɵ�˫���ź�

%˫���źŵ����·��
single_binarual_path='..\output\single\';
synthesis_binarual_path='..\output\synthesis\';
vbap_binarual_path='..\output\vbap\';

%�������ļ����������ļ�
delete(strcat(single_binarual_path,'*.wav'));
delete(strcat(synthesis_binarual_path,'*.wav'));
delete(strcat(vbap_binarual_path,'*.wav'));

%�����Ҫ���õĺ�����·��
hrtf_path='..\hrtf\';
addpath(genpath(hrtf_path));
subbands_path='..\subbands\';
addpath(genpath(subbands_path));
input_path='..\input\';
addpath(genpath(input_path));
utils_path='..\utils\';
addpath(genpath(utils_path));
vbap_path='..\vbap\';
addpath(genpath(vbap_path));

%��ȡԭʼ��Դ��λ����������λ��11����������
[src_cipic_dirs3D ls_cipic_dirs]=get_src_ls_cipic_dirs();
[gain3D]=calcu_vbap_gain(src_cipic_dirs3D,ls_cipic_dirs);
%���ϳɵ���������ĸ���
src_num=length(src_cipic_dirs3D);

%��ȡ���ںϳ����������������������,һ�������Ǻϳ�һ�������������������������
%��azi1,elev1,azi2,elev2,azi3,elev3��
for n=1:src_num
    ls_index=find(gain3D(n,:)~=0);
    speaker_theta(3*n-2,:)=ls_cipic_dirs(ls_index(1),:) ;
    speaker_theta(3*n-1,:)=ls_cipic_dirs(ls_index(2),:) ;
    speaker_theta(3*n,:)=ls_cipic_dirs(ls_index(3),:) ;
end

subject_index=1;
subbands_type=25;
wav_file_name='whitenoise_0dB.wav';


%���ɵ���Դ˫���ź�(single_binarual)�ͺϳ�˫���źţ�synthesis_binarual��
for n=1:src_num
    s_theta=src_cipic_dirs3D(n,:);
    sp_theta=speaker_theta(3*n-2:3*n,:);
    
    if(n<=3)
        pos='front';
    elseif(n<=5)
        pos='left';
    elseif(n<=7)
        pos='right';
    elseif(n<=9)
        pos='back';
    elseif(n<=11)
        pos='up';
    end
    
    single_binarual_file_name=strcat(single_binarual_path,'single_',pos,'_',num2str(s_theta(1)),'_',num2str(s_theta(2)),'_',wav_file_name);
    synthesis_binarual_file_name=strcat(synthesis_binarual_path,'synthesis_',pos,'_',num2str(s_theta(1)),'_',num2str(s_theta(2)),'_',wav_file_name);
     
    generate_single_binarual(wav_file_name,subject_index,s_theta(1),s_theta(2),single_binarual_file_name);
    generate_synthesis_binarual(wav_file_name,subject_index,s_theta,sp_theta,subbands_type,synthesis_binarual_file_name);
    
    
end

%����vbap�ϳɵ�˫���ź�
generate_vbap_binarual(wav_file_name,subject_index,src_cipic_dirs3D,ls_cipic_dirs);

