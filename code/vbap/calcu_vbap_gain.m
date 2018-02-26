function [gains3D]=calcu_vbap_gain(src_cipic_dirs3D,ls_cipic_dirs)

utils_path='..\utils\';
addpath(genpath(utils_path));

% CIPIC 库可用AZI与ELEV
% azimuth_range= [-80 -65 -55 -45:5:45 55 65 80]';
% elevation_range=[-45:360/64:235]';
% cipic_azi=[-80 -65 -45 -30 -15 0 15 30 45 65 80]
% cipic_elev=[0 11.25 22.5 33.75 45 56.25 67.5 78.75 90 112.5 135 146.25 157.5 168.75 180]

%从CIPIC库可用的AZI ELEV中选取loudspeaker directions,尽可能接近VBAP参考代码的11.0 3D音频系统
%参考: ls_dirs=[30 -30 0 120 -120 90 -90 45 -45 135 -135; 0 0 0 0 0 0 0 45 45 45 45]';

%ls_cipic_dirs= [30 -30 0 65  -65  80 -80 45 -45 45 -45;  0 0 0 180 180 180 180 45 45 135 135]';
ls_vbap_dirs  =cipic2vbap_coordinate(ls_cipic_dirs);

%src_cipic_dirs3D=[0 -15 15 -45 -80  45 80  -55 30 65 -65; 22.5 11.25 11.25 22.5 33.75  22.5 33.75 157.5 168.75 65 65]';
src_vbap_dirs3D=cipic2vbap_coordinate(src_cipic_dirs3D);

[ls_groups, layout] = findLsTriplets(ls_vbap_dirs); % return also triangulation mesh for plotting

figure, subplot(121), plotTriangulation(layout);
view(50,30), zoom(2) % plot triangulation

layoutInvMtx = invertLsMtx(ls_vbap_dirs, ls_groups);

% Get VBAP gains
gains3D = vbap(src_vbap_dirs3D, ls_groups, layoutInvMtx);

end

%%
% hrtf_path='..\hrtf\';
% addpath(genpath(hrtf_path));
% [source_theta sp_theta]=get_source_speaker_group();
% 
% %扬声器CIPIC坐标系转换为VBAP采用的坐标系
% for n=1:length(sp_theta)
%     if(sp_theta(n,2)>90)
%         if(sp_theta(n,1)<0)
%             ls_dirs(n,1)= -(sp_theta(n,1)+180);
%             ls_dirs(n,2)= sp_theta(n,2);
%         else
%             ls_dirs(n,1)= (180-sp_theta(n,1));
%             ls_dirs(n,2)= sp_theta(n,2);
%         end     
%     else     
%        ls_dirs(n,:)=sp_theta(n,:);
%     end    
% end
% 
% source_num=length(source_theta);
% %Source CIPIC坐标系转换为VBAP采用的坐标系
% for n=1:source_num
%     if(source_theta(n,2)>90)
%         if(source_theta(n,1)<0)
%             src_dirs3D(n,1)= -(source_theta(n,1)+180);
%             src_dirs3D(n,2)= source_theta(n,2);
%         else
%             src_dirs3D(n,1)= (180-source_theta(n,1));
%             src_dirs3D(n,2)= source_theta(n,2);
%         end     
%     else     
%        src_dirs3D(n,:)=source_theta(n,:);
%     end  
% end
% 
% %扬声器分组索引，类似于vbap中 findLsTriplets(ls_dirs)的功能
% for n=1:source_num
%     ls_groups(n,:)=3*n-2:3*n;
% end
% 
% %计算VBAP 扬声器逆矩阵
% layoutInvMtx = invertLsMtx(ls_dirs, ls_groups);
% 
% %计算VBAP 扬声器增益 gain3D;
% gains3D = vbap(src_dirs3D, ls_groups, layoutInvMtx);

