function [lon1_int_sss, lat1_int_sss, sss1_clip] = retrieveSMOS_SSS(year, month, day)
% function to grab SSS based off a single day entry to make subplots easier

path1 = '/Volumes/Lacie-SAN/SAN2/SMOS-LOCEAN-GLOBAL-LATEST/L3-DEBIAS-LOCEN_v9/debiasedSSS_09days_v9.0/';
% SMOS v9 L3 1/4/2010 to 12/30/2023

% Define the GoM region
min_lat = 17;
max_lat = 32;
min_lon = -98;
max_lon = -78;

% Construct date strings
date1 = num2str(year, '%04d');
date2 = num2str(month, '%02d');
date3 = num2str(day, '%02d');

% Construct file path
fileN1 = dir([path1,'SMOS_L3_DEBIAS_LOCEAN_AD_' date1 date2 date3 '_EASE_09d_25km_v09.nc']);

if isempty(fileN1)
    warning(['File not found for date: %s'  date2 ' ' date3 ' ' date1]);
end

fname1 = [path1 fileN1.name];

% Read data from the .nc file
lon1_full = ncread(fname1, 'lon');
lat1_full = ncread(fname1, 'lat');
sss1_full = ncread(fname1, 'SSS'); % Capital SSS for SMOS v9 L3

% Find indices within the GoM region
lat1_idx = lat1_full >= min_lat & lat1_full <= max_lat;
lon1_idx = lon1_full >= min_lon & lon1_full <= max_lon;

lat1_clip = lat1_full(lat1_idx);
lon1_clip = lon1_full(lon1_idx);

lon1 = double(lon1_clip);
lat1 = double(lat1_clip);

[lon1_int_sss, lat1_int_sss] = meshgrid(lon1, lat1);

% Clip SSS data
sss1_clip = sss1_full(lon1_idx, lat1_idx)';

end

