function ILD_corr=subbands_ILD_corr(ILD_data_single,ILD_data_double)
%—————— ILD_data_single单声源双耳信号的ILD 矩阵形式frame_number *25————————
%——————ILD_data_double双声源双耳信号的ILD 矩阵形式frame_number *25————————
%——————子带Ild 矩阵转置——————————————————————————————
     ILD_data_single_temp=  ILD_data_single';
     ILD_data_double_temp=ILD_data_double';
%——————矩阵按行连接成列向量  算相关性 ——————————————————————— 
     ILD_data_single= ILD_data_single_temp(:);
     ILD_data_double=ILD_data_double_temp(:);
  
    [ILD_corr lags]=xcorr(ILD_data_single,ILD_data_double,'coeff');
    plot(lags,ILD_corr);
end