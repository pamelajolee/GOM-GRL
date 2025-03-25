% Using a similar outline for how to make the ocean color plots, but instead
% of saving the tiff files from each day, creating an empty array and saving
% the SSS from only SMOS into mat files

%% Defining and saving the date and SSS for each day (This is a spatial resolution)
clear;
clc;
close all;

% If changing the path or data type, be sure to change the file save name
%path1 = '/Volumes/Lacie-SAN/SAN2/SMOS_BEC_GLOBAL/v2_L4/daily/'; % SMOS L4 1/24/2011 to 5/25/2021
%ncdisp('/Volumes/Lacie-SAN/SAN2/SMOS-LOCEAN-GLOBAL-LATEST/L3-DEBIAS-LOCEN_v9/debiasedSSS_09days_v9.0/SMOS_L3_DEBIAS_LOCEAN_AD_20231230_EASE_09d_25km_v09.nc')

path1 = '/Volumes/Lacie-SAN/SAN2/SMOS-LOCEAN-GLOBAL-LATEST/L3-DEBIAS-LOCEN_v9/debiasedSSS_09days_v9.0/'; %SMOS v9 L3 1/4/2010 to 12/30/2023
path2 = '/Volumes/PamelaResearch/Ricky_Project/files/Fig_1/'; % Save path

%Save path when using personal:
%path2 = '/Users/pameladoran/Documents/MATLAB/USC/';

% Generate a list of all dates from 2011 to 2021
dates = datetime(2010, 1, 1):datetime(2023, 12, 31);

% Define the GoM region
min_lat = 17;
max_lat = 32;
min_lon = -98;
max_lon = -78;

% Preallocate a structure to hold data
%SSS_SMOS = struct('date', {}, 'lon', {}, 'lat', {}, 'sss', {});
SSS_SMOS = struct('date', {}, 'sss', {});


% Loop through all dates to store sss in SMOS_SSS
for d = 1:length(dates)
    current_date = dates(d);
    date_str = datestr(current_date, 'yyyymmdd');
    
    % Construct file path
    %path1a = [path1 num2str(year(current_date)) '/' ]; % L3 is not split
    %into years
    % SMOS_L3_DEBIAS_LOCEAN_AD_20231230_EASE_09d_25km_v09.nc
    fileN1 = dir([path1,'SMOS_L3_DEBIAS_LOCEAN_AD_' date_str '_EASE_09d_25km_v09.nc']);
    
    if isempty(fileN1)
        warning('File not found for date: %s', date_str);
        continue;
    end
    
    fname1 = fullfile(path1, fileN1.name);
    
    % Read data from the .nc file
    lon1_full = ncread(fname1, 'lon');
    lat1_full = ncread(fname1, 'lat');
    sss1_full = ncread(fname1, 'SSS'); %Capital SSS for SMOS v9 l3
    
    % Find indices within the GoM region
    lat1_idx = lat1_full >= min_lat & lat1_full <= max_lat;
    lon1_idx = lon1_full >= min_lon & lon1_full <= max_lon;
    
    lat1_clip = lat1_full(lat1_idx);
    lon1_clip = lon1_full(lon1_idx);

    lon1 = double(lon1_clip);
    lat1 = double(lat1_clip); 

    [lon1_int, lat1_int] = meshgrid(lon1, lat1);
    
    % Clip SSS data
    sss1_clip = sss1_full(lon1_idx, lat1_idx)';
    
    % Store data in the structure array
    SSS_SMOS(end +1).date = current_date;
    % SSS_SMOS(end).lon = lon1_clip;
    % SSS_SMOS(end).lat = lat1_clip;
    SSS_SMOS(end).sss = sss1_clip;
    
    disp(['Processing: ' date_str ]); %To know that it's working
end

%SSS_SMOS_daily = struct('SSS', SSS_SMOS.date);


% Can use the below code in the command window to check that the data is 
%corectly centered arond the GoM: 
% pcolor(lon1_int, lat1_int, sss1_clip); shading flat

%% Calculating the spatial mean for each day (Each day only has one SSS value)
%Assigning the new empty structure
SSS_SMOS_mean = struct('date', {}, 'sss_mean', {});

% loop through each day in SSS_SMOS to calculate daily spatial mean and
% save in SSS_SMOS_mean
for i = 1:length(SSS_SMOS)

    % load in that day's sss map
    sss_i = SSS_SMOS(i).sss;

    % take mean across all dimensions
    sss_im = mean(sss_i,'all','omitnan');
    % ^ "omitnan" option ignores missing data (or else mean would = NaN)

    % assign that value to the new output structure
    SSS_SMOS_mean(i).sss_mean = sss_im;
    % and date from SSS_SMOS
    SSS_SMOS_mean(i).date = SSS_SMOS(i).date;
end

%% Calculating monthly averages (Only one SSS value for each month)


% Extract dates and SSS means into a table
dates = [SSS_SMOS_mean.date];
sss_means = [SSS_SMOS_mean.sss_mean];
dataTable = table(dates', sss_means', 'VariableNames', {'Date', 'SSS_Mean'});

% Convert dates to a year-month format for grouping
% Create a new column in the table for year-month
dataTable.YearMonth = dateshift(dataTable.Date, 'start', 'month', 'nearest');

% Use groupsummary to calculate monthly means
monthlySummary = groupsummary(dataTable, 'YearMonth', 'mean', 'SSS_Mean');

% Store the results into a .mat file
% Convert monthlySummary to a structure for saving
SSS_SMOS_monthly_L3 = struct('YearMonth', monthlySummary.YearMonth, 'MeanSSS', monthlySummary.mean_SSS_Mean);

% Display the results
disp('Monthly Averages saved to SSS_SMOS_monthly.mat:');
disp(SSS_SMOS_monthly_L3);

% Save the data into a .mat file
save(fullfile(path2, 'SSS_SMOS_monthly_L3.mat'), 'SSS_SMOS_monthly_L3');

disp('Finished')
