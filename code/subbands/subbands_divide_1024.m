function subbands=subbands_divide_1024(wav_spectrum_data)
%————本函数用于对单声道音频文件 做加窗fft变换后的频域数据进行子带划分———————
%————输入：wav_fpectrum_data  频域数据 1024为一帧  1024*frame_num的矩阵形式——— 
%————返回值为subbands 胞元数组，subbands {i,j}存储着第i帧，第j子带的频谱数据———

%————各子带的起始谱线序号 和 终止谱线序号—————————————————————
start_index=[1 4 6 8 11 13 16 19 23 27 31 36 41 48 55 64 75 87 104 125 150 180 222 280 361];
end_index= [3 5 7 10 12 15 18 22 26 30 35 40 47 54 63 74 86 103 124 149 179 221 279 360 513];

%————划分子带———————————————————————————————————
    for i=1:size(wav_spectrum_data,2)%%%！！！！！！size(wav_spectrum_data,2)表示帧数目 一列为一帧
        one_frame_spectrum_data= wav_spectrum_data(:,i);
        for j=1:length(start_index)
            subbands{i,j}=one_frame_spectrum_data(start_index(j):end_index(j));
        end
    end
end

