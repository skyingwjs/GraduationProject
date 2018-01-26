function corrcoeff=corr_plot(single_binarual,double_binarual)
%————————输入单双声源的双耳信号 计算相关性 并绘图——————————————
%————————例如 输入单双声源各自的左耳信号 计算它们的相关性 绘图————————
    [corrcoeff lags]=xcorr(single_binarual,double_binarual,'coeff');
    figure;
    plot(lags,corrcoeff);
end
