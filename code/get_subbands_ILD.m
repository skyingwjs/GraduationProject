function subbands_ILD=get_subbands_ILD(file_name)
%———————得到双耳信号的ILD——————————————————————

[wav_data fs nbits]=wavread(file_name);

for i=1:size(wav_data,2)
    x=wav_data(:,i);%左右耳信号
    %——————分帧加重叠窗 fft变换——————————————————————
    [fx fpad]=linframe(x,512,1024,'sym');   %窗长1024  窗移512  ‘sym’前后对称补零
    fx=winit(fx,'kbdwin');  %加窗后的时域数据 fx  kbd win is TDAC  加窗
    FX=fft(fx);             %fft变换   每列为一帧
    if i==1
        FX_l=FX;
    end
    if i==2
        FX_r=FX;
    end
end

%——————子带划分 1024为一帧 只对前513个点进行子带划分——————————
subbands_data_l=subbands_divide_1024(FX_l);
subbands_data_r=subbands_divide_1024(FX_r);
subbands_ILD=calculate_subbands_ILD(subbands_data_l,subbands_data_r);
end