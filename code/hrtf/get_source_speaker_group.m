%���ǰ�������ҡ��Ϸ������������飬ÿ������2�����������飬����10��
%source_theta 10*2 ÿһ�е�һ������ʾazi���ڶ�������ʾelev
%sp_theta     30*2 ÿ���й���һ���������飬��10��

function [source_theta,sp_theta]=get_source_speaker_group()
% cipic����azi��elev�ı仯��Χ
% azimuth_range= [-80 -65 -55 -45:5:45 55 65 80]';
% elevation_range=[-45:360/64:235]';

% %���Կ���azi elev
% sp_azi=[-80 -65 -45 -30 -15 0 15 30 45 65 80]
% sp_elev=[0 11.25 22.5 33.75 45 56.25 67.5 78.75 90  112.5 135 146.25 157.5 168.75 180]


%ǰ��
source_theta_front=[0 11.25; 0 33.75];
sp_theta_front=[-30 0;30 0;0 33.75; -45 0;45 0;0 56.25 ];

%��
source_theta_left=[-80 11.25; -80 33.75];
sp_theta_left=[-65 0;-65 180;-80 33.75; -45 0;-45 180;-80 56.25];

%�ҷ�
source_theta_right=[80 11.25; 80 33.75];
sp_theta_right=[65 0;65 180;80 33.75; 45 0;45 180;80 56.25];

%��
source_theta_back=[0 168.75;0 146.25];
sp_theta_back=[-30 0;30 0;0 146.25; -45 0;45 0;0 112.5];

%�Ϸ�
source_theta_up=[0 135; 0 90];
sp_theta_up=[0 56.25; -55 146.25; 55 146.25; -45 78.75; 45 78.75; 0 168.75];

%ȫ���������ķ���
source_theta=[source_theta_front;source_theta_left;source_theta_right;source_theta_back;source_theta_up];
sp_theta=[sp_theta_front;sp_theta_left;sp_theta_right;sp_theta_back;sp_theta_up];

end


