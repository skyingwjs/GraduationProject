function subbands=subbands_divide_1024(wav_spectrum_data)
%�����������������ڶԵ�������Ƶ�ļ� ���Ӵ�fft�任���Ƶ�����ݽ����Ӵ����֡�������������
%�����������룺wav_fpectrum_data  Ƶ������ 1024Ϊһ֡  1024*frame_num�ľ�����ʽ������ 
%������������ֵΪsubbands ��Ԫ���飬subbands {i,j}�洢�ŵ�i֡����j�Ӵ���Ƶ�����ݡ�����

%�����������Ӵ�����ʼ������� �� ��ֹ������š�����������������������������������������
start_index=[1 4 6 8 11 13 16 19 23 27 31 36 41 48 55 64 75 87 104 125 150 180 222 280 361];
end_index= [3 5 7 10 12 15 18 22 26 30 35 40 47 54 63 74 86 103 124 149 179 221 279 360 513];

%�������������Ӵ�����������������������������������������������������������������������
    for i=1:size(wav_spectrum_data,2)%%%������������size(wav_spectrum_data,2)��ʾ֡��Ŀ һ��Ϊһ֡
        one_frame_spectrum_data= wav_spectrum_data(:,i);
        for j=1:length(start_index)
            subbands{i,j}=one_frame_spectrum_data(start_index(j):end_index(j));
        end
    end
end

