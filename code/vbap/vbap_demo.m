clear all;
clc;

%% EXAMPLE 2: VBAP Gains  -------------------------
% The steps to obtaining the VBAP gains for a set of directions are:

% a) define loudspeaker setup ls_dirs = [azi1 azi2 ... aziK] for 2D
%    or  ls_dirs = [azi1 elev1; azi2 elev2; ...; aziK elevK] for 3D

% 设置扬声器配置
ls_dirs = [30 -30 0 110 -110]; % define a 2D 5.0 setup in degrees  

%
% b) find valid loudspeaker pairs or triplets:
%    findLsPairs(ls_dirs) for 2D, or
%    findLsTriplets(ls_dirs) for 3D
ls_groups = findLsPairs(ls_dirs);

%
% c) compute inverse matrices for loudspeaker pairs or triplets, needs to 
%    be done once for any panning direction
layoutInvMtx = invertLsMtx(ls_dirs, ls_groups);

%
% d) compute vbap gains for the required source directions, in degrees
src_dirs2D = (0:359)'; % 2D panning directions at every 1deg   虚拟声像方位（0~359度 以1度为间隔）
gains2D = vbap(src_dirs2D, ls_groups, layoutInvMtx); % compute vbap gains （为各个panned angle 计算增益）

% Plot panning gains
figure
polar(src_dirs2D*ones(1,5)*pi/180, gains2D)
title('5.0 VBAP gains')


%%

% Repeat process for an 11.0 3D setup   扬声器配置: 11.0 3D音频系统的
ls_dirs = [30 -30 0 120 -120 90 -90 45 -45 135 -135; 0 0 0 0 0 0 0 45 45 45 45]';
[ls_groups, layout] = findLsTriplets(ls_dirs); % return also triangulation mesh for plotting
figure, subplot(121), plotTriangulation(layout);
view(50,30), zoom(2) % plot triangulation
layoutInvMtx = invertLsMtx(ls_dirs, ls_groups);

% Generate a regular 2D grid of panning directions covering the sphere
aziRes = 5;
elevRes = 5;
%
[Elev, Azi] = meshgrid(-90:elevRes:90, 0:aziRes:360);
src_dirs3D = [Azi(:) Elev(:)];

% Get VBAP gains
gains3D = vbap(src_dirs3D, ls_groups, layoutInvMtx);

% Plot panning gains
ls_num = size(ls_dirs,1);
[nAzi, nElev] = size(Azi);
[X,Y,Z] = sph2cart(Azi*pi/180,Elev*pi/180,1);
subplot(122)
hold on

for nl = 1:ls_num
    gains_grid_nl = reshape(gains3D(:,nl), nAzi, nElev);
    surf(gains_grid_nl.*X,gains_grid_nl.*Y,gains_grid_nl.*Z,gains_grid_nl);
end
axis([-1 1 -1 1 -0.5 1]), axis equal
colorbar, view(50,30), zoom(2), grid
title('11.0 VBAP gains')

% h = gcf; 
% h.Position(3:4) = 1.5*h.Position(3:4);