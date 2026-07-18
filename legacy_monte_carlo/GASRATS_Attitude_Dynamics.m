%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GASRATS Translational and Rotational Orbit Dyanamics
%
% Code structure based on Monte Carlos ADCS for LEO Sats Playlist
% "MATLAB Help - Translational Orbit Dynamics for a Low Earth Satellite...
% using ode45"
%
% Translational orbital dynamics equations based on ...
% "Fundamentals of Astrodynamics - Bate, Mueller, and White"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Simulation Started');

%Get Planet Parameters
planet

% Satellite Initial Conditions (NED Coordinates?) 
altitude = 400000; % Meters
x0 = R + altitude;
y0 = 0;
z0 = 0;
inclination = deg2rad(45);
semi_major = norm([x0;y0;z0;]);
vcircular = sqrt(mu/semi_major);
xdot0 = 0;
ydot0 = vcircular*cos(inclination); %Where does this come from
zdot0 = vcircular*sin(inclination); %Where does this come from
stateinitial = [x0;y0;z0;xdot0;ydot0;zdot0];

%Time Window
period = 2*pi/sqrt(mu)*semi_major^(3/2);
number_of_orbits = 1;
tspan = [0 period*number_of_orbits];

%Integrator
[tout,stateout] = ode45(@satellite,tspan,stateinitial);

%Convert state to km
stateout = stateout/1000;

%Extract the state vector
xout = stateout(:,1);
yout = stateout(:,2);
zout = stateout(:,3);

%make an Earth
[X,Y,Z] = sphere(100);
X = X*R/1000;
Y = Y*R/1000;
Z = Z*R/1000;

%plot 3D orbit
fig = figure();
set(fig,'color','white');
plot3(xout,yout,zout,'b-','LineWidth',2);
grid on;
hold on;

% Load built-in topography data and apply as a texture map
load topo
surf(X, Y, Z, 'FaceColor', 'texturemap', 'CData', topo, 'EdgeColor', 'none');
colormap(topomap1)

% Add lighting effects for realistic 3D depth
lighting gouraud
camlight

% Styling and labels
xlabel('X (km)');
ylabel('Y (km)');
zlabel('Z (km)');
title('3D Satellite Orbit');
axis equal;

