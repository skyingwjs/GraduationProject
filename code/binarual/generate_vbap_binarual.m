% �ú�������VBAPԭ�����������������ϳ���������,���������������˫���źţ�ÿ��wav_file_name������11���ռ䷽λ��˫���ź�
% wav_file_name ����ĵ�����wav�ļ���
% subject_index CIPIC���е�subject index
% src_cipic_dirs3D �������ɵ���������ķ�λ(azi,elev)��ֻ����CIPIC���д���HRIR���ݵķ�λ
% ls_cipic_dirs    3D��Ƶϵͳ�и��������ķ�λ(azi,elev)��ֻ����CIPIC���д���HRIR���ݵķ�λ


function vbap_binarual=generate_vbap_binarual(wav_file_name,subject_index,src_cipic_dirs3D,ls_cipic_dirs)

input_path='..\input\';
addpath(genpath(input_path));
output_path='..\output\vbap\';
addpath(genpath(output_path));
hrtf_path='..\hrtf\';
addpath(genpath(hrtf_path));
utils_path='..\utils\';
addpath(genpath(utils_path));
vbap_path='..\vbap\';
addpath(genpath(vbap_path));

azi_cipic = [-80 -65 -55 -45:5:45 55 65 80];%azimuth(13)==0 
elev_cipic=-45:360/64:235;

%vbap ��������������
% wav_file_name='whitenoise_0dB.wav';
% subject_index=1;
% [src_cipic_dirs3D,ls_cipic_dirs]=get_src_ls_cipic_dirs();

[gain3D]=calcu_vbap_gain(src_cipic_dirs3D,ls_cipic_dirs);

[wav_data fs nbits]=wavread(wav_file_name);

%ÿ��VBAP�������ķ�λtheta(azi,elev)
src_num=length(gain3D);%�����������

%vbap_ls_theta��src_num*6 ÿһ�б�ʾһ��VBAP LOUDSPEAKER�ķ�λ
for n=1:src_num
    ls_index=find(gain3D(n,:)~=0);
    vbap_ls_theta(n,1:2)=ls_cipic_dirs(ls_index(1),:) ;
    vbap_ls_theta(n,3:4)=ls_cipic_dirs(ls_index(2),:) ;
    vbap_ls_theta(n,5:6)=ls_cipic_dirs(ls_index(3),:) ;
       
    for m=1:3
        azi=vbap_ls_theta(n,2*m-1);
        elev=vbap_ls_theta(n,2*m);
        azi_index=find(azi_cipic==azi);
        elev_index=find(elev_cipic==elev);
        hrir(:,2*m-1)=read_cipic_hrir(subject_index,azi_index,elev_index,'l');
        hrir(:,2*m)=read_cipic_hrir(subject_index,azi_index,elev_index,'r');
        binarual(:,2*m-1)=filter(hrir(:,2*m-1),1,gain3D(n,ls_index(m)).*wav_data);
        binarual(:,2*m)  =filter(hrir(:,2*m),  1,gain3D(n,ls_index(m)).*wav_data);
    end
    binarual_l=binarual(:,[1 3 5]);
    binarual_r=binarual(:,[2 4 6]);
    vbap_binarual=[sum(binarual_l,2) sum(binarual_r,2)];
    %����ǰ�����ҡ����Ϸ�
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
   
    binarual_file_name=strcat(output_path,'vbap_',pos,'_',num2str(src_cipic_dirs3D(n,1)),'_',num2str(src_cipic_dirs3D(n,2)),'_',wav_file_name);
    wavwrite(vbap_binarual,fs,binarual_file_name);
end

end



