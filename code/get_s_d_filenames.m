function [s_filename,d_filenames]=get_s_d_filenames(folder_path)
%————————获取单双声源双耳信号的文件名————————————
dirs=dir(folder_path);   
dircell=struct2cell(dirs)' ;  
filenames=dircell(:,1);  
s_filename=filenames(length(filenames));
filenames(length(filenames))=[];
d_filenames=filenames;