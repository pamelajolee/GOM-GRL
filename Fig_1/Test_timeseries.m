%% Plotting SSS Seasonal Cycle from 2010 to 2023
%Loading in data from salt_nc_to_mat
clear;clc;  
addpath /Users/pameladoran/Documents/Toolbox-19May2024/

%% 
%load /Volumes/PamelaResearch/Ricky_Project/files/Fig_1/SSS_SMOS_mean.mat;

%%Seperate path when using macbook
load '/Volumes/PamelaResearch/Ricky_Project/files/USGS_files_MISS_ATCHA/Mississippi_07374000.xlsx'; 
%path2 = '/Volumes/PamelaResearch/Ricky_Project/files/Fig_1/'; % Save path


% Looping through each of the sss values for each day to easily assign them
% to x and y values
% With current structure of SSS_SMOS_monthly_L4, there is no need to loop through each, 
% can now easily just plot x and y values
% x1 = SSS_SMOS_monthly_L4(1).YearMonth:SSS_SMOS_monthly_L4(end).YearMonth;
% y1 = nan(1,length(x1));
% 
% for i = 1:length(SSS_SMOS_monthly_L4)
%     x1(i) = SSS_SMOS_monthly_L4(i).YearMonth;
%     y1(i) = SSS_SMOS_monthly_L4(i).MeanSSS;
% end
% 
% 
% SmoothSMOS = smoothdata(y1, 'gaussian');
% 
% figure; plot(x1,SmoothSMOS);

x1 = SSS_SMAP_monthly.YearMonth;
y1 = SSS_SMAP_monthly.MeanSSS;
y1 = smoothdata(y1, 'gaussian');

figure(1)
set(gcf, "Position", [420 332 916 441])
plot(x1, y1, 'LineWidth', 4, 'Color', 'b');
ylabel('Sea Surface Salinity (psu)');
set(gca, "FontName", 'Times New Roman', 'FontSize', 16);
%title('Timeseries of SMOS BEC GLOBAL V2 L4 Monthly Averaged SSS');
%figname = ([path2 'SMOS_SSS_L4_Timeseries']);
%saveas(gcf, figname, 'tif');


