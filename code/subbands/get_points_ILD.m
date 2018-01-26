function points_ILD=get_points_ILD(file_name)
%———————file_name双耳信号文件名————————————————————————
%———————得到双耳信号的ILD  points_ILD是每列为一帧————————————————————

[wav_data fs nbits]=wavread(file_name);

for i=1:size(wav_data,2)
    x=wav_data(:,i);%左右耳信号
    %——————分帧加重叠窗 fft变换——————————————————————
    [fx fpad]=linframe(x,512,1024,'sym');   %窗长1024  窗移512  ‘sym’前后对称补零
    fx=winit(fx,'kbdwin');  %加窗后的时域数据 fx  kbd win is TDAC  加窗
    FX=fft(fx);             %fft变换   每列为一帧
    if i==1
        FX_l=FX;%左耳信号频谱  每列为一帧
    end
    if i==2
        FX_r=FX;%右耳信号频谱  每列为一帧
    end
end

%——————得到双耳信号的ILD——————————

frame_number=size(FX_l,2);%帧数
points_number=size(FX_l,1);%每帧频点数1024 
    for j=1:frame_number
        for i=1:points_number  
              %这里是（i,j）因为每列为一帧 i=1:1024
              il_l(i,j)=sum(FX_l(i,j) .*conj(FX_l(i,j)));
              il_r(i,j)=sum(FX_r(i,j) .*conj(FX_r(i,j)));
%————对 il_l ,       il_r做处理 对数据为0的 ----> eps 这样取对数时就不会 产生NaN
              if il_l(i,j)==0
                  il_l(i,j)=eps;
              end
              if il_r(i,j)==0
                  il_r(i,j)=eps;
              end              
              points_ILD(i,j)=10*log10(  il_l(i,j)/  il_r(i,j));
        end
    end
    
    
end