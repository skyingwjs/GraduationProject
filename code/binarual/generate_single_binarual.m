% wav_file_name 输入的单声道wav文件名
% subject_index CIPIC库中的subject index
% azimuth 期望生成的虚拟声像的方位角，只能是CIPIC库中存在HRIR数据的方位角
% elevation 期望生成的虚拟声像的高度角，只能是CIPIC库中存在HRIR数据的高度角
% binarual_file_name 输出单声源双耳信号的wav文件名

function single_binarual=generate_single_binarual(wav_file_name,subject_index,azimuth,elevation,binarual_file_name)

[wav_data fs nbits]=wavread(wav_file_name);

azimuth_cipic = [-80 -65 -55 -45:5:45 55 65 80];%azimuth(13)==0 
azimuth_index=find(azimuth_cipic==azimuth);%获得方位角在CIPIC库中对应的的索引值

elevation_cipic=-45:360/64:235;
elevation_index=find(elevation_cipic==elevation);%获得高度角在CIPIC库中对应的的索引值

%读取hrir数据
hrir_l= read_cipic_hrir(subject_index,azimuth_index,elevation_index,'l');
hrir_r= read_cipic_hrir(subject_index,azimuth_index,elevation_index,'r');

%滤波生成双耳信号，相当于卷积操作
binarual_l=filter(hrir_l,1,wav_data);
binarual_r=filter(hrir_r,1,wav_data);

single_binarual=[binarual_l binarual_r];

wavwrite(single_binarual,fs,binarual_file_name);

end