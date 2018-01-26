function single_binarual=generate_single_binarual(wav_data,subject_index,azimuth)
%————————输入单声道音频数据wav_data  方位角azimuth 生成对应方位的双耳信号
%————————高度角  默认为0
%————————返回single_binarual，single_binarual(1)表示左耳信号，single_binarual(2)表示右耳信号
azimuth_cipic = [-80 -65 -55 -45:5:45 55 65 80];%azimuth(13)==0 
azimuth_index=find(azimuth_cipic==azimuth);%获取15度方位角 的索引值

elevation_cipic=-45:360/64:235;
elevation=0;
elevation_index=find(elevation_cipic==elevation);%获取0度高度角 的索引值

% subject_index=1;%cipic subject的索引
%读取azimuth=15，elevation=0的 hrir数据
hrtf_l= read_cipic_hrtf(subject_index,azimuth_index,elevation_index,'l');
hrtf_r= read_cipic_hrtf(subject_index,azimuth_index,elevation_index,'r');
%卷积生成双耳信号
binarual_l=filter(hrtf_l,1,wav_data);
binarual_r=filter(hrtf_r,1,wav_data);
single_binarual=[binarual_l binarual_r];
end