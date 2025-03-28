% calculating monthly means of river discharge for Mississippi and
% Atchafalaya; as well as seasonal mean and interannual anomalies

clear; clc; close all;
cd /Users/rickybrokaw/Documents/5_Mentor/Pamela_USC/;
addpath /Users/rickybrokaw/Documents/MATLAB/;

% load in river discharge tables
miss_T = readtable('Mississippi_07374000.xlsx');
atch_T = readtable('atchafalaya_2009_2024.xlsx');

% get dates for both
miss_dt = table2array(miss_T(:,3));
atch_dt = table2array(atch_T(:,3));
% we want 2010-2023
DT = datetime(2010,1,1):datetime(2023,12,31); DT = DT';
miss_i = find(miss_dt >= DT(1) & miss_dt <= DT(end));
atch_i = find(atch_dt >= DT(1) & atch_dt <= DT(end));
% load in discharge (last column = m^3/s) and trim by indices above
miss_ds = table2array(miss_T(miss_i,end));
atch_ds = table2array(atch_T(atch_i,end));
clearvars -except DT miss_ds atch_ds;

% test plot
figure; plot(DT,movmean(atch_ds,30));
hold on; plot(DT,movmean(miss_ds,30)); 
legend('atch','miss'); % looks ok, we're missing atch in 2021? 
% they are 0s, make them nans
atch_ds(atch_ds == 0) = nan;
miss_ds(miss_ds == 0) = nan;
[r,p] = corrcoef(atch_ds,miss_ds,'rows','complete'); disp(r(2)^2);
% they are highly correlated (R^2 = 0.99)
% so we can fill missing atch data using linear regression with miss

%% linear regression
x = miss_ds; y = atch_ds;
mdl = fitlm(x,y,'linear');
yp = predict(mdl,x(isnan(y)));

% test plot again
figure; plot(DT,movmean(atch_ds,30));
hold on; plot(DT,movmean(miss_ds,30)); 
scatter(DT(isnan(y)),yp);
legend('atch','miss','filled atch'); % looks good

% filling!
atch_ds(isnan(y)) = yp;

%% taking monthly means
mu = unique(month(DT)); yu = unique(year(DT));
atch_m = nan(length(mu)*length(yu),1); % preallocate monthly output
miss_m = nan*atch_m;

count = 1;
% loop through each unique year
for y = yu(1):yu(end)
    % and through each unique month
    for m = mu(1):mu(end)
        % find where we have that month/year combo
        ui = find(month(DT) == m & year(DT) == y);
        % take means and assign to output
        atch_m(count) = mean(atch_ds(ui),'all','omitnan');
        miss_m(count) = mean(miss_ds(ui),'all','omitnan');
        count = count + 1;
    end
end

%% plot that
DT_m = DT(1):calmonths:DT(end);
figure; plot(DT_m,atch_m);
hold on; plot(DT_m,miss_m); 
legend('atch','miss');

%% now we have time series to calculate seasonal means + anomalies from
% calculate mean seasonal signal (mean + std dev of monthly means)
% these will be 12 long
atch_seas = nan(length(mu),2);
miss_seas = nan*atch_seas;

count = 1;
% loop through each unique month
for m = mu(1):mu(end)
    % find all months 
    ui = find(month(DT_m) == m);
    % take mean and std dev and assign
    atch_seas(count,1) = mean(atch_m(ui),'all','omitnan');
    atch_seas(count,2) = std(atch_m(ui),[],'all','omitnan');    
    miss_seas(count,1) = mean(miss_m(ui),'all','omitnan');
    miss_seas(count,2) = std(miss_m(ui),[],'all','omitnan');

    count = count + 1;
end

