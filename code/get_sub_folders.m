%������������·������ȡ��·���������ļ��е����֡�������������������
function sub_folders=get_sub_folders(base_path)
dirs = dir(base_path);  
isub = [dirs(:).isdir]; %# returns logical vector  
sub_folders = {dirs(isub).name}';  
sub_folders(ismember(sub_folders,{'.','..'})) = [];  