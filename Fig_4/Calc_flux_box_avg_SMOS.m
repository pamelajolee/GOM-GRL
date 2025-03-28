%% Defining 4 boxes in the gulf of mexico in which we will
% take averages of those boxes and make a timseries

close all;
clear;

addpath(genpath('/Users/pameladoran/Documents/Toolbox-19May2024'));
load ('/Volumes/PamelaResearch/Ricky_Project/Fig_2/monthly_avg_sss_SMOS.mat'); %monthly SMOS SSS 2010 to 2023
% Made in getting_monthly_map_SMOS
load ('/Volumes/PamelaResearch/Ricky_Project/Fig_3/GoM_SMOS_Flux_UV_2010to2023_OSCAR.mat'); %monthly flux values 2010 to 2023
% Made in Calc_Flux_SMOS
% load('/Volumes/PamelaResearch/Ricky_Project/Fig_2/monthly_avg_uv.mat') %Averaged surface velocity
% % Made in getting_monthly_map_UV
% OSCAR UV monthly averages
load('/Volumes/PamelaResearch/Ricky_Project/Fig_2/OSCAR_monthly_uv.mat') %Averaged surface velocity for GoM
lon3_int = lon3_int(:,:) - 360;
load('/Volumes/PamelaResearch/Ricky_Project/Fig_1/discharge_ts.mat') % want only atch_m and miss_m
% sent from Ricky
savepath= '/Volumes/PamelaResearch/Ricky_Project/Fig_4/';

% Defining the flux boxes
% Looking directly at the lat3_int and lon3_int to find indecies that match
% boxes described in Brokaw et al 2019 
%MAFLA and FLorida straight use zonal flux
% West Florida Shelf and Yucatan channel use Meridional Flux

% EXAMPLE:
% ind(33:48) = ~89-86 degrees West
%ind(46:53) = ~28.5-30 degrees North
% keeping all days so we can make timeseries

mafla_box_SMOS = zon_flux_SMOS(46:53, 33:48, :); %(lat, lon, day) or (x,y,day)
FSt_box_SMOS = zon_flux_SMOS(26:32, 60:72, :);
WFS_box_SMOS = mer_flux_SMOS(26:49, 48:60, :);
YtC_box_SMOS = mer_flux_SMOS(17:25, 46:52, :);

%% Cropping previously defined variables to all be 152 in length
sss_map_mean_SMOS = sss_map_mean_SMOS(:,:,1:end-16);
atch_m = atch_m(1:end-16);
miss_m = miss_m(1:end-16);

%% Need to take the spatial average of boxes and SMOS SSS 
% Want only one flux value and SSS value per day - matching discharge

% Take the mean and rearrange
mafla_mean_SMOS = nanmean(nanmean(mafla_box_SMOS)); %takes the mean accross the first two dimemsions
mafla_mean_SMOS = permute(mafla_mean_SMOS, [3,2,1]); %reagreanges the dim by vector order

%Repeat for Florida Strait
FSt_mean_SMOS = nanmean(nanmean(FSt_box_SMOS));
FSt_mean_SMOS = permute(FSt_mean_SMOS, [3,2,1]); %could also use squeeze function

%Repeat for West Florida Shelf
WFS_mean_SMOS = nanmean(nanmean(WFS_box_SMOS));
WFS_mean_SMOS = permute(WFS_mean_SMOS, [3,2,1]);

%Repeat for Yucatan Channel
YtC_mean_SMOS = nanmean(nanmean(YtC_box_SMOS));
YtC_mean_SMOS = permute(YtC_mean_SMOS, [3,2,1]);

%Repeat for SMOS SSS
SMOS_mean = nanmean(nanmean(sss_map_mean_SMOS));
SMOS_mean = permute(SMOS_mean, [3,2,1]);


%% Save 7 total variables to a table (columns = variables, rows = days)
% 1 SSS, 2 discharge, and 4 boxes - These will be used for regression analysis

SMOS_table = table(SMOS_mean, atch_m, miss_m, mafla_mean_SMOS, FSt_mean_SMOS, WFS_mean_SMOS, YtC_mean_SMOS);
save(fullfile(savepath, 'SMOS_mean_Table_OSCAR'), 'SMOS_table');


