function subbands_ILD=calculate_subbands_ILD(subbands_data_l,subbands_data_r)
%————subbands_data_l 左声道音频数据 子带划分后的 子带频谱数组 frame_number * 25————————
%————subbands_data_r 右声道音频数据 子带划分后的 子带频谱数组 frame_number * 25————————
%————subbands_ILD 各帧各子带ILD                subbands_ILD(i,j)第i帧第j个子带的ILD——————

frame_number=size(subbands_data_l,1);%帧数
subbands_number=size(subbands_data_l,2);%每帧的子带数
    for i=1:frame_number
        for j=1:subbands_number
              il_l(i,j)=sum(subbands_data_l{i,j} .*conj(subbands_data_l{i,j}) );
              il_r(i,j)=sum(subbands_data_r{i,j} .*conj(subbands_data_r{i,j}) );
%————对 il_l ,       il_r做处理 对数据为0的 ----> eps 这样取对数时就不会 产生NaN
              if il_l(i,j)==0
                  il_l(i,j)=eps;
              end
              if il_r(i,j)==0
                  il_r(i,j)=eps;
              end              
              subbands_ILD(i,j)=10*log10(  il_l(i,j)/  il_r(i,j));
        end
    end
end

          