%% Creating a 4x1 subplot for the first Fig.
% Changed to Fig. in paper, but don't want to rename everything

% First subplot - Plotting monthly SSS Seasonal Cycle from 2010 to 2023
% Second subplot - SSS Anomaly
% Third - MS and Atcha Discharge
% Fourth - Discharge Anomaly

clear;clc;  
clf;
addpath(genpath('/Users/pameladoran/Documents/Toolbox-19May2024'));
save_path = '/Volumes/PamelaResearch/Ricky_Project/Fig_1/';

% Loading in saved datasets
load '/Volumes/PamelaResearch/Ricky_Project/Fig_1/SSS_SMOS_monthly_L3'; 
load '/Volumes/PamelaResearch/Ricky_Project/Fig_1/SSS_SMAP_monthly'; 
load '/Volumes/PamelaResearch/Ricky_Project/Fig_1'/discharge_ts.mat;
load '/Volumes/PamelaResearch/Ricky_Project/Fig_4/SMOS_mean_Table.mat'; % SMOS Monthly variables for timeseries
load '/Volumes/PamelaResearch/Ricky_Project/Fig_4/SMAP_mean_Table.mat';

clf
figure(1)
t = tiledlayout(4,1);
t.TileSpacing = 'tight';
t.Padding = 'compact';
set(gcf, 'Position', [25 81 1197 1256])

%% Creating arrays for the boxes

beg_2011 = datetime(2011,1,1);
end_2011 = datetime(2011,12,31);

beg_2012 = datetime(2012,1,1);
end_2012 = datetime(2012,12,31);

beg_2019 = datetime(2019,1,1);
end_2019 = datetime(2019,12,31);

beg_2022 = datetime(2022,1,1);
end_2022 = datetime(2022,12,31);

%% Subplot 1 - Monthly SSS for SMOS and SMAP

nexttile;
ax1 = gca;

t1b=datetime(2009,12,1,0,0,0);
tb=t1b+calmonths(1:168); tb=tb';
monthempty=NaN(168,1);

%x1 = SSS_SMOS_monthly_L3.YearMonth;
%y1 = SSS_SMOS_monthly_L3.MeanSSS; - Previous way of monthly mean
y1 = SMOS_table.SMOS_mean;
y1 = smoothdata(y1, 'gaussian');

x2 = SSS_SMAP_monthly.YearMonth(1:105);
%y2 = SSS_SMAP_monthly.MeanSSS;
y2 = SMAP_table.SMAP_mean;
y2 = smoothdata(y2, 'gaussian');

% figure(1)
% set(gcf, "Position", [148 358 1956 842])
plot(x2, y2, 'LineWidth', 3,'Color', [0.114, 0.498, 0.91]); %Sky Blue
hold on;
plot(tb, y1, 'LineWidth', 3, 'Color', [0.78, 0.153, 0.071]); %Dark Red
l1 = legend(ax1, 'SMAP', 'SMOS', 'FontSize', 18);
l1.AutoUpdate = "off";
set(l1, 'Position', [0.845 0.91 0.08 0.045])
set(l1, "FontName", 'Times New Roman');
box on;
xlim([tb(1) tb(168)]);


%Adding Boxes:
fill([beg_2011 beg_2011 end_2011 end_2011], [min(ylim) max(ylim) max(ylim) min(ylim)], ...
    [0, 0.643, 0.988], 'FaceAlpha', 0.2); % Blue for Flood

fill([beg_2012 beg_2012 end_2012 end_2012], [min(ylim) max(ylim) max(ylim) min(ylim)], ...
    [0.361, 0.137, 0.075], 'FaceAlpha', 0.3); %Brown for drought 

fill([beg_2019 beg_2019 end_2019 end_2019], [min(ylim) max(ylim) max(ylim) min(ylim)], ...
    [0, 0.643, 0.988], 'FaceAlpha', 0.2); % Blue for Flood

fill([beg_2022 beg_2022 end_2022 end_2022], [min(ylim) max(ylim) max(ylim) min(ylim)], ...
    [0.361, 0.137, 0.075], 'FaceAlpha', 0.3); %Brown for drought

grid off;

set(ax1, 'Fontname', 'Times New Roman', 'FontSize', 16)

