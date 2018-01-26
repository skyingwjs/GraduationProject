function [left_gain_vector right_gain_vector]=get_left_right_gain_vector(init_gain)
%������������������VBAP�õ��ĳ�ʼ���� ��������չ�õ�������������������������������������

left_gain0=init_gain(1);% ��ʼ������
right_gain0=init_gain(2);%��ʼ������

left_gain_vector0=0:0.005:1;
% right_gain_vector0=1-sqrt(left_gain_vector0.^2);

diff=abs(left_gain0-left_gain_vector0);
[min_diff index]=sort(diff);
mindiff_index=index(1);

%���������������������桪������������������������������������������������������������
if mindiff_index-1<=15
    left_gain_vector_front=left_gain_vector0(1:mindiff_index);
else
    left_gain_vector_front=left_gain_vector0(mindiff_index-15:mindiff_index);
end
%����������������ұ����桪������������������������������������������������������������      
if length(left_gain_vector0)-mindiff_index<=15   
    left_gain_vector_back=left_gain_vector0(mindiff_index+1:length(left_gain_vector0));
else
    left_gain_vector_back=left_gain_vector0(mindiff_index+1:mindiff_index+14);
end

left_gain_vector=[left_gain_vector_front left_gain_vector_back];
right_gain_vector=sqrt(1-left_gain_vector.^2);