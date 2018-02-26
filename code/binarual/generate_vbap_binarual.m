% 该函数根据VBAP原理利用三个扬声器合成虚拟声像,并生成虚拟声像的双耳信号，每个wav_file_name会生成11个空间方位的双耳信号
% wav_file_name 输入的单声道wav文件名
% subject_index CIPIC库中的subject index
% src_cipic_dirs3D 期望生成的虚拟声像的方位(azi,elev)，只能是CIPIC库中存在HRIR数据的方位
% ls_cipic_dirs    3D音频系统中各扬声器的方位(azi,elev)，只能是CIPIC库中存在HRIR数据的方位


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

%vbap 计算扬声器增益
% wav_file_name='whitenoise_0dB.wav';
% subject_index=1;
% [src_cipic_dirs3D,ls_cipic_dirs]=get_src_ls_cipic_dirs();

[gain3D]=calcu_vbap_gain(src_cipic_dirs3D,ls_cipic_dirs);

[wav_data fs nbits]=wavread(wav_file_name);

%每组VBAP扬声器的方位theta(azi,elev)
src_num=length(gain3D);%虚拟声像个数

%vbap_ls_theta：src_num*6 每一行表示一组VBAP LOUDSPEAKER的方位
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
    %区分前、左、右、后、上方
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



