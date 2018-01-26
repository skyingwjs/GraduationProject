function subbands_ILD=get_subbands_ILD(file_name)
%���������������õ�˫���źŵ�ILD��������������������������������������������

[wav_data fs nbits]=wavread(file_name);

for i=1:size(wav_data,2)
    x=wav_data(:,i);%���Ҷ��ź�
    %��������������֡���ص��� fft�任��������������������������������������������
    [fx fpad]=linframe(x,512,1024,'sym');   %����1024  ����512  ��sym��ǰ��ԳƲ���
    fx=winit(fx,'kbdwin');  %�Ӵ����ʱ������ fx  kbd win is TDAC  �Ӵ�
    FX=fft(fx);             %fft�任   ÿ��Ϊһ֡
    if i==1
        FX_l=FX;
    end
    if i==2
        FX_r=FX;
    end
end

%�������������Ӵ����� 1024Ϊһ֡ ֻ��ǰ513��������Ӵ����֡�������������������
subbands_data_l=subbands_divide_1024(FX_l);
subbands_data_r=subbands_divide_1024(FX_r);
subbands_ILD=calculate_subbands_ILD(subbands_data_l,subbands_data_r);
end