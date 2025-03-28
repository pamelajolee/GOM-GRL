%% Creating a 2x2 subplot Which shows Flood vs Drought years for SMOS
% Flood years = 2011 and 2019
% Drought years = 2012 and 2022

close all;
clear;
clc;
addpath(genpath('/Users/pameladoran/Documents/Toolbox-19May2024'));
savepath = '/Volumes/PamelaResearch/Ricky_Project/Fig_2/';
load ('vik.mat'); % Scientific Colormap

load ('/Volumes/PamelaResearch/Ricky_Project/Fig_2/monthly_avg_sss_SMOS.mat'); %monthly SMOS SSS 2010 to 2023
% SMOS HAS DATA FOR EVERY MONTH SO AUGUST WILL START AT INDEX 8 AND
% INCREASE EVERY 12
%load ('/Volumes/PamelaResearch/Ricky_Project/Fig_2/monthly_avg_sss_SMAP_70km.mat'); %monthly SMAP SSS 2015 to 2023
% SMAP ONLY HAS APRIL TO DEC EACH YEAR, SO AUGUST WILL BE STARTING AT THE
% 5TH INDEX AND OCCURS EVERY 9 INDECIES
load('/Volumes/PamelaResearch/Ricky_Project/Fig_2/OSCAR_monthly_uv.mat') %Averaged surface velocity 

%% Making SMOS and OSCAR on the same grid
lon3_int = lon3_int(:,:) - 360;

%% Creating the Subplot
clf
figure(1)
t = tiledlayout('flow');
t.TileSpacing = 'none';
t.Padding = 'loose';
set(gcf, 'Position', [111 174 1155 976])

%% 2011 - Flood

% Assign the subplot
nexttile;
ax1 = gca;

% Plotting the GoM
m_proj('mercator','longitude',[-98 -78],'latitude',[17 32]) %initialize map
m_coast('line');
hold on;

%Plot SSS as a colormap
m_pcolor(lon1_int, lat1_int, sss_map_mean_SMOS(:,:,20)); 
shading interp;
% grey=[0.7 0.7 0.7];
% fillmap(grey);
colormap(jet(100));
%cmocean haline;
clim([33 37.5]);
hold on;

line1 = m_streamline(lon3_int, lat3_int, u_map_mean(:,:,20), v_map_mean(:,:,20), 4);
for i = 1:length(line1)
    line1(i).LineWidth = 1.5;
    line1(i).Color = 'r';
end
    hold on;

%Making the plot look better
m_gshhs_i('patch',[0.8 0.8 0.8]);
m_grid('box','fancy','box','on','linewidth',3, 'fontsize', 16)
handles=findobj(ax1, 'tag', 'm_grid_xticklabel');
delete(handles());

% Atcha
m_plot(-91.2, 29.3, 'o', 'MarkerSize', 30, 'MarkerFaceColor', [0.969, 0.106, 0.741]);
hold on;
% Miss
m_plot(-89.2, 29.1, 'o', 'MarkerSize', 30, 'MarkerFaceColor', [0.235, 0.541, 0.333]);

