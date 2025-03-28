%Calculating FW Flux from SMOS and OSCAR Total Surface Currents
clear;clc;close all;
addpath(genpath('/Users/pameladoran/Documents/Toolbox-19May2024'));
savepath= '/Volumes/PamelaResearch/Ricky_Project/Fig_3/';

%% Loading Salinity and UV data
% OSCAR UV monthly averages
load('/Volumes/PamelaResearch/Ricky_Project/Fig_2/OSCAR_monthly_uv.mat') %Averaged surface velocity for GoM
lon3_int = lon3_int(:,:) - 360;
%SMOS SSS Monthly averages
load ('/Volumes/PamelaResearch/Ricky_Project/Fig_2/monthly_avg_sss_SMOS.mat'); %monthly SMOS SSS 2010 to 2023
% SMOS HAS DATA FOR EVERY MONTH SO AUGUST WILL START AT INDEX 8 AND
% INCREASE EVERY 12

% Assigning new variables for SSS and UV for easier readability
mean_sss = sss_map_mean_SMOS(:,:,1:end-16); % 70x77x168 double
U = u_map_mean; % 59x78x152 double
V = v_map_mean; % 59x78x152 double

%% Interpolating 

% need to first create empty array that matches the size of U (or V)
mean_sss_interp = zeros(size(U)); 

% Loop through each time step to interpolate
for t = 1:size(mean_sss, 3) 
    mean_sss_interp(:, :, t) = interp2(lon1_int, lat1_int, mean_sss(:, :, t), lon3_int, lat3_int, 'linear');
end

% Since only using lon3_int and lat3_int, changing to just lat and lon for
% easier calculations
lon = lon3_int;
lat = lat3_int;
% cleaning up variables to better see what I'm working with
clear lon1_int lon3_int lat1_int lat3_int sss_map_mean_SMOS u_map_mean v_map_mean; 

%% Calculating Salinity Anoamly

% Sfw = (Sref - SSS)/ Sref
Sref = 36.5; %accepted ref value for GoM

% Sfw = freshwater salinity anomaly (pss or psu)
Sfw_SMOS = (Sref - mean_sss_interp)./Sref;


%% Calculating dx (also technically dy, but resolution = 0.25 in both directions)

% dx = 0.25 degrees
%deg2km and * 1000
dx = deg2km(lon(1,2) - lon(1,1));
dy = deg2km(lat(2,1) - lat(1,1));

dx = dx.*1000;
dy = dy.*1000;

%% Calculating Flux - timeseries of maps of flux

% zon_flux = U * sfw * dx
% mer_flux = V * sfw * dy?

zon_flux_SMOS = U.*Sfw_SMOS.*dx;
mer_flux_SMOS = V.*Sfw_SMOS.*dy;

%% Test plots
figure(1);
% U FW flux for Aug 2011
% Plotting the GoM
ax5 = gca;
m_proj('mercator','longitude',[-98 -78],'latitude',[17 32]) %initialize map
m_coast('line');
hold on;

%Plot zon_flux as a colormap -use lon3 and lat3 - same grid
m_pcolor(lon, lat, zon_flux_SMOS(:,:,20)); 
shading interp;
colormap(redblue(24)); 
clim([-800 800]);
hold on;

%Making the plot look better
m_gshhs_i('patch',[0.8 0.8 0.8]);
m_grid('box','on','linewidth',3, 'fontsize', 18 ,'YaxisLocation', 'left', 'visible', 'off')
%m_grid('xtick',10,'tickdir','out','yaxislocation','right','fontsize',7);
colorbar;

title(ax5, 'U FW Flux', 'Units', 'normalized', 'Position', [0.051, 0.88, 0], 'HorizontalAlignment', 'left');
set(ax5,'fontname','times new roman','fontsize',24);
text(ax5, min(xlim + 0.004 ), min(ylim +0.003), '(e)', 'FontSize', 24, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');
%freezeColors;

%% %V FW flux Aug 2011
figure(2)
% V FW flux for Aug 2011
% Plotting the GoM
ax5 = gca;
m_proj('mercator','longitude',[-98 -78],'latitude',[17 32]) %initialize map
m_coast('line');
hold on;

%Plot zon_flux as a colormap -use lon3 and lat3 - same grid
m_pcolor(lon, lat, mer_flux_SMOS(:,:,20)); 
shading interp;
colormap(redblue(24)); 
clim([-800 800]);
hold on;

%Making the plot look better
m_gshhs_i('patch',[0.8 0.8 0.8]);
m_grid('box','on','linewidth',3, 'fontsize', 18 ,'YaxisLocation', 'left', 'visible', 'off')
%m_grid('xtick',10,'tickdir','out','yaxislocation','right','fontsize',7);
colorbar;


title(ax5, 'V FW Flux', 'Units', 'normalized', 'Position', [0.051, 0.88, 0], 'HorizontalAlignment', 'left');
set(ax5,'fontname','times new roman','fontsize',24);
text(ax5, min(xlim + 0.004 ), min(ylim +0.003), '(e)', 'FontSize', 24, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');
%freezeColors;

% Both Plot correctly matching Figure 3 from Brokaw et al 2019

%% Saving zon and mer flux

% Save the result to a .mat file
save(fullfile(savepath, 'GoM_SMOS_Flux_UV_2010to2023_OSCAR.mat'), 'zon_flux_SMOS', 'mer_flux_SMOS', 'Sfw_SMOS');

disp('Finished');

