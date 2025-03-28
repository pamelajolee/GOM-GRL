%% Computing different variables to help determine the correlation and variance between SSS and Discharge
% Need to first load in (shortened) SMOS SSS, and SMAP (2015 to 2023)
% Next load in discharge data and shorten to 2015 to 2023
% Calculate Correlation Coef (R)
% R^2 = variance

%% Loading Previous variable - updated work at bottom
close all;
clear;
clc;

addpath(genpath('/Users/pameladoran/Documents/Toolbox-19May2024'));
savepath= '/Volumes/PamelaResearch/Ricky_Project/Fig_3/';

% Starting with just SMOS and MS discharge to make sure the process is
% correct

% load('/Volumes/PamelaResearch/Ricky_Project/Fig_1/discharge_ts.mat'); % Independent MS and Actha discharge
% load('/Volumes/PamelaResearch/Ricky_Project/Fig_1/SSS_SMOS_monthly_L3.mat') % 
% load('/Volumes/PamelaResearch/Ricky_Project/Fig_1/SSS_SMAP_monthly.mat') % Monthly SMAP 2015 to 2023
% load ('/Volumes/PamelaResearch/Ricky_Project/Fig_3/GoM_SMOS_Flux_UV_2010to2023.mat'); % SMOS flux 
% load ('/Volumes/PamelaResearch/Ricky_Project/Fig_3/GoM_SMAP_Flux_UV_2015to2023.mat'); %SMAP flux values 2015 to 2023
% 
% %% Regression Coefficeint 
% 
% % Predictor(x) = Discharge
% % Response(y) = SSS
% 
% x = miss_m;
% y = SSS_SMOS_monthly_L3.MeanSSS(1:end-1);
% b1 = x\y;
% 
% mdl = fitlm(x,y); % might be better - check with stepwise can check multiple x's
% 
% %% Plotting SMOS vs. MS Discharge
% 
% yCalc1 = b1*x;
% scatter(x,y)
% hold on
% plot(x,yCalc1)
% ylim([34 37])
% xlabel('MS River Discharge (m^{3}/s)')
% ylabel('SMOS (psu)')
% title('Linear Regression Relation Between GoM Salinity and Discharge')
% grid on


%% Loading in the two seperate tables for SMOS and SMAP

load('/Volumes/PamelaResearch/Ricky_Project/Fig_4/SMOS_mean_Table.mat');
load('/Volumes/PamelaResearch/Ricky_Project/Fig_4/SMAP_mean_Table.mat');

%% Shifting Atch and Miss to August for SMOS table
% first, covert table to array, exctract each array from table, append nan values  
% to the first four values, delete the last 4 rows, then place back into the table.

% Assiging to arrays for easy shifting
array_smos = table2array(SMOS_table);  
atch_array1 = array_smos(:, 2);        
miss_array1 = array_smos(:, 3);        

% Append NaN values to the beginning of Atch and Miss arrays
atch_array_shifted = [NaN(4,1); 
atch_array1(1:end-4)]; % Removes the last 4
miss_array_shifted = [NaN(4,1); 
miss_array1(1:end-4)]; 

% Remove top four rows
array_smos = zscore(array_smos(5:end, :));

% Return arrays to the table
array_smos(:, 2) = zscore(atch_array_shifted(5:end, :), [], 1);  % compare accross variables with different units
array_smos(:, 3) = zscore(miss_array_shifted(5:end, :), [], 1);  

% Convertarray back into a table to use stepwise
SMOS_table_shifted = array2table(array_smos, 'VariableNames', SMOS_table.Properties.VariableNames);

% Display to check its correct
disp(SMOS_table_shifted);

%% Repeating the process for SMAP to make sure they show the same significance

% Assiging to arrays for easy shifting
array_smap = table2array(SMAP_table);  
atch_array2 = array_smap(:, 2);        
miss_array2 = array_smap(:, 3);        

% Append NaN values to the beginning of Atch and Miss arrays
atch_array_shifted = [NaN(4,1); 
atch_array2(1:end-4)]; % Removes the last 4
miss_array_shifted = [NaN(4,1); 
miss_array2(1:end-4)]; 

% Remove top four rows
array_smap = zscore(array_smap(5:end, :));

% Return arrays to the table
array_smap(:, 2) = zscore(atch_array_shifted(5:end, :), [], 1);  % compare accross variables with different units
array_smap(:, 3) = zscore(miss_array_shifted(5:end, :), [], 1);  

% Convertarray back into a table to use stepwise
SMAP_table_shifted = array2table(array_smap, 'VariableNames', SMAP_table.Properties.VariableNames);

% Display to check its correct
disp(SMAP_table_shifted);

%% Using Stepwise Regression
% Need to use fliplr because stepwiselm uses right variable as dependant
% variable 
[r_smos,p_smos] = corrcoef(fliplr(array_smos)); % linear cor coef
[r_smap,p_smap] = corrcoef(fliplr(array_smap)); % linear cor coef

mdl_smos = stepwiselm(fliplr(SMOS_table_shifted),'upper', "linear");
mdl_smap = stepwiselm(fliplr(SMAP_table_shifted),'upper','linear');





