%根据subject_index,azi.elev获得相应的CIPIC库hrir数据后，再进行1024点fft变换获得hrtf数据
function hrtf=get_hrtf(subject_index,azimuth,elevation)

azimuth_cipic = [-80 -65 -55 -45:5:45 55 65 80];%azimuth(13)==0 
azimuth_index=find(azimuth_cipic==azimuth);%获得方位角在CIPIC库中对应的的索引值

elevation_cipic=-45:360/64:235;
elevation_index=find(elevation_cipic==elevation);%获得高度角在CIPIC库中对应的的索引值

%读取hrir数据
hrir_l= read_cipic_hrir(subject_index,azimuth_index,elevation_index,'l');
hrir_r= read_cipic_hrir(subject_index,azimuth_index,elevation_index,'r');

hrtf(:,1)=fft(hrir_l,1024);
hrtf(:,2)=fft(hrir_r,1024);