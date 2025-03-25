%% Plotting SSS Seasonal Cycle from 2010 to 2023
%Loading in data from salt_nc_to_mat
clear;clc;  
clf;
addpath /Users/pameladoran/Documents/Toolbox-19May2024/

%% 
%load /Volumes/PamelaResearch/Ricky_Project/files/Fig_1/SSS_SMOS_mean.mat;

%%Seperate path when using macbook
%load '/Volumes/PamelaResearch/Ricky_Project/files/Fig_1/SSS_SMOS_monthly_L4'; 
load '/Volumes/PamelaResearch/Ricky_Project/files/Fig_1/SSS_SMOS_monthly_L3'; 
load '/Volumes/PamelaResearch/Ricky_Project/files/Fig_1/SSS_SMAP_monthly'; 
path2 = '/Volumes/PamelaResearch/Ricky_Project/figures/Fig_1/';

t1b=datetime(2009,12,1,0,0,0);
tb=t1b+calmonths(1:169); tb=tb';
monthempty=NaN(169,1);

x1 = SSS_SMOS_monthly_L3.YearMonth;
y1 = SSS_SMOS_monthly_L3.MeanSSS;
y1 = smoothdata(y1, 'gaussian');

x2 = SSS_SMAP_monthly.YearMonth;
y2 = SSS_SMAP_monthly.MeanSSS;
y2 = smoothdata(y2, 'gaussian');

figure(1)
set(gcf, "Position", [148 358 1956 842])
plot(x1, y1, 'LineWidth', 3, 'Color', 'r');
hold on
plot(x2, y2, 'LineWidth', 3, 'Color', 'b');
l = legend('SMOS', 'SMAP', 'FontSize', 28);
set(l, 'Position', [0.77 0.78 0.11 0.11])
box on;
xlim([tb(1) tb(169)]);

grid off;

ax = gca;
set(ax, 'Fontname', 'Times New Roman', 'FontSize', 22)

ax.YTickLabel = {'35.4', ' ', '35.6', ' ', '35.8', ' ', '36', ' ', '36.2', ' ', '36.4'};
months = month(tb);
ax.XTick = tb(months == 1 | months == 8);
ax.XMinorTick = 'on';

%Only Aug ticks 
ax.XTickLabel(2) = {'AUG'};
ax.XTickLabel(4) = {'AUG'};
ax.XTickLabel(6) = {'AUG'};
ax.XTickLabel(8) = {'AUG'};
ax.XTickLabel(10) = {'AUG'};
ax.XTickLabel(12) = {'AUG'};
ax.XTickLabel(14) = {'AUG'};
ax.XTickLabel(16) = {'AUG'};
ax.XTickLabel(18) = {'AUG'};
ax.XTickLabel(20) = {'AUG'};
ax.XTickLabel(22) = {'AUG'};
ax.XTickLabel(24) = {'AUG'};
ax.XTickLabel(26) = {'AUG'};
ax.XTickLabel(28) = {'AUG'};
ax.XTickLabelRotation = 45;

%Only year ticks - making longer and bolder
ax.XTickLabel(1) = {'\fontsize{22}\bf 2010'};
ax.XTickLabel(3) = {'\fontsize{22}\bf 2011'};
ax.XTickLabel(5) = {'\fontsize{22}\bf 2012'};
ax.XTickLabel(7) = {'\fontsize{22}\bf 2013'};
ax.XTickLabel(9) = {'\fontsize{22}\bf 2014'};
ax.XTickLabel(11) = {'\fontsize{22}\bf 2015'};
ax.XTickLabel(13) = {'\fontsize{22}\bf 2016'};
ax.XTickLabel(15) = {'\fontsize{22}\bf 2017'};
ax.XTickLabel(17) = {'\fontsize{22}\bf 2018'};
ax.XTickLabel(19) = {'\fontsize{22}\bf 2019'};
ax.XTickLabel(21) = {'\fontsize{22}\bf 2020'};
ax.XTickLabel(23) = {'\fontsize{22}\bf 2021'};
ax.XTickLabel(25) = {'\fontsize{22}\bf 2022'};
ax.XTickLabel(27) = {'\fontsize{22}\bf 2023'};
ax.XTickLabel(29) = {'\fontsize{22}\bf 2024'};

yl = ylabel('Sea Surface Salinity (psu)');
set(yl,'Fontname','Times New Roman','Fontsize', 28);

%title('Timeseries of SMOS L3 and SMAP SSS');
figname = ([path2 'SMOS_L3_vs_SMAP_SSS_Timeseries']);
saveas(gcf, figname, 'tif');


