function ILD_corr=subbands_ILD_corr(ILD_data_single,ILD_data_double)
%������������ ILD_data_single����Դ˫���źŵ�ILD ������ʽframe_number *25����������������
%������������ILD_data_double˫��Դ˫���źŵ�ILD ������ʽframe_number *25����������������
%�������������Ӵ�Ild ����ת�á�����������������������������������������������������������
     ILD_data_single_temp=  ILD_data_single';
     ILD_data_double_temp=ILD_data_double';
%���������������������ӳ�������  ������� ���������������������������������������������� 
     ILD_data_single= ILD_data_single_temp(:);
     ILD_data_double=ILD_data_double_temp(:);
  
    [ILD_corr lags]=xcorr(ILD_data_single,ILD_data_double,'coeff');
    plot(lags,ILD_corr);
end