clc;
clear all;
azi_range= [-80 -65 -55 -45:5:45 55 65 80]';
elev_range=[-45:360/64:235]';

% sp_azi=[-80 -65 -45 -30 -15 0 15 30 45 65 80];
% sp_elev=[0 11.25 22.5 33.75 45 56.25 67.5 78.75 90 112.5 135 146.25 157.5 168.75 180];


sp_azi=[0:15:360];
sp_elev=[0 11.25 22.5 33.75 45 56.25 67.5 78.75 90 101.25 112.5  123.75 135 146.25 157.5 168.75 180];

sp_azi_pi=sp_azi*pi/180;
sp_elev_pi=sp_elev*pi/180;

r=1;
theta=sp_elev_pi;
phi=sp_azi_pi;

% theta=linspace(0,pi,30);
% phi=linspace(0,2*pi,30);
[tt,pp]=meshgrid(theta,phi);

x=r.*sin(tt).*cos(pp);
y=r.*sin(tt).*sin(pp);
z=r.*cos(tt);

%上面三句可以改成简单的一句：
% [x,y,z] = sph2cart(pp,pi/2-tt,r);
%其中的变换是matlab的球坐标定义与寻常不同造成的，可以看matlab的帮助

mesh(x,y,z,'EdgeColor','k')
hold on;
plot3(x,y,z,'-o');
axis square

% 
% phi1=[75 90 105  105 90 75 ];
% theta1=[90 90 90 78.75 78.75 78.75];
% 
% phi1=  [75 80 90 95 100 105  105 100 95 90 85 80 75 ];
% theta1=[90 90 90 90 90  90   78.75 78.75 78.75 78.75 78.75 78.75 78.75];



phi1=phi1*pi/180;
theta1=theta1*pi/180;


[tt1,pp1]=meshgrid(theta1,phi1);

x1=r.*sin(tt1).*cos(pp1);
y1=r.*sin(tt1).*sin(pp1);
z1=r.*cos(tt1);

c1=ones(size(z1));
surf(x1,y1,z1,c1);
% 
% re=[1 0 0];
colormap
shading flat


%fill3(x1,y1,z1,'y')


