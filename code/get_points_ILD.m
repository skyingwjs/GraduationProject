function points_ILD=get_points_ILD(file_name)
%��������������file_name˫���ź��ļ���������������������������������������������������
%���������������õ�˫���źŵ�ILD  points_ILD��ÿ��Ϊһ֡����������������������������������������

[wav_data fs nbits]=wavread(file_name);

for i=1:size(wav_data,2)
    x=wav_data(:,i);%���Ҷ��ź�
    %��������������֡���ص��� fft�任��������������������������������������������
    [fx fpad]=linframe(x,512,1024,'sym');   %����1024  ����512  ��sym��ǰ��ԳƲ���
    fx=winit(fx,'kbdwin');  %�Ӵ����ʱ������ fx  kbd win is TDAC  �Ӵ�
    FX=fft(fx);             %fft�任   ÿ��Ϊһ֡
    if i==1
        FX_l=FX;%����ź�Ƶ��  ÿ��Ϊһ֡
    end
    if i==2
        FX_r=FX;%�Ҷ��ź�Ƶ��  ÿ��Ϊһ֡
    end
end

%�������������õ�˫���źŵ�ILD��������������������

frame_number=size(FX_l,2);%֡��
points_number=size(FX_l,1);%ÿ֡Ƶ����1024 
    for j=1:frame_number
        for i=1:points_number  
              %�����ǣ�i,j����Ϊÿ��Ϊһ֡ i=1:1024
              il_l(i,j)=sum(FX_l(i,j) .*conj(FX_l(i,j)));
              il_r(i,j)=sum(FX_r(i,j) .*conj(FX_r(i,j)));
%���������� il_l ,       il_r������ ������Ϊ0�� ----> eps ����ȡ����ʱ�Ͳ��� ����NaN
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