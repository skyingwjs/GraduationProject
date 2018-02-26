%批量生成单声源双耳信号及扬声器合成的双耳信号

%双耳信号的输出路径
single_binarual_path='..\output\single\';
synthesis_binarual_path='..\output\synthesis\';
vbap_binarual_path='..\output\vbap\';

%清除输出文件夹下所有文件
delete(strcat(single_binarual_path,'*.wav'));
delete(strcat(synthesis_binarual_path,'*.wav'));
delete(strcat(vbap_binarual_path,'*.wav'));

%添加需要调用的函数的路径
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

%获取原始声源方位及扬声器方位（11个扬声器）
[src_cipic_dirs3D ls_cipic_dirs]=get_src_ls_cipic_dirs();
[gain3D]=calcu_vbap_gain(src_cipic_dirs3D,ls_cipic_dirs);
%待合成的虚拟声像的个数
src_num=length(src_cipic_dirs3D);

%获取用于合成虚拟声像的扬声器的坐标,一行依次是合成一个虚拟声像的三扬声器的坐标
%（azi1,elev1,azi2,elev2,azi3,elev3）
for n=1:src_num
    ls_index=find(gain3D(n,:)~=0);
    speaker_theta(3*n-2,:)=ls_cipic_dirs(ls_index(1),:) ;
    speaker_theta(3*n-1,:)=ls_cipic_dirs(ls_index(2),:) ;
    speaker_theta(3*n,:)=ls_cipic_dirs(ls_index(3),:) ;
end

subject_index=1;
subbands_type=25;
wav_file_name='whitenoise_0dB.wav';


%生成单声源双耳信号(single_binarual)和合成双耳信号（synthesis_binarual）
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

%生成vbap合成的双耳信号
generate_vbap_binarual(wav_file_name,subject_index,src_cipic_dirs3D,ls_cipic_dirs);

