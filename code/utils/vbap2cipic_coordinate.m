function [cipic_theta]=vbap2cipic_coordinate(vbap_theta)
% cipic_azi_list= [-80 -65 -55 -45:5:45 55 65 80]';
% cipic_elev_list= [ -45:360/64:235]';

%vbap采用的坐标系：正前方为0度，逆时针0:180,顺时针0:-1:-180; ELEV:正下方为-90度，正上方为90度，从下到上-90:90
% vbap对应的cipic坐标
% vbap_azi=[80 100 -80 -100];
% vbap_elev=[45 45 45 45];
% cipic_azi=[-80 -80 80 80];
% cipic_elev=[45 135 45 135];


vbap_theta_num=length(vbap_theta);

for n=1:vbap_theta_num
    v_azi=vbap_theta(n,1);
    v_elev=vbap_theta(n,2);
    
    if(v_azi<=90 && v_azi>=-90)%%前方
        cipic_theta(n,1)=-v_azi;
        cipic_theta(n,2)=v_elev;
    else %%后方
        if(v_azi>90 && v_azi<=180)%%左后方
            cipic_theta(n,1)=v_azi-180;        
        else
            cipic_theta(n,1)=v_azi+180; 
        end
        cipic_theta(n,2)=180-v_elev;
    end
    
  
end

end

