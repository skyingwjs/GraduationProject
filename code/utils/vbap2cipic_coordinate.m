function [cipic_theta]=vbap2cipic_coordinate(vbap_theta)
% cipic_azi_list= [-80 -65 -55 -45:5:45 55 65 80]';
% cipic_elev_list= [ -45:360/64:235]';

%vbap���õ�����ϵ����ǰ��Ϊ0�ȣ���ʱ��0:180,˳ʱ��0:-1:-180; ELEV:���·�Ϊ-90�ȣ����Ϸ�Ϊ90�ȣ����µ���-90:90
% vbap��Ӧ��cipic����
% vbap_azi=[80 100 -80 -100];
% vbap_elev=[45 45 45 45];
% cipic_azi=[-80 -80 80 80];
% cipic_elev=[45 135 45 135];


vbap_theta_num=length(vbap_theta);

for n=1:vbap_theta_num
    v_azi=vbap_theta(n,1);
    v_elev=vbap_theta(n,2);
    
    if(v_azi<=90 && v_azi>=-90)%%ǰ��
        cipic_theta(n,1)=-v_azi;
        cipic_theta(n,2)=v_elev;
    else %%��
        if(v_azi>90 && v_azi<=180)%%���
            cipic_theta(n,1)=v_azi-180;        
        else
            cipic_theta(n,1)=v_azi+180; 
        end
        cipic_theta(n,2)=180-v_elev;
    end
    
  
end

end

