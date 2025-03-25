% Using a similar outline for how to make the ocean color plots, but instead
% of saving the tiff files from each day, creating an empty array and saving
% the SSS from only SMAP into mat files

%% Defining and saving the date and SSS for each day (This is a spatial resolution)
clear;
clc;
close all;

%%%%% If changing the path or data type, be sure to change the file save name 
path1 = '/Volumes/Lacie-SAN/SAN2/SMAP-RSS/SMAP-SSSV5.3-Oct2023/L3/8day_running/'; % SMAP 4/1/2015 - 12/31/2023
path2 = '/Volumes/PamelaResearch/Ricky_Project/Fig_1/'; % Save path
%Save path when using personal:
%path2 = '/Users/pameladoran/Documents/MATLAB/USC/';

% Generate a list of all dates from 2015 to 2023
dates = datetime(2015, 1, 1):datetime(2023, 12, 31);

% Define the GoM region
min_lat = 17;
max_lat = 32;
min_lon = 262;
max_lon = 282;

% Preallocate a structure to hold data
SSS_SMAP = struct('date', {}, 'sss', {});


% Loop through all dates to store sss in SMAP_SSS
for d = 1:length(dates)
    current_date = dates(d);
    date1 = year(current_date);
    date2 = month(current_date);
    date3 = day(current_date);

    % Defining NumDays for files that use Julian
    NumDays = datenum(date1, date2, date3) - datenum(date1-1, 12, 31);
    NumDays = num2str(NumDays, '%03d');
    
    % Construct file path
    path1a = [path1 num2str(year(current_date)) '/' ];
    % RSS_smap_SSS_L3_8day_running_2015_091_FNL_v05.3.nc
    fileN1 = dir([path1a,'RSS_smap_SSS_L3_8day_running_' num2str(date1) '_' NumDays '_FNL_v05.3.nc']);
    disp (['RSS_smap_SSS_L3_8day_running_' num2str(date1) '_' num2str(NumDays) '_FNL_v05.3.nc']);

    if isempty(fileN1)
        warning('File not found for date: %s', current_date);
        continue;
    end
    
    fname1 = fullfile(path1a, fileN1.name);
    
    % Read data from the .nc file
    lon1_full = ncread(fname1, 'lon');
    lat1_full = ncread(fname1, 'lat');
    sss1_full = ncread(fname1, 'sss_smap_40km');
    
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
    SSS_SMAP(end +1).date = current_date;
    % SSS_SMOS(end).lon = lon1_clip;
    % SSS_SMOS(end).lat = lat1_clip;
    SSS_SMAP(end).sss = sss1_clip;
    

    disp(['Processing: ' num2str(date1) ' ' num2str(date2) ' ' num2str(date3) ]); %To know its working
end

%% Calculating the spatial mean for each day (Each day only has one SSS value)
%Assigning the new empty structure
SSS_SMAP_mean = struct('date', {}, 'sss_mean', {});

% loop through each day in SSS_SMOS to calculate daily spatial mean and
% save in SSS_SMOS_mean
for i = 1:length(SSS_SMAP)

    % load in that day's sss map
    sss_i = SSS_SMAP(i).sss;

    % take mean across all dimensions
    sss_im = mean(sss_i,'all','omitnan');
    % ^ "omitnan" option ignores missing data (or else mean would = NaN)

    % assign that value to the new output structure
    SSS_SMAP_mean(i).sss_mean = sss_im;
    % and date from SSS_SMOS
    SSS_SMAP_mean(i).date = SSS_SMAP(i).date;
end

%% Calculating monthly averages (Only one SSS value for each month)

% Extract dates and SSS means into a table
dates = [SSS_SMAP_mean.date];
sss_means = [SSS_SMAP_mean.sss_mean];
dataTable = table(dates', sss_means', 'VariableNames', {'Date', 'SSS_Mean'});

% Convert dates to a year-month format for grouping
% Create a new column in the table for year-month
dataTable.YearMonth = dateshift(dataTable.Date, 'start', 'month', 'nearest');

% Use groupsummary to calculate monthly means
monthlySummary = groupsummary(dataTable, 'YearMonth', 'mean', 'SSS_Mean');

% Store the results into a .mat file
% Convert monthlySummary to a structure for saving
%SSS_SMAP_monthly = table(monthlySummary.YearMonth, monthlySummary.mean_SSS_Mean, 'VariableNames', {'YearMonth_SMAP', 'sss_map_mean_SMAP'});
SSS_SMAP_monthly = struct('YearMonth', monthlySummary.YearMonth, 'MeanSSS', monthlySummary.mean_SSS_Mean);

% Display the results
disp('Monthly Averages saved to SSS_SMOS_monthly.mat:');
disp(SSS_SMAP_monthly);

% Save the data into a .mat file
save(fullfile(path2, 'SSS_SMAP_monthly.mat'), 'SSS_SMAP_monthly');


disp('Finished')
