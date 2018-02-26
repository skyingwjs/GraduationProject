 clear all;
 utils_path='..\utils';
 addpath(genpath(utils_path));
 
% [x,y]=meshgrid(-8:0.1:8);
% z=x.^2+y.^2;
% k=ones(size(z));
% surf(x,y,z,k)
% re=[0 1 0];
% colormap(re)
% shading flat
% 把矩阵 matrix 保存成任意后缀的文件
% 转换成 .txt 举例：mat2txt( 'filename.txt', data );
% 转换成 .corr 举例：mat2txt( 'filename.corr',data );
% 
% A=[1.223266 45665.23233;
%     455.223355 1223.45454];
% 
% txt_name='test.txt';
% mat2txt(txt_name,A);

[source_theta,sp_theta]=get_source_speaker_group();


vbap_source_theta
vbap_sp_theta

