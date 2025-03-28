%% Obtaining and averaging SMAP data to create monthly maps of SSS
clear;
clc;
close all;

path1 = '/Volumes/Lacie-SAN/SAN2/SMAP-RSS/SMAP-SSSV5.3-Oct2023/L3/8day_running/'; % SMAP 4/1/2015 - 12/31/2023
% SMAP ONLY HAS APRIL TO DEC EACH YEAR, SO AUGUST WILL BE STARTING AT THE
% 5TH INDEX AND OCCURS EVERY 9 INDECIES 
path2 = '/Volumes/PamelaResearch/Ricky_Project/Fig_2/'; % Save path

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

    NumDays= day(current_date, 'dayofyear');
    
    % Construct file path
    path1a = [path1 num2str(year(current_date)) '/' ];
    % RSS_smap_SSS_L3_8day_running_2015_091_FNL_v05.3.nc
    fileN1 = dir([path1a,'RSS_smap_SSS_L3_8day_running_' num2str(date1) '_' num2str(NumDays, '%03d') '_FNL_v05.3.nc']);
    
    if isempty(fileN1)
        warning('File not found for date: %s', current_date);
        continue;
    end
    
    fname1 = fullfile(path1a, fileN1.name);
    
    % Read data from the .nc file
    lon2_full = ncread(fname1, 'lon');
    lat2_full = ncread(fname1, 'lat');
    sss1_full = ncread(fname1, 'sss_smap');
    
    % Find indices within the GoM region
    lat2_idx = lat2_full >= min_lat & lat2_full <= max_lat;
    lon2_idx = lon2_full >= min_lon & lon2_full <= max_lon;
    
    lat2_clip = lat2_full(lat2_idx);
    lon2_clip = lon2_full(lon2_idx);

    lon2 = double(lon2_clip);
    lat2 = double(lat2_clip); 

    [lon2_int, lat2_int] = meshgrid(lon2, lat2);
    
    % Clip SSS data
    sss1_clip = sss1_full(lon2_idx, lat2_idx)';
    
    % Store data in the structure array
    SSS_SMAP(end +1).date = current_date;
    % SSS_SMOS(end).lon = lon2_clip;
    % SSS_SMOS(end).lat = lat2_clip;
    SSS_SMAP(end).sss = sss1_clip;
    
    disp(['Processing: ' num2str(date1) ' ' num2str(date2) ' ' num2str(date3) ]); %To know its working
end


%% Calculating monthly averages

dataTable = struct2table(SSS_SMAP);

% Create a new column in the table for year-month
dataTable.YearMonth = dateshift(dataTable.date, 'start', 'month');

% Eliminate repeats
uniqueYearMonths_SMAP = unique(dataTable.YearMonth);

%Create SSS map array
numMonths = length(uniqueYearMonths_SMAP);
sss_map_mean_SMAP = nan(length(lat2_clip), length(lon2_clip), numMonths);

% Loop through each unique YearMonth
for i = 1:numMonths
    currentYearMonth = uniqueYearMonths_SMAP(i);
    
    % Find indices for the current month
    ind = find(dataTable.YearMonth == currentYearMonth);
    
    % Define a 3D array that is the correct size (lat x lon x number of days)
    sss_map_i = nan(length(lat2_clip), length(lon2_clip), length(ind));
    
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
    sss_map_mean_SMAP(:,:,i) = mapmean;
end

% Save the result to a .mat file
save(fullfile(path2, 'monthly_avg_sss_SMAP_test.mat'), 'sss_map_mean_SMAP', 'lat2', 'lon2', 'uniqueYearMonths_SMAP');

disp('Finished');
