%������������������ʵ��õ���˫���źŽ��з�����������������������������������
clc;
clear all;
initpath();

folder_path='.\output\*.wav';
[s_filename,d_filenames]=get_s_d_filenames(folder_path)
s_subbands_ILD=get_subbands_ILD(s_filename{1});

%��s_subbands_ILD����ƽ��ֵ
for i=1:size(s_subbands_ILD,2)
    s_subbands_ILD_mean(i)=mean(s_subbands_ILD(:,i));
end
%����Դ�Ӵ�ILD��ֵ  ��ͼ
figure;
plot(s_subbands_ILD_mean,'-r');
hold on;

for i=1:length(d_filenames)
    d_subbands_ILD=get_subbands_ILD(d_filenames{i});
    %��s_subbands_ILD����ƽ��ֵ
    for j=1:size(d_subbands_ILD,2)
        d_subbands_ILD_mean(j)=mean(d_subbands_ILD(:,j));
    end
    %˫��Դ�Ӵ�ILD��ֵ  ��ͼ
    plot(d_subbands_ILD_mean,'-b');
    hold on;
end










% [wav_data fs nbits]=wavread(file_name);
% 
% for i=1:size(wav_data,2)
%     x=wav_data(:,i);%���Ҷ��ź�
%     %��������������֡���ص��� fft�任��������������������������������������������
%     [fx fpad]=linframe(x,512,1024,'sym');%����1024  ����512  ��sym��ǰ��ԳƲ���
%     fx=winit(fx,'kbdwin');%�Ӵ����ʱ������ fx  kbd win is TDAC  �Ӵ�
%     FX=fft(fx);%fft�任   ÿ��Ϊһ֡
%     if i==1
%         FX_l=FX;
%     end
%     if i==2
%         FX_r=FX;
%     end
%     % %��������������֡ifft�任  ȥ�� ֡�ع���������������������������������������
%     % fy=ifft(FX);%fft ���任  ÿ��Ϊһ֡
%     % fy=winit(fy ,'kbdwin'); % rewindow ȥ��
%     % y= linunframe(fy,512,fpad); % OLA  ֡�ع�---->vector
% 
%     % %���������������ŷ��任���������ݡ�������������������������������������������
%     % e  = mean((fx-fy).^2);% so our error for mdct4
%     % sound(y,fs,nbits);
% end
% 
% %�������������Ӵ����� 1024Ϊһ֡ ֻ��ǰ513��������Ӵ����֡�������������������
% s_subbands_data_l=subbands_divide_1024(FX_l);
% s_subbands_data_r=subbands_divide_1024(FX_r);
% s_subbands_ILD=calculate_subbands_ILD(s_subbands_data_l,s_subbands_data_r);
% 
% % %��������������ͼ��������������������������������������������������������������
% % plot(x,'-r');%ʱ����ͼ
