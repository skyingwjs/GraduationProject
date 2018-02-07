%spectrum: 频谱数据,每列为一帧的频谱数据
%start_index:各子带起始谱线序号 列向量
%end_index:各子带终止谱线序号 列向量
%subbands:划分后的子带数据,胞元数组subbands{i,j}存储着第i帧，第j子带的频谱数据

function subbands=subbands_divide(spectrum,start_end_index)

%划分子带
    for i=1:size(spectrum,2)%size(spectrum,2)表示帧数目 一列为一帧
        one_frame_spectrum_data= spectrum(:,i);
        for j=1:length(start_end_index)
            subbands{i,j}=one_frame_spectrum_data(start_end_index(j,1):start_end_index(j,2));
        end
    end
    subbands=subbands';
end

