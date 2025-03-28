%% Obtaining and averaging SMOS data to create monthly maps of SSS
% Shorting the time of SMOS data to match SMAP availability to help correct
% the seasonal signal (only 2015 to 2023)
%This will help produce a more accruate reggesion analysis
clear;
clc;
close all;

path1 = '/Volumes/Lacie-SAN/SAN2/SMOS-LOCEAN-GLOBAL-LATEST/L3-DEBIAS-LOCEN_v9/debiasedSSS_09days_v9.0/'; % SMOS v9 L3 1/4/2010 to 12/30/2023
path2 = '/Volumes/PamelaResearch/Ricky_Project/Fig_4/'; % Save path

% Generate a list of all dates from 2010 to 2023
dates = datetime(2015, 1, 1):datetime(2023, 12, 31);

% Define the GoM region
min_lat = 17;
max_lat = 32;
min_lon = -98;
max_lon = -78;

% Preallocate a structure to hold data
SSS_SMOS = struct('date', {}, 'sss', {});

% Loop through all dates to store SSS in SSS_SMOS
for d = 1:length(dates)
    current_date = dates(d);
    date_str = datestr(current_date, 'yyyymmdd');
    
    % Construct file path
    fileN1 = dir([path1,'SMOS_L3_DEBIAS_LOCEAN_AD_' date_str '_EASE_09d_25km_v09.nc']);
    
    if isempty(fileN1)
        warning('File not found for date: %s', date_str);
        continue;
    end
    
    fname1 = fullfile(path1, fileN1.name);
    
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

    [lon1_int, lat1_int] = meshgrid(lon1, lat1);
    
    % Clip SSS data
    sss1_clip = sss1_full(lon1_idx, lat1_idx)';
    
    % Store data in the structure array
    SSS_SMOS(end +1).date = current_date;
    %SSS_SMOS(end).lon = lon1_clip;
    %SSS_SMOS(end).lat = lat1_clip;
    SSS_SMOS(end).sss = sss1_clip;
    
    disp(['Processing: ' date_str ]); % To know that it's working
end

%% Calculating monthly averages

dataTable = struct2table(SSS_SMOS);

% Create a new column in the table for year-month
dataTable.YearMonth = dateshift(dataTable.date, 'start', 'month');

% Eliminate repeats
uniqueYearMonths_SMOS = unique(dataTable.YearMonth);

%Create mapout array
numMonths = length(uniqueYearMonths_SMOS);
sss_map_mean_SMOS = nan(length(lat1_clip), length(lon1_clip), numMonths);

% Loop through each unique YearMonth
for i = 1:numMonths
    currentYearMonth = uniqueYearMonths_SMOS(i);
    
    % Find indices for the current month
    ind = find(dataTable.YearMonth == currentYearMonth);
    
    % Define a 3D array that is the correct size (lat x lon x number of days)
    sss_map_i = nan(length(lat1_clip), length(lon1_clip), length(ind));
    
    % Loop through each day in that month
    for j = 1:length(ind)
        % Extract each daily map
        getmap = dataTable.sss{ind(j)};
        % Assign it to the correct position in our 3D array
        sss_map_i(:,:,j) = getmap;
       
    end
    
    % Take the mean across all days in the 3rd dimension to get 1 map (2D)
    mapmean = mean(sss_map_i, 3, 'omitnan');
    
    % Assign it to the correct monthly index (i) in our big 3D output
    sss_map_mean_SMOS(:,:,i) = mapmean;
end

% Save the result to a .mat file
save(fullfile(path2, 'monthly_avg_sss_SMOS_2015to2023.mat'), 'sss_map_mean_SMOS', 'lat1_int', 'lon1_int', 'uniqueYearMonths_SMOS');

disp('Finished');