title(ax1, 'August 2011', 'Units', 'normalized', 'Position', [0.051, 0.88, 0], 'HorizontalAlignment', 'left');
set(ax1,'fontname','times new roman','fontsize',26);
text(ax1, min(xlim + 0.004 ), min(ylim +0.003), '(a)', 'FontSize', 26, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');
ylabel('Flood');

%% 2019 - Flood

% Assign the subplot
nexttile;
ax2 = gca;

% Plotting the GoM
m_proj('mercator','longitude',[-98 -78],'latitude',[17 32]) %initialize map
m_coast('line');
hold on;

%Plot SSS as a colormap
m_pcolor(lon1_int, lat1_int, sss_map_mean_SMOS(:,:,116));
shading interp;
% grey=[0.7 0.7 0.7];
% fillmap(grey);
colormap(jet(100));
%cmocean haline;
clim([33 37.5]);
hold on;

line2 = m_streamline(lon3_int, lat3_int, u_map_mean(:,:,116), v_map_mean(:,:,116), 4);
for i = 1:length(line2)
    line2(i).LineWidth = 1.5;
    line2(i).Color = 'r';
end

%Making the plot look better
m_gshhs_i('patch',[0.8 0.8 0.8]);
m_grid('box','fancy','box','on','linewidth',3, 'fontsize', 16)
handles2=findobj(ax2, 'tag', 'm_grid_xticklabel');
delete(handles2());
handles3=findobj(ax2, 'tag', 'm_grid_yticklabel');
delete(handles3());

title(ax2, 'August 2019', 'Units', 'normalized', 'Position', [0.051, 0.88, 0], 'HorizontalAlignment', 'left');
set(ax2,'fontname','times new roman','fontsize', 26);
text(ax2, min(xlim + 0.004 ), min(ylim +0.003), '(b)', 'FontSize', 26, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');


%% 2012 - Drought

% Assign the subplot
nexttile;
ax3 = gca;

% Plotting the GoM
m_proj('mercator','longitude',[-98 -78],'latitude',[17 32]) %initialize map
m_coast('line');
hold on;

%Plot SSS as a colormap
m_pcolor(lon1_int, lat1_int, sss_map_mean_SMOS(:,:,32));
shading interp;
% grey=[0.7 0.7 0.7];
% fillmap(grey);
colormap(jet(100));
%cmocean haline;
clim([33 37.5]);
hold on;

line3 = m_streamline(lon3_int, lat3_int, u_map_mean(:,:,32), v_map_mean(:,:,32), 4);
for i = 1:length(line3)
    line3(i).LineWidth = 1.5;
    line3(i).Color = 'r';
end

%Making the plot look better
m_gshhs_i('patch',[0.8 0.8 0.8]);
m_grid('box','fancy','box','on','linewidth',3, 'fontsize', 16)

title(ax3, 'August 2012', 'Units', 'normalized', 'Position', [0.051, 0.88, 0], 'HorizontalAlignment', 'left');
set(ax3,'fontname','times new roman','fontsize',26);
text(ax3, min(xlim + 0.004 ), min(ylim +0.003), '(c)', 'FontSize', 26, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');
ylabel('Drought');

%% 2022 - Drought

% Assign the subplot
nexttile;
ax4 = gca;

% Plotting the GoM
m_proj('mercator','longitude',[-98 -78],'latitude',[17 32]) %initialize map
m_coast('line');
hold on;

%Plot SSS as a colormap
m_pcolor(lon1_int, lat1_int, sss_map_mean_SMOS(:,:,152));
shading interp;
% grey=[0.7 0.7 0.7];
% fillmap(grey);
colormap(jet(100));
%cmocean haline;
clim([33 37.5]);
hold on;

line4 = m_streamline(lon3_int, lat3_int, u_map_mean(:,:,152), v_map_mean(:,:,152), 4);
for i = 1:length(line4)
    line4(i).LineWidth = 1.5;
    line4(i).Color = 'r';
end
%Making the plot look better
m_gshhs_i('patch',[0.8 0.8 0.8]);
m_grid('box','fancy','box','on','linewidth',3, 'fontsize', 16)
handles4=findobj(ax4, 'tag', 'm_grid_yticklabel');
delete(handles4());

title(ax4, 'August 2022', 'Units', 'normalized', 'Position', [0.051, 0.88, 0], 'HorizontalAlignment', 'left');
set(ax4,'fontname','times new roman','fontsize',26);
text(ax4, min(xlim + 0.004 ), min(ylim +0.003), '(d)', 'FontSize', 26, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');

%% Overall plot specifications

% Common colorbar at the bottom
cb = colorbar('Position', [0.0922 0.07 0.82 0.008] , 'Orientation',  'horizontal'); 
cb.FontSize = 24;
cb.Label.String = ('SSS (psu)');

figname = fullfile(savepath, 'Lee_Figure1_OSCAR.tiff');  
set(gcf, 'InvertHardcopy', 'off')
exportgraphics(gcf, figname, 'BackGroundColor', 'none'); 

disp('Finished');
