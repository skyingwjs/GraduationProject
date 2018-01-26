function gain_factor= get_init_gain(azi_loudspeaker,azi_phantom)
%���������������������ж��ɻ�������������ĳ�ʼ���桪����������������������������������������������������
%������������������������������λ�� azi_loudspeaker=[-30 30]  ����Ҫ�ϳɵ����������λ��azi_phantom����
%����������������������������λ�ñ�����-90 �� 90�����ڡ�������������������������������������������������
%���������������������ж��� ��gl gr
    theta = (azi_loudspeaker(2) - azi_loudspeaker(1) ) / 2;  %ƫ�ƽǶ�
    azi =azi_phantom- 0.5 * (azi_loudspeaker(2)+ azi_loudspeaker(1));
    temp1=tan(theta*pi/180);  %tan(theta)
    temp2=tan(azi*pi/180); %tan(phi)
    gl = (temp1 - temp2) / sqrt(2*temp1.^2 + 2*temp2.^2);
    gr= (temp1 + temp2) / sqrt(2*temp1.^2 + 2*temp2.^2);          
    gain_factor=[gl,gr];
end

