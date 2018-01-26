function [left_gain_vector right_gain_vector]=get_left_right_gain_vector(init_gain)
%———————根据VBAP得到的初始增益 向左右扩展得到左右扬声器的增益向量————————

left_gain0=init_gain(1);% 初始左增益
right_gain0=init_gain(2);%初始右增益

left_gain_vector0=0:0.005:1;
% right_gain_vector0=1-sqrt(left_gain_vector0.^2);

diff=abs(left_gain0-left_gain_vector0);
[min_diff index]=sort(diff);
mindiff_index=index(1);

%——————获得左边增益———————————————————————————————
if mindiff_index-1<=15
    left_gain_vector_front=left_gain_vector0(1:mindiff_index);
else
    left_gain_vector_front=left_gain_vector0(mindiff_index-15:mindiff_index);
end
%——————获得右边增益———————————————————————————————      
if length(left_gain_vector0)-mindiff_index<=15   
    left_gain_vector_back=left_gain_vector0(mindiff_index+1:length(left_gain_vector0));
else
    left_gain_vector_back=left_gain_vector0(mindiff_index+1:mindiff_index+14);
end

left_gain_vector=[left_gain_vector_front left_gain_vector_back];
right_gain_vector=sqrt(1-left_gain_vector.^2);