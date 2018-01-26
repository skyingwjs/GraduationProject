%———————根据实验得到的双耳信号进行分析————————————————
clc;
clear all;
initpath();

folder_path='.\output\*.wav';
[s_filename,d_filenames]=get_s_d_filenames(folder_path)
s_subbands_ILD=get_subbands_ILD(s_filename{1});

%求s_subbands_ILD的列平均值
for i=1:size(s_subbands_ILD,2)
    s_subbands_ILD_mean(i)=mean(s_subbands_ILD(:,i));
end
%单声源子带ILD均值  绘图
figure;
plot(s_subbands_ILD_mean,'-r');
hold on;

for i=1:length(d_filenames)
    d_subbands_ILD=get_subbands_ILD(d_filenames{i});
    %求s_subbands_ILD的列平均值
    for j=1:size(d_subbands_ILD,2)
        d_subbands_ILD_mean(j)=mean(d_subbands_ILD(:,j));
    end
    %双声源子带ILD均值  绘图
    plot(d_subbands_ILD_mean,'-b');
    hold on;
end










% [wav_data fs nbits]=wavread(file_name);
% 
% for i=1:size(wav_data,2)
%     x=wav_data(:,i);%左右耳信号
%     %——————分帧加重叠窗 fft变换——————————————————————
%     [fx fpad]=linframe(x,512,1024,'sym');%窗长1024  窗移512  ‘sym’前后对称补零
%     fx=winit(fx,'kbdwin');%加窗后的时域数据 fx  kbd win is TDAC  加窗
%     FX=fft(fx);%fft变换   每列为一帧
%     if i==1
%         FX_l=FX;
%     end
%     if i==2
%         FX_r=FX;
%     end
%     % %——————分帧ifft变换  去窗 帧回归向量—————————————————
%     % fy=ifft(FX);%fft 反变换  每列为一帧
%     % fy=winit(fy ,'kbdwin'); % rewindow 去窗
%     % y= linunframe(fy,512,fpad); % OLA  帧回归---->vector
% 
%     % %——————播放反变换回来的数据——————————————————————
%     % e  = mean((fx-fy).^2);% so our error for mdct4
%     % sound(y,fs,nbits);
% end
% 
% %——————子带划分 1024为一帧 只对前513个点进行子带划分——————————
% s_subbands_data_l=subbands_divide_1024(FX_l);
% s_subbands_data_r=subbands_divide_1024(FX_r);
% s_subbands_ILD=calculate_subbands_ILD(s_subbands_data_l,s_subbands_data_r);
% 
% % %——————绘图———————————————————————————————
% % plot(x,'-r');%时域波形图
