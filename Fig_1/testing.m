clear;
clc;
close all;


values_2018 = importdata('/Volumes/PamelaResearch/Matlab_files/LCFE/most_common_values_2018.mat');
values_2019 = importdata('/Volumes/PamelaResearch/Matlab_files/LCFE/most_common_values_2019.mat');
values_2020 = importdata('/Volumes/PamelaResearch/Matlab_files/LCFE/most_common_values_2020.mat');
values_2021 = importdata('/Volumes/PamelaResearch/Matlab_files/LCFE/most_common_values_2021.mat');
values_2022 = importdata('/Volumes/PamelaResearch/Matlab_files/LCFE/most_common_values_2022.mat');
values_2023 = importdata('/Volumes/PamelaResearch/Matlab_files/LCFE/most_common_values_2023.mat');
values_2024 = importdata('/Volumes/PamelaResearch/Matlab_files/LCFE/most_common_values_2024.mat');
values_2024 = values_2024(1:end-1);

dt18 = datetime(2018,1,1):datetime(2018,12,31);
dt19 = datetime(2019,1,1):datetime(2019,12,31);
dt20 = datetime(2020,1,1):datetime(2020,12,31);
dt21 = datetime(2021,1,1):datetime(2021,12,31);
dt22 = datetime(2022,1,1):datetime(2022,12,31);
dt23 = datetime(2023,1,1):datetime(2023,12,31);
dt24 = datetime(2018,1,1):datetime(2018,12,31);

clf
figure(1)
t = tiledlayout(7, 3);
t.TileSpacing = 'none';
t.Padding = 'loose';
set(gcf, 'Position', [11 113 2012 1193])


%% 2018
nexttile([1 3]);
ax1 = gca; 

plot(dt18, values_2018)
yyaxis right
ylabel('2018')


%% 2019
nexttile([1 3]);
ax2 = gca;

plot(dt19, values_2019);
yyaxis right
ylabel('2019')

%% 2020 
nexttile([1 3]);
ax3 = gca;

plot(dt20, values_2020)
yyaxis right
ylabel('2020')

%% 2021 
nexttile([1 3]);
ax4 = gca;

plot(dt21, values_2021)
yyaxis right
ylabel('2021')

%% 2022 
nexttile([1 3])
ax5 = gca;

plot(dt22, values_2022)
yyaxis right
ylabel('2022')

%% 2023
nexttile([1 3])
ax6 = gca;

plot(dt23, values_2023)
yyaxis right
ylabel('2023')

%% 2024
nexttile([1 3])
ax7 = gca;

plot(dt24, values_2024)
yyaxis right
ylabel('2024')
