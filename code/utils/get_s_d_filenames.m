function [s_filename,d_filenames]=get_s_d_filenames(folder_path)
%������������������ȡ��˫��Դ˫���źŵ��ļ���������������������������
dirs=dir(folder_path);   
dircell=struct2cell(dirs)' ;  
filenames=dircell(:,1);  
s_filename=filenames(length(filenames));
filenames(length(filenames))=[];
d_filenames=filenames;