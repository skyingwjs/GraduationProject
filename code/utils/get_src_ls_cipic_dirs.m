
function [src_cipic_dirs3D ls_cipic_dirs]=get_src_ls_cipic_dirs()

%扬声器方位坐标
ls_cipic_dirs= [30 -30 0 65  -65  80 -80 45 -45 45 -45;  0 0 0 180 180 180 180 45 45 135 135]';
%原始声源方位坐标
src_cipic_dirs3D=[0 -15 15 -45 -80  45 80  -55 30 65 -65; 22.5 11.25 11.25 22.5 33.75  22.5 33.75 157.5 168.75 67.5 67.5]';

end