%% Figure 5 for the paper with Ricky. 
% Plots showing where the box averages were calculated from
% and 2 time series - Zonal and Meridional Flux

close all;
clear;
clc;

addpath(genpath('/Users/pameladoran/Documents/Toolbox-19May2024')); % Plotting Toolbox
load '/Volumes/PamelaResearch/Ricky_Project/Fig_4/SMOS_mean_Table_OSCAR.mat'; % SMOS Monthly variables for timeseries
load ('/Volumes/PamelaResearch/Ricky_Project/Fig_2/monthly_avg_sss_SMOS.mat'); % Monthly maps for reference plot
load ('/Volumes/PamelaResearch/Ricky_Project/Fig_3/GoM_SMOS_Flux_UV_2010to2023_OSCAR.mat'); %monthly flux values 2010 to 2023
mer_flux_SMOS = mer_flux_SMOS(1:end-2,:,:);
zon_flux_SMOS = zon_flux_SMOS(1:end-2,:,:);

%load('/Volumes/PamelaResearch/Ricky_Project/Fig_2/monthly_avg_uv.mat') %Averaged surface velocity 
% OSCAR UV monthly averages
load('/Volumes/PamelaResearch/Ricky_Project/Fig_2/OSCAR_monthly_uv.mat') %Averaged surface velocity for GoM
lon3_int = lon3_int(:,:) - 360;
lon3_int = lon3_int(1:end-2,:,:);
lat3_int = lat3_int(1:end-2, :,:);
u_map_mean = u_map_mean(1:end-2,:,:);
v_map_mean = v_map_mean(1:end-2,:,:);
savepath = '/Volumes/PamelaResearch/Ricky_Project/Fig_4/';

%% Creating the figure and subplot

clf
figure(1)
t = tiledlayout(3,3);  % Look up how to span tiles
t.TileSpacing = 'tight';
t.Padding = 'tight';
set(gcf, 'Position', [1 195 1169 1142])


%% Month Calcuation for bottom Row ticks

t1b=datetime(2009,12,1,0,0,0);
tb=t1b+calmonths(1:153); tb=tb';
months = month(tb);

%% Colors

% Shleves:
tq = [0.059, 0.431, 0.42];

% Straights
purp = [0.404, 0.247, 0.639];

%% Zonal Flux Timeseries - U direction box avgerages

time = uniqueYearMonths_UV; %x

mafla = SMOS_table.mafla_mean_SMOS; % y1
mafla = smoothdata(mafla, 'gaussian');
FL_str = SMOS_table.FSt_mean_SMOS; % y2
FL_str = smoothdata(FL_str, 'gaussian');

nexttile([1 3]);
ax1 = gca;

yyaxis('left')
h1 = plot(time, mafla, 'LineWidth', 3, 'Color', tq); % Dark Torquiose
set(gca, 'ycolor', tq)
%yline(0, 'Color', tq, 'LineStyle', '--')
ylim([-300 800]); 
yticks([-400, -200, 0, 200, 400, 600, 800]);
set(ax1, 'Fontsize', 12, 'LineWidth', 3)
ylabel('Zonal Flux (m^{2}/s)', 'FontSize', 18, 'Color', 'k', 'FontName', 'Times New Roman'); 
hold on;
yyaxis('right')
h2 = plot(time, FL_str, 'LineWidth', 3, 'Color', purp); %Purple
set(gca, 'ycolor', purp);
%yline(0, 'Color', purp, 'LineStyle', '--')
ylim([-150 400]); yticks([0,100,200,300,400]);
yline(ax1, 0, '--k')
hold off;
l1 = legend(ax1, 'MAFLA', 'FL Straits', '' , fontsize = 16, fontname = 'Times New Roman');
set(l1, 'Position', [0.82 0.92 0.09 0.06])
ax1.XTick = tb(months == 1 | months == 8);
ax1.XMinorTick = 'on';
ax1.XTickLabel = [];
grid on;
%set(l1, 'Position', [0.83 0.872 0.06 0.05])
box on;
text(ax1, min(xlim + 0.04 ), min(ylim +0.01), '(a)', 'FontSize', 26, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');


%% Meridional Flux TS - V direction Box Averages

nexttile([1 3]);

WFS = SMOS_table.WFS_mean_SMOS; % y1
WFS = smoothdata(WFS, 'gaussian');
YtC = SMOS_table.YtC_mean_SMOS; % y2
YtC = smoothdata(YtC, 'gaussian');

ax2 = gca;
h3 = plot(time, WFS, 'LineWidth', 3, 'Color', tq); % Dark Torquiose
set(h3, 'Color', tq)
ylim([-350 350]); 
yticks([-300, -200, -100,0, 100, 200, 300 ]);
set(ax2, 'FontSize', 12, 'LineWidth', 3)
ylabel('Meridional Flux (m^{2}/s)', 'FontSize', 18, 'FontName', 'Times New Roman');
hold on;
h4 = plot(time, YtC, 'LineWidth', 3, 'Color', purp); %Purple
set(h4, 'Color', purp)
yline(ax2, 0, '--k')
%ylim([-400 400])
l2 = legend(ax2, 'WFLS', 'Yucatan', '', fontsize = 16, fontname = 'Times New Roman');
set(l2, 'Position', [0.82 0.42 0.09 0.06]);
grid on;
box on;

ax2.XTick = tb(months == 1 | months == 8);
ax2.XMinorTick = 'on';
ax2.FontName = 'Times New Roman';

%Only Aug ticks 
ax2.XTickLabel(2) = {'\fontsize{16} AUG'};
ax2.XTickLabel(4) = {'\fontsize{16} AUG'};
ax2.XTickLabel(6) = {'\fontsize{16} AUG'};
ax2.XTickLabel(8) = {'\fontsize{16} AUG'};
ax2.XTickLabel(10) = {'\fontsize{16} AUG'};
ax2.XTickLabel(12) = {'\fontsize{16} AUG'};
ax2.XTickLabel(14) = {'\fontsize{16} AUG'};
ax2.XTickLabel(16) = {'\fontsize{16} AUG'};
ax2.XTickLabel(18) = {'\fontsize{16} AUG'};
ax2.XTickLabel(20) = {'\fontsize{16} AUG'};
ax2.XTickLabel(22) = {'\fontsize{16} AUG'};
ax2.XTickLabel(24) = {'\fontsize{16} AUG'};
ax2.XTickLabel(26) = {'\fontsize{16} AUG'};
ax2.XTickLabel(28) = {'\fontsize{16} AUG'};
ax2.XTickLabelRotation = 45;

%Only year ticks - making longer and bolder
ax2.XTickLabel(1) = {'\fontsize{18}\bf 2010'};
ax2.XTickLabel(3) = {'\fontsize{18}\bf 2011'};
ax2.XTickLabel(5) = {'\fontsize{18}\bf 2012'};
ax2.XTickLabel(7) = {'\fontsize{18}\bf 2013'};
ax2.XTickLabel(9) = {'\fontsize{18}\bf 2014'};
ax2.XTickLabel(11) = {'\fontsize{18}\bf 2015'};
ax2.XTickLabel(13) = {'\fontsize{18}\bf 2016'};
ax2.XTickLabel(15) = {'\fontsize{18}\bf 2017'};
ax2.XTickLabel(17) = {'\fontsize{18}\bf 2018'};
ax2.XTickLabel(19) = {'\fontsize{18}\bf 2019'};
ax2.XTickLabel(21) = {'\fontsize{18}\bf 2020'};
ax2.XTickLabel(23) = {'\fontsize{18}\bf 2021'};
ax2.XTickLabel(25) = {'\fontsize{18}\bf 2022'};
ax2.XTickLabel(27) = {'\fontsize{18}\bf 2023'};
ax2.XTickLabel(29) = {'\fontsize{18}\bf 2024'};

text(ax2, min(xlim + 0.04 ), min(ylim +0.01), '(b)', 'FontSize', 26, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');

%% SMOS SSS - 2022 - Drought

% Assign the subplot
nexttile(7);
ax4 = gca;

% Plotting the GoM
m_proj('mercator','longitude',[-98 -78],'latitude',[17 32]) %initialize map
m_coast('line');
hold on;

%Plot SSS as a colormap
m_pcolor(lon1_int, lat1_int, sss_map_mean_SMOS(:,:,152));
shading interp;
colormap(jet(100));
clim([33 37.5]);
hold on;

%adding velocity streamlines over top 
m_streamline(lon3_int, lat3_int, u_map_mean(:,:,152), v_map_mean(:,:,152), 6)

%Making the plot look better
m_gshhs_i('patch',[0.8 0.8 0.8]);
m_grid('box','fancy','box','on','linewidth',3, 'fontsize', 18)

hold on;
% Atcha - Colors from other timeseries
m_plot(-91.2, 29.3, 'o', 'MarkerSize', 20, 'MarkerFaceColor', [0.969, 0.106, 0.741]);
hold on;
% Miss
m_plot(-89.2, 29.1, 'o', 'MarkerSize', 20, 'MarkerFaceColor', [0.235, 0.541, 0.333]);

title(ax4, 'August 2022', 'Units', 'normalized', 'Position', [0.051, 0.88, 0], 'HorizontalAlignment', 'left');
set(ax4,'fontname','times new roman','fontsize',24);
text(ax4, min(xlim + 0.004 ), min(ylim +0.003), '(c)', 'FontSize', 24, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');
cb1 = colorbar(ax4, "southoutside");
%set(cb1, 'Position', [0.055 0.03 0.27 0.008]);
cb1.Label.String = ('SSS (psu)');
cb1.FontSize = 18;

freezeColors;
freezeColors(cb1);

%% 2022 - U FW Flux

% Assign the subplot
nexttile(8);
ax8 = gca;

% Plotting the GoM
m_proj('mercator','longitude',[-98 -78],'latitude',[17 32]) %initialize map
m_coast('line');
hold on;

%Plot mer_flux as a colormap -use lon3 and lat3 - same grid
m_pcolor(lon3_int, lat3_int, zon_flux_SMOS(:,:,152)); 
shading interp;
colormap(redblue(24)); 
clim([-1000 1000]);
hold on;

% MAFLA Box - same color as timeseries
m_plot([-89 -86],[28.5 28.5],'linew',2, 'Color', tq);
hold on
m_plot([-89 -86],[30 30],'linew',2, 'Color', tq);
hold on
m_plot([-89 -89],[28.5 30],'linew',2, 'Color', tq);
hold on
m_plot([-86 -86],[28.5 30],'linew',2, 'Color', tq);

% Florida Straits Box - Purple

m_plot([-83.5 -80],[23.5 23.5],'linew',2, 'Color', purp);
hold on
m_plot([-83.5 -80],[24.75 24.75],'linew',2, 'Color', purp);
hold on
m_plot([-80 -80],[23.5 24.75],'linew',2, 'Color', purp);
hold on
m_plot([-83.5 -83.5],[23.5 24.75],'linew',2, 'Color', purp);

%Making the plot look better
m_gshhs_i('patch',[0.8 0.8 0.8]);
m_grid('box','fancy','box','on','linewidth',3, 'fontsize', 18)
% handles8=findobj(ax8, 'tag', 'm_grid_yticklabel');
% delete(handles8());

title(ax8, 'U FW Flux', 'Units', 'normalized', 'Position', [0.051, 0.88, 0], 'HorizontalAlignment', 'left');
set(ax8,'fontname','times new roman','fontsize',24);
text(ax8, min(xlim + 0.004 ), min(ylim +0.003), '(d)', 'FontSize', 24, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');
freezeColors;

%% 2022 - V FW Flux

% Assign the subplot
nexttile(9);
ax12 = gca;

% Plotting the GoM
m_proj('mercator','longitude',[-98 -78],'latitude',[17 32]) %initialize map
m_coast('line');
hold on;

%Plot mer_flux as a colormap -use lon3 and lat3 - same grid
m_pcolor(lon3_int, lat3_int, mer_flux_SMOS(:,:,152)); 
shading interp;
colormap(redblue(24)); 
clim([-1000 1000]);
hold on;

% West Florida Shelf - turquoise
m_plot([-86 -83],[23.5 23.5],'linew',2, 'Color', tq);
hold on
m_plot([-86 -83],[29 29],'linew',2, 'Color', tq);
hold on
m_plot([-86 -86],[23.5 29],'linew',2, 'Color', tq);
hold on
m_plot([-83 -83],[23.5 29],'linew',2, 'Color', tq);

% Yuctan Channel - Purple
m_plot([-86.5 -85],[21 21],'linew', 2 ,'Color', purp);
hold on
m_plot([-86.5 -85],[23 23],'linew', 2 ,'Color', purp);
hold on
m_plot([-86.5 -86.5],[21 23],'linew', 2 ,'Color', purp);
hold on
m_plot([-85 -85],[21 23],'linew', 2, 'Color', purp);

%Making the plot look better
m_gshhs_i('patch',[0.8 0.8 0.8]);
m_grid('box','fancy','box','on','linewidth',3, 'fontsize', 18)
% handles12=findobj(ax12, 'tag', 'm_grid_yticklabel');
% delete(handles12());

title(ax12, 'V FW Flux', 'Units', 'normalized', 'Position', [0.051, 0.88, 0], 'HorizontalAlignment', 'left');
set(ax12,'fontname','times new roman','fontsize',24);
text(ax12, min(xlim + 0.004 ), min(ylim +0.003), '(e)', 'FontSize', 24, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');
cb2=colorbar('SouthOutside'); 
set(cb2, 'Position', [0.365 0.058 0.62 0.01]);
cb2.Label.String = ('Surface Advective Freshwater Flux (m^{2}/s)');
cb2.FontSize = 18;
freezeColors;
freezeColors(cb2);


%% Final plot specs and save

figname = ([savepath 'Fig4_SMOS_Box_avg_flux_OSCAR.tiff']);
set(gcf, 'InvertHardcopy', 'off')
exportgraphics(gcf, figname, 'BackGroundColor', 'none'); 

disp('Finished');


