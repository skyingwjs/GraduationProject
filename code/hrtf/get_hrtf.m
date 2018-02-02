%����subject_index,azi.elev�����Ӧ��CIPIC��hrir���ݺ��ٽ���1024��fft�任���hrtf����
function hrtf=get_hrtf(subject_index,azimuth,elevation)

azimuth_cipic = [-80 -65 -55 -45:5:45 55 65 80];%azimuth(13)==0 
azimuth_index=find(azimuth_cipic==azimuth);%��÷�λ����CIPIC���ж�Ӧ�ĵ�����ֵ

elevation_cipic=-45:360/64:235;
elevation_index=find(elevation_cipic==elevation);%��ø߶Ƚ���CIPIC���ж�Ӧ�ĵ�����ֵ

%��ȡhrir����
hrir_l= read_cipic_hrir(subject_index,azimuth_index,elevation_index,'l');
hrir_r= read_cipic_hrir(subject_index,azimuth_index,elevation_index,'r');

hrtf(:,1)=fft(hrir_l,1024);
hrtf(:,2)=fft(hrir_r,1024);