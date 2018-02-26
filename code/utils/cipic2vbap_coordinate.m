function [vbap_theta]=cipic2vbap_coordinate(cipic_theta)
% cipic_azi_list= [-80 -65 -55 -45:5:45 55 65 80]';
% cipic_elev_list= [ -45:360/64:235]';

%vbap采用的坐标系：正前方为0度，逆时针0:180,顺时针0:-1:-180; ELEV:正下方为-90度，正上方为90度，从下到上-90:90
%cipic对应的vbap坐标
% 示例：
% cipic_azi=[-80 -80 80 80];
% cipic_elev=[45 135 45 135];
% vbap_azi=[80 100 -80 -100];
% vbap_elev=[45 45 45 45];


cipic_theta_num=length(cipic_theta);

for n=1:cipic_theta_num
    c_azi=cipic_theta(n,1);
    c_elev=cipic_theta(n,2);
    if(c_elev<=90)%%前方
        vbap_theta(n,1)=-c_azi;
        vbap_theta(n,2)=c_elev;
    else%%c_elev>90 后方
        if(c_azi<0)%%左方
            vbap_theta(n,1)=180+c_azi;            
        else%%右方
            vbap_theta(n,1)=c_azi-180;
        end
        vbap_theta(n,2)= 180-c_elev; 
    end   
end

end