%% test plot
figure('position',[1 1 1000 600]); 
% atch
plot(mu,atch_seas(:,1),'b-','linew',2);
hold on; plot(mu,atch_seas(:,1)+atch_seas(:,2),'b:','linew',1.5);
plot(mu,atch_seas(:,1)-atch_seas(:,2),'b:','linew',1.5);
% miss
plot(mu,miss_seas(:,1),'r-','linew',2);
plot(mu,miss_seas(:,1)+miss_seas(:,2),'r:','linew',1.5);
plot(mu,miss_seas(:,1)-miss_seas(:,2),'r:','linew',1.5);
legend('atch seas','','','miss seas','','');
ylabel('river discharge seasonal climatology (m^3/s)');
set(gca,'fontsize',20,'linew',1.5,'layer','top');
xlim([1 12]); xticks(1:12); 
xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});

% they show same seasonal patterns: max discharge in April, min in October
% with mississippi having overall greater magnitude! looks good

%% calculate seasonal anomalies (subtract mean seasonal signal)
% ts_sa = ts_m - ts_seas
atch_sa = atch_m - repmat(atch_seas(:,1),length(yu),1);
miss_sa = miss_m - repmat(miss_seas(:,1),length(yu),1);

% plot
figure('position',[1 1 1400 500]); 
% miss
bar(DT_m,movmean(miss_sa,3),1,'grouped','r');
% atch
hold on; bar(DT_m,movmean(atch_sa,3),0.5,'grouped','b');
% plot 0 line
plot(DT_m,zeros(length(DT_m),1),'k-','linew',2);
% plot +/- std deviations
% miss
plot(DT_m,zeros(length(DT_m),1)+mean(miss_seas(:,2),'all','omitnan'),'r:','linew',2);
plot(DT_m,zeros(length(DT_m),1)-mean(miss_seas(:,2),'all','omitnan'),'r:','linew',2);
% atch
plot(DT_m,zeros(length(DT_m),1)+mean(atch_seas(:,2),'all','omitnan'),'b:','linew',2);
plot(DT_m,zeros(length(DT_m),1)-mean(atch_seas(:,2),'all','omitnan'),'b:','linew',2);
% add black triangles to drought years (2012; 22; 23)
droughti = find(year(DT_m) == 2012 | year(DT_m) == 2022 | year(DT_m) == 2023);
scatter(DT_m(droughti),repmat(-12500,[length(droughti) 1]),50,'k^','filled')
% add black circles to flood years (2011; 19; 20)
floodi = find(year(DT_m) == 2011 | year(DT_m) == 2019 | year(DT_m) == 2020);
scatter(DT_m(floodi),repmat(12500,[length(floodi) 1]),100,'ko','linew',2);

% labels, legend, and formatting
legend('miss sa','atch sa','','miss std','','atch std','','drought','flood');
ylabel('river discharge seasonal anomaly (m^3/s)');
set(gca,'fontsize',20,'linew',1.5,'layer','top');
xticks(DT_m(4:4:end));
xticklabels({'Apr','Aug','2011','Apr','Aug','2012','Apr','Aug','2013',...
    'Apr','Aug','2014','Apr','Aug','2015','Apr','Aug','2016',...
    'Apr','Aug','2017','Apr','Aug','2018','Apr','Aug','2019',...
    'Apr','Aug','2020','Apr','Aug','2021','Apr','Aug','2022', ...
    'Apr','Aug','2023','Apr','Aug'});

%% save variables to a .mat file as output (to share with Pamela)
% and to be plotted in Figure 1 alongside box-averaged SSS
outdir = '/Users/rickybrokaw/Documents/5_Mentor/Pamela_USC/';
fname = 'discharge_ts.mat';
% add a variable to explain namings
openme = {'_m are monthly averages','_seas are seasonal signals (1 year long of months)',...
    '_sa are seasonal anomalies (monthly averages - seasonal signal)','_ds are daily discharge',...
    'DT are datetimes for daily and DT_m are datetimes for monthly'};

% save it
save([outdir,fname],'openme','DT','DT_m','atch_ds','atch_m','atch_sa','atch_seas','miss_ds','miss_m','miss_sa','miss_seas');








