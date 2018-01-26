function gain_factor= get_init_gain(azi_loudspeaker,azi_phantom)
%————————由正切定律获得左右扬声器的初始增益———————————————————————————
%————————输入左右扬声器位置 azi_loudspeaker=[-30 30]  及需要合成的虚拟声像的位置azi_phantom——
%————————左右扬声器的位置必须在-90 到 90度以内—————————————————————————
%————————由正切定律 求gl gr
    theta = (azi_loudspeaker(2) - azi_loudspeaker(1) ) / 2;  %偏移角度
    azi =azi_phantom- 0.5 * (azi_loudspeaker(2)+ azi_loudspeaker(1));
    temp1=tan(theta*pi/180);  %tan(theta)
    temp2=tan(azi*pi/180); %tan(phi)
    gl = (temp1 - temp2) / sqrt(2*temp1.^2 + 2*temp2.^2);
    gr= (temp1 + temp2) / sqrt(2*temp1.^2 + 2*temp2.^2);          
    gain_factor=[gl,gr];
end