ax1.YTickLabel = {'35.4', ' ', '35.6', ' ', '35.8', ' ', '36', ' ', '36.2', ' ', '36.4'};
months = month(tb);
ax1.XTick = tb(months == 1 | months == 8);
ax1.XMinorTick = 'on';
ax1.XTickLabel = [];

yl1 = ylabel('Sea Surface Salinity (psu)');
set(yl1,'Fontname','Times New Roman','Fontsize', 18);
text(ax1, min(xlim + 0.04 ), min(ylim +0.01), '(a)', 'FontSize', 26, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');

%% Subplot 2 - Monthly River Discharge

nexttile;
ax2 = gca;

plot(DT_m, miss_m, 'LineWidth', 3, 'Color', [0.235, 0.541, 0.333]); % Dark Green
hold on
plot(DT_m, atch_m, 'LineWidth', 3, 'Color', [0.969, 0.106, 0.741]); % Pink
l2 = legend(ax2, 'Mississippi', 'Atchafalaya', 'FontSize', 18);
l2.AutoUpdate = "off";
set(l2, 'Position', [0.845 0.67 0.105 0.045])
set(l2, 'FontName', 'Times New Roman');
box on;
xlim([tb(1) tb(168)]);

grid off;

%Adding Boxes:
fill([beg_2011 beg_2011 end_2011 end_2011], [min(ylim) max(ylim) max(ylim) min(ylim)], ...
    [0, 0.643, 0.988], 'FaceAlpha', 0.2); % Blue for Flood

fill([beg_2012 beg_2012 end_2012 end_2012], [min(ylim) max(ylim) max(ylim) min(ylim)], ...
    [0.361, 0.137, 0.075], 'FaceAlpha', 0.3); %Brown for drought 

fill([beg_2019 beg_2019 end_2019 end_2019], [min(ylim) max(ylim) max(ylim) min(ylim)], ...
    [0, 0.643, 0.988], 'FaceAlpha', 0.2); % Blue for Flood

fill([beg_2022 beg_2022 end_2022 end_2022], [min(ylim) max(ylim) max(ylim) min(ylim)], ...
    [0.361, 0.137, 0.075], 'FaceAlpha', 0.3); %Brown for drought

set(ax2, 'Fontname', 'Times New Roman', 'FontSize', 16)
%ylim([0 5000])
ax2.YTickLabel = {'', '1.0','', '2.0','', '3.0','', '4.0', ''};
months = month(tb);
ax2.XTick = tb(months == 1 | months == 8);
ax2.XMinorTick = 'on';
ax2.XTickLabel = [];

yl2 = ylabel('River Discharge (x10^{4} m^{3}/s)');
set(yl2,'Fontname','Times New Roman','Fontsize', 18);
text(ax2, min(xlim + 0.04 ), min(ylim +0.04), '(b)', 'FontSize', 26, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');

%% Calculate SSS anomaly 

% Calculate the mean seasonal signal and Anomaly 
% Month date SMOS = x1 (169x1 datetime)
% monthly SMOS = y1 (169x1 double)
% Month date SMAP = x2 (90x1 datetime)
% monthly SMAP = y2 (90x1 double)
% Unique months = mu (1x12 double)

mu = unique(month(tb)); % unique months

% arrays for seasonal signals
smos_seas = nan(length(mu), 2);
smap_seas = nan(length(mu), 2);

% SMOS seasonal signals
for m = mu'
    % Find indices for current month m
    ui = find(month(tb) == m);
    % Calculate mean and std deviation
    smos_seas(m, 1) = mean(y1(ui), 'omitnan');
    smos_seas(m, 2) = std(y1(ui), 'omitnan');
end

% SMAP seasonal signals
for m = mu'
    % Find indices for current month m
    ui = find(month(x2) == m);
    % Calculate mean and std deviation
    smap_seas(m, 1) = mean(y2(ui), 'omitnan');
    smap_seas(m, 2) = std(y2(ui), 'omitnan');
end

% Calculate anomalies for SMOS
smos_sa = y1 - smos_seas(month(tb), 1);

% Calculate anomalies for SMAP
smap_sa = y2 - smap_seas(month(x2), 1);

%% Subplot 3 - Plotting SSS anomalies

nexttile;
ax3 = gca;

b1 = bar(x2, smap_sa, 'grouped'); 
b1.FaceColor = [0.114, 0.498, 0.91]; %Sky Blue
hold on
b2 = bar(tb, smos_sa, 'grouped');
b2.FaceColor = [0.78, 0.153, 0.071]; %Dark Red
hold on;
% plot +/- std deviations
% SMOS
plot(DT_m,zeros(length(DT_m),1)+mean(smos_seas(:,2),'all','omitnan'),'k:','linew',2);
plot(DT_m,zeros(length(DT_m),1)-mean(smos_seas(:,2),'all','omitnan'),'k:','linew',2);
% % SMAP
% plot(DT_m,zeros(length(DT_m),1)+mean(smap_seas(:,2),'all','omitnan'),'b:','linew',2);
% plot(DT_m,zeros(length(DT_m),1)-mean(smap_seas(:,2),'all','omitnan'),'b:','linew',2);

l3 = legend(ax3, 'SMAP', 'SMOS', 'FontSize', 18);
l3.AutoUpdate = 'off';
set(l3, 'Position', [0.845 0.44 0.08 0.045])
box on;
xlim([tb(1) tb(168)]);
ylim([-0.3 0.31]);

grid off;

%Adding Boxes:
fill([beg_2011 beg_2011 end_2011 end_2011], [min(ylim) max(ylim) max(ylim) min(ylim)], ...
    [0, 0.643, 0.988], 'FaceAlpha', 0.2); % Blue for Flood

fill([beg_2012 beg_2012 end_2012 end_2012], [min(ylim) max(ylim) max(ylim) min(ylim)], ...
    [0.361, 0.137, 0.075], 'FaceAlpha', 0.3); %Brown for drought 

fill([beg_2019 beg_2019 end_2019 end_2019], [min(ylim) max(ylim) max(ylim) min(ylim)], ...
    [0, 0.643, 0.988], 'FaceAlpha', 0.2); % Blue for Flood

fill([beg_2022 beg_2022 end_2022 end_2022], [min(ylim) max(ylim) max(ylim) min(ylim)], ...
    [0.361, 0.137, 0.075], 'FaceAlpha', 0.3); %Brown for drought

set(ax3, 'Fontname', 'Times New Roman', 'FontSize', 16)

%ax2.YTickLabel = {'35.4', ' ', '35.6', ' ', '35.8', ' ', '36', ' ', '36.2', ' ', '36.4'};
months = month(tb);
ax3.XTick = tb(months == 1 | months == 8);
ax3.XMinorTick = 'on';
ax3.XTickLabel = [];

yl3 = ylabel('SSS Anomaly (psu)');
set(yl3,'Fontname','Times New Roman','Fontsize', 18);
text(ax3, min(xlim + 0.04 ), min(ylim +0.01), '(c)', 'FontSize', 26, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');

%% Subplot 4 - MS and Atcha anoamlies
% Copying from "riverdischarge_ts_RB.m"

nexttile;
ax4 = gca;

b3 = bar(DT_m,movmean(miss_sa,3),1,'grouped'); 
b3.FaceColor = [0.235, 0.541, 0.333]; % Dark Green
% atch
hold on; 
b4 = bar(DT_m,movmean(atch_sa,3),0.5,'grouped'); 
b4.FaceColor = [0.969, 0.106, 0.741]; %Pink
% plot 0 line
plot(DT_m,zeros(length(DT_m),1),'k-','linew',2);
hold on;
% plot +/- std deviations
% miss
plot(DT_m,zeros(length(DT_m),1)+mean(miss_seas(:,2),'all','omitnan'),'k:','linew',2);
plot(DT_m,zeros(length(DT_m),1)-mean(miss_seas(:,2),'all','omitnan'),'k:','linew',2);
% atch
plot(DT_m,zeros(length(DT_m),1)+mean(atch_seas(:,2),'all','omitnan'),'m:','linew',2);
plot(DT_m,zeros(length(DT_m),1)-mean(atch_seas(:,2),'all','omitnan'),'m:','linew',2);

l4 = legend(ax4, 'Mississippi', 'Atchafalaya', 'FontSize', 18);
l4.AutoUpdate = 'off';
set(l4, 'Position', [0.845 0.2 0.105 0.045])
box on;
xlim([tb(1) tb(168)]);
%ylim([-1.2 1.2]);
grid off;

%Adding Boxes:
fill([beg_2011 beg_2011 end_2011 end_2011], [min(ylim) max(ylim) max(ylim) min(ylim)], ...
    [0, 0.643, 0.988], 'FaceAlpha', 0.2); % Blue for Flood

fill([beg_2012 beg_2012 end_2012 end_2012], [min(ylim) max(ylim) max(ylim) min(ylim)], ...
    [0.361, 0.137, 0.075], 'FaceAlpha', 0.3); %Brown for drought 

fill([beg_2019 beg_2019 end_2019 end_2019], [min(ylim) max(ylim) max(ylim) min(ylim)], ...
    [0, 0.643, 0.988], 'FaceAlpha', 0.2); % Blue for Flood

fill([beg_2022 beg_2022 end_2022 end_2022], [min(ylim) max(ylim) max(ylim) min(ylim)], ...
    [0.361, 0.137, 0.075], 'FaceAlpha', 0.3); %Brown for drought

set(ax4, 'Fontname', 'Times New Roman', 'FontSize', 16)

%ax2.YTickLabel = {'35.4', ' ', '35.6', ' ', '35.8', ' ', '36', ' ', '36.2', ' ', '36.4'};
months = month(tb);
ax4.XTick = tb(months == 1 | months == 8);
ax4.XMinorTick = 'on';

%Only Aug ticks 
ax4.XTickLabel(2) = {'\fontsize{16} AUG'};
ax4.XTickLabel(4) = {'\fontsize{16} AUG'};
ax4.XTickLabel(6) = {'\fontsize{16} AUG'};
ax4.XTickLabel(8) = {'\fontsize{16} AUG'};
ax4.XTickLabel(10) = {'\fontsize{16} AUG'};
ax4.XTickLabel(12) = {'\fontsize{16} AUG'};
ax4.XTickLabel(14) = {'\fontsize{16} AUG'};
ax4.XTickLabel(16) = {'\fontsize{16} AUG'};
ax4.XTickLabel(18) = {'\fontsize{16} AUG'};
ax4.XTickLabel(20) = {'\fontsize{16} AUG'};
ax4.XTickLabel(22) = {'\fontsize{16} AUG'};
ax4.XTickLabel(24) = {'\fontsize{16} AUG'};
ax4.XTickLabel(26) = {'\fontsize{16} AUG'};
ax4.XTickLabel(28) = {'\fontsize{16} AUG'};
ax4.XTickLabelRotation = 45;

%Only year ticks - making longer and bolder
ax4.XTickLabel(1) = {'\fontsize{18}\bf 2010'};
ax4.XTickLabel(3) = {'\fontsize{18}\bf 2011'};
ax4.XTickLabel(5) = {'\fontsize{18}\bf 2012'};
ax4.XTickLabel(7) = {'\fontsize{18}\bf 2013'};
ax4.XTickLabel(9) = {'\fontsize{18}\bf 2014'};
ax4.XTickLabel(11) = {'\fontsize{18}\bf 2015'};
ax4.XTickLabel(13) = {'\fontsize{18}\bf 2016'};
ax4.XTickLabel(15) = {'\fontsize{18}\bf 2017'};
ax4.XTickLabel(17) = {'\fontsize{18}\bf 2018'};
ax4.XTickLabel(19) = {'\fontsize{18}\bf 2019'};
ax4.XTickLabel(21) = {'\fontsize{18}\bf 2020'};
ax4.XTickLabel(23) = {'\fontsize{18}\bf 2021'};
ax4.XTickLabel(25) = {'\fontsize{18}\bf 2022'};
ax4.XTickLabel(27) = {'\fontsize{18}\bf 2023'};
ax4.XTickLabel(29) = {'\fontsize{18}\bf 2024'};

yl4 = ylabel('Discharge Anomaly (m^{3}/s)');
set(yl4,'Fontname','Times New Roman','Fontsize', 18);
text(ax4, min(xlim + 0.04 ), min(ylim +0.01), '(d)', 'FontSize', 26, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');


%% Final plot specs and save

%title('Timeseries of SMOS L3 and SMAP SSS');
figname = ([save_path 'Fig1_SSS_ts_MS&Actha_Discharge_with_anomalies.tiff']);
set(gcf, 'InvertHardcopy', 'off')
exportgraphics(gcf, figname, 'BackGroundColor', 'none');


