function corrcoeff=corr_plot(single_binarual,double_binarual)
%�������������������뵥˫��Դ��˫���ź� ��������� ����ͼ����������������������������
%�������������������� ���뵥˫��Դ���Ե�����ź� �������ǵ������ ��ͼ����������������
    [corrcoeff lags]=xcorr(single_binarual,double_binarual,'coeff');
    figure;
    plot(lags,corrcoeff);
end
