%% Defining 4 boxes in the gulf of mexico in which we will
% take averages of those boxes and make a timseries

close all;
clear;

addpath(genpath('/Users/pameladoran/Documents/Toolbox-19May2024'));
load ('/Volumes/PamelaResearch/Ricky_Project/Fig_2/monthly_avg_sss_SMAP.mat'); %monthly SMAP SSS 2010 to 2023
load ('/Volumes/PamelaResearch/Ricky_Project/Fig_3/GoM_SMAP_Flux_UV_2015to2023.mat'); %monthly flux values 2010 to 2023
load('/Volumes/PamelaResearch/Ricky_Project/Fig_2/monthly_avg_uv.mat') %Averaged surface velocity
load('/Volumes/PamelaResearch/Ricky_Project/Fig_1/discharge_ts.mat') % want only atch_m and miss_m
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

mafla_box_SMAP = zon_flux_SMAP(46:53, 33:48, :); %(lat, lon, day) or (x,y,day)
FSt_box_SMAP = zon_flux_SMAP(26:32, 60:72, :);
WFS_box_SMAP = mer_flux_SMAP(26:49, 48:60, :);
YtC_box_SMAP = mer_flux_SMAP(17:25, 46:52, :);

%% Need to take the spatial average of boxes and SMAP SSS 
% Want only one flux value and SSS value per day - matching discharge

% Take the mean and rearrange
mafla_mean_SMAP = nanmean(nanmean(mafla_box_SMAP)); %takes the mean accross the first two dimemsions
mafla_mean_SMAP = permute(mafla_mean_SMAP, [3,2,1]); %reagreanges the dim by vector order

%Repeat for Florida Strait
FSt_mean_SMAP = nanmean(nanmean(FSt_box_SMAP));
FSt_mean_SMAP = permute(FSt_mean_SMAP, [3,2,1]); %could also use squeeze function

%Repeat for West Florida Shelf
WFS_mean_SMAP = nanmean(nanmean(WFS_box_SMAP));
WFS_mean_SMAP = permute(WFS_mean_SMAP, [3,2,1]);

%Repeat for Yucatan Channel
YtC_mean_SMAP = nanmean(nanmean(YtC_box_SMAP));
YtC_mean_SMAP = permute(YtC_mean_SMAP, [3,2,1]);

%Repeat for SMAP SSS
SMAP_mean = nanmean(nanmean(sss_map_mean_SMAP));
SMAP_mean = permute(SMAP_mean, [3,2,1]);

%% Shortening the discharge variables to match SMAP

atch_m = atch_m(64:end);
miss_m = miss_m(64:end);


%% Save 7 total variables to a table (columns = variables, rows = days)
% 1 SSS, 2 discharge, and 4 boxes - These will be used for regression analysis

SMAP_table = table(SMAP_mean, atch_m, miss_m, mafla_mean_SMAP, FSt_mean_SMAP, WFS_mean_SMAP, YtC_mean_SMAP);
save(fullfile(savepath, 'SMAP_mean_Table'), 'SMAP_table');


