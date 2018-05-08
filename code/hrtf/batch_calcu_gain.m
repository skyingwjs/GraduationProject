clc;
clear all;

subbands_path='..\subbands';
addpath(genpath(subbands_path));

utils_path='..\utils';
addpath(genpath(utils_path));

gain_path='..\output\gain\';
addpath(genpath(gain_path));

vbap_path='..\vbap\';
addpath(genpath(vbap_path));


%���������鷽λ
position={'front';'front';'left';'left';'right';'right';'back';'back';'up';'up'};

subject_index=1;
%��ȡԭʼ��Դ��λ����������λ��11����������
[src_cipic_dirs3D ls_cipic_dirs]=get_src_ls_cipic_dirs();
[gain3D]=calcu_vbap_gain(src_cipic_dirs3D,ls_cipic_dirs);
%���ϳɵ���������ĸ���
src_num=length(src_cipic_dirs3D);
start_end_index=subbands_type(25);

%��ȡ���ںϳ����������������������,һ�������Ǻϳ�һ�������������������������
%��azi1,elev1,azi2,elev2,azi3,elev3��
for n=1:src_num
    ls_index=find(gain3D(n,:)~=0);
    speaker_theta(3*n-2,:)=ls_cipic_dirs(ls_index(1),:) ;
    speaker_theta(3*n-1,:)=ls_cipic_dirs(ls_index(2),:) ;
    speaker_theta(3*n,:)  =ls_cipic_dirs(ls_index(3),:) ;
end



for n=1:src_num
    s_theta=src_cipic_dirs3D(n,:);
    sp_theta=speaker_theta(3*n-2:3*n,:);
    gain=calcu_speaker_gain(subject_index,s_theta,sp_theta,start_end_index);
    gain_real=real(gain);
    gain_imag=imag(gain);
    
    save(strcat('gain_real',num2str(n),'_',num2str(s_theta(1)),'_',num2str(s_theta(2)),'.mat'),'gain_real');
    save(strcat('gain_imag',num2str(n),'_',num2str(s_theta(1)),'_',num2str(s_theta(2)),'.mat'),'gain_imag');
    
%     figure(n);
%     subbands=1:25;
%     subplot(1,2,1);
%     plot(subbands,abs(gain(:,1)),'ro',subbands,abs(gain(:,2)),'go',subbands,abs(gain(:,3)),'bo');
%     subplot(1,2,2);
%     plot(subbands,angle(gain(:,1))*180/pi,'ro',subbands,angle(gain(:,2))*180/pi,'go',subbands,angle(gain(:,3))*180/pi,'bo');
%     gain_file_name= strcat(gain_path,position{n},'_',num2str(s_theta(1)),'_',num2str(s_theta(2)),'.txt');   
%     mat2txt(gain_file_name,gain);cccc
end 







