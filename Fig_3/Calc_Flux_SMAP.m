%Calculating FW Flux from SMAP and CMEMS Geostrophic Currents (SSH)%
clear;clc;
addpath(genpath('/Users/pameladoran/Documents/Toolbox-19May2024'));
savepath= '/Volumes/PamelaResearch/Ricky_Project/Fig_3/';

%% Loading Salinity and UV data
% CMEMS UV monthly averages
load('/Volumes/PamelaResearch/Ricky_Project/Fig_2/monthly_avg_uv.mat') %Averaged surface velocity for GoM

%SMAP SSS Monthly averages
load ('/Volumes/PamelaResearch/Ricky_Project/Fig_2/monthly_avg_sss_SMAP.mat'); %monthly SMAP SSS 2015 to 2023
% Need to crop CMEMS data so that it has the same temporal 3rd dimension


%% Deleting 2010-2014 data from UV

% No need to interplote since CMEMS and SMAP are on the same grid 

mean_sss = sss_map_mean_SMAP; %60x80x105 April 2015 - Dec 2023
U = u_map_mean(:,:,64:end); % 60x80x105 " "
V = v_map_mean(:,:,64:end); % 60x80x105 " "


%% Calculating Salinity Anoamly

% Sfw = (Sref - SSS)/ Sref
Sref = 36.5; %accepted ref value for GoM

% Sfw = freshwater salinity anomaly (pss or psu)
Sfw_SMAP = (Sref - mean_sss)./Sref;


%% Calculating dx (also technically dy, but resolution = 0.25 in both directions)

% dx = 0.25 degrees
%deg2km and * 1000
dx = deg2km(lon3_int(1,2) - lon3_int(1,1));
dy = deg2km(lat3_int(2,1) - lat3_int(1,1));

dx = dx.*1000;
dy = dy.*1000;

%% Calculating Flux - timeseries of maps of flux

% zon_flux = U * sfw * dx
% mer_flux = V * sfw * dy?

zon_flux_SMAP = U.*Sfw_SMAP.*dx;
mer_flux_SMAP = V.*Sfw_SMAP.*dy;

%% Test plots
figure(1);
% U FW flux for Aug 2015
pcolor(zon_flux_SMAP(:,:,5)); shading interp; colormap(redblue(24)); clim([-800 800]); colorbar;

%V FW flux Aug 2015
figure(2)
pcolor(mer_flux_SMAP(:,:,5)); shading interp; colormap(redblue(24)); clim([-800 800]); colorbar;

% Plots correctly matching Figure 3 from Brokaw et al 2019

%% Saving mer and zon flux

% Save the result to a .mat file
save(fullfile(savepath, 'GoM_SMAP_Flux_UV_2010to2023.mat'), 'mer_flux_SMAP', 'zon_flux_SMAP', 'Sfw_SMAP');

disp('Finished');

