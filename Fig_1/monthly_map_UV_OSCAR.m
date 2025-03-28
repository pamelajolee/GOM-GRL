%% Checking the geostrophic currents obtained from CMEMS against the total current from OSCAR
% Collecting and averging the UV data the same as
% getting_monthly_map_UV_CMEMS. These will be used to plot the
% SSS with stramline overlay and calculate the SfW


clear;
clc;
close all;

path1 = '/Volumes/PamelaResearch/MATLAB_files/OSCAR_L4_OC_FINAL_V2/'; %OSCAR 
savepath = '/Volumes/PamelaResearch/Ricky_Project/Fig_2/'; % Save path

% Generate a list of all dates from 2010 to 2022
dates = datetime(2010, 1, 1):datetime(2022, 12, 31); 
% OSCAR only has total currents up to Aug. 2022 currently

% Define the GoM region : OSCAR = 0 to 360
% OSCAR also includes full degree, so need to have range slightly smaller
% to plot on SSS grid
min_lat = 17.5;
max_lat = 32.25;
min_lon = 262;
max_lon = 281.75;

% Preallocate a structure to hold data
OSCAR_UV = struct('date', {}, 'u_vel', {}, 'v_vel', {});

%% Loop through 2010 to 2022 to store data in OSCAR_UV
for d = 1:length(dates)
    current_date = dates(d);
    date1 = year(current_date);
    date2 = month(current_date);
    date3 = day(current_date);

    %NumDays= day(current_date, 'dayofyear');
    
    % Construct file path
    path1a = [path1 num2str(year(current_date)) '/' ];
    % oscar_currents_final_20220101.nc
    fileN1 = dir([path1a, 'oscar_currents_final_' num2str(date1) num2str(date2, '%02d') num2str(date3, '%02d') '*.nc']);
    
    if isempty(fileN1)
        warning('File not found for date: %s', current_date);
        continue;
    end
    
    fname1 = fullfile(path1a, fileN1.name);
    
    %Grabbing the lat and lon data
    lon3_full = ncread(fname1, 'lon');
    lat3_full = ncread(fname1, 'lat');
    
    %Clipping data to GoM
    lat3_idx = lat3_full >= min_lat & lat3_full <= max_lat;
    lon3_idx = lon3_full >= min_lon & lon3_full <=max_lon;
    
    lat3_clip = lat3_full(lat3_idx);
    lon3_clip = lon3_full(lon3_idx);
    
    lon_uv = double(lon3_clip);
    lat_uv = double(lat3_clip);
    
    [lon3_int, lat3_int] = meshgrid(lon_uv, lat_uv);
    
    %Grabbing and Cropping velocity data
    u_vel = ncread(fname1, 'u');
    v_vel = ncread(fname1, 'v');
    u_vel = interp2(lon3_full, lat3_full, u_vel, lon3_int, lat3_int, 'Linear', NaN);
    v_vel = interp2(lon3_full, lat3_full, v_vel, lon3_int, lat3_int, 'Linear', NaN);
    
    % Store data in the structure array
    OSCAR_UV(end +1).date = current_date;
    OSCAR_UV(end).u_vel = u_vel;
    OSCAR_UV(end).v_vel = v_vel;
    
    disp(['Processing: ' num2str(date1) ' ' num2str(date2) ' ' num2str(date3) ]); %To know its working
end


%% Calculating monthly averages

dataTable = struct2table(OSCAR_UV);

% Create a new column in the table for year-month
dataTable.YearMonth = dateshift(dataTable.date, 'start', 'month');

% Eliminate repeats
uniqueYearMonths_UV = unique(dataTable.YearMonth);

%Create mapout array
numMonths = length(uniqueYearMonths_UV);
u_map_mean = nan(length(lat_uv), length(lon_uv), numMonths);
v_map_mean = nan(length(lat_uv), length(lon_uv), numMonths);

% Loop through each unique YearMonth
for i = 1:numMonths
    currentYearMonth = uniqueYearMonths_UV(i);
    
    % Find indices for the current month
    ind = find(dataTable.YearMonth == currentYearMonth);
    
    % Define a 3D array that is the correct size (lat x lon x number of days)
    u_map_i = nan(length(lat_uv), length(lon_uv), length(ind));
    v_map_i = nan(length(lat_uv), length(lon_uv), length(ind));
    
    % Loop through each day in that month
    for j = 1:length(ind)
        % Extract each daily map
        getmap_u = dataTable.u_vel{ind(j)};
        getmap_v = dataTable.v_vel{ind(j)};
        % Assign it to the correct position in our 3D array
        u_map_i(:,:,j) = getmap_u;
        v_map_i(:,:,j) = getmap_v;
       
    end
    
    % Take the mean across all days in the 3rd dimension to get 1 map (2D)
    mapmean_u = mean(u_map_i, 3, 'omitnan');
    mapmean_v = mean(v_map_i, 3, 'omitnan');
    
    % Assign it to the correct monthly index (i) in our big 3D output
    u_map_mean(:,:,i) = mapmean_u;
    v_map_mean(:,:,i) = mapmean_v;
end

% Save the result to a .mat file
save(fullfile(savepath, 'OSCAR_monthly_uv.mat'), 'u_map_mean', 'v_map_mean', 'lat3_int', 'lon3_int', 'uniqueYearMonths_UV');

disp('Finished');
