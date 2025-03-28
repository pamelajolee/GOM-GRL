%% Creating a 4x3 subplot showing SMOS SSS in first column, U Flux in Second, and V Flux in third
% first 4 plots = SMOS
% second 4 = U Flux
% third 4 = V flux

close all;
clear;
clc;
addpath(genpath('/Users/pameladoran/Documents/Toolbox-19May2024'));
savepath = '/Volumes/PamelaResearch/Ricky_Project/Fig_3/';
load ('vik.mat'); % Scientific Colormap

load ('/Volumes/PamelaResearch/Ricky_Project/Fig_2/monthly_avg_sss_SMOS.mat'); %monthly SMOS SSS 2010 to 2023

load ('/Volumes/PamelaResearch/Ricky_Project/Fig_3/GoM_SMOS_Flux_UV_2010to2023_OSCAR.mat'); %monthly flux values 2010 to 2023

load('/Volumes/PamelaResearch/Ricky_Project/Fig_2/OSCAR_monthly_uv.mat') %Averaged surface velocity 
lon3_int = lon3_int(:,:) -360; % to make all show on same grid

%% Creating the Subplot
clf
figure(1)
t = tiledlayout(4,3);
t.TileSpacing = 'none';
t.Padding = 'compact';
set(gcf, 'Position', [111 87 1089 1250])

%% 2011 - SMOS Flood

% Assign the subplot
nexttile(1);
ax1 = gca;

% Plotting the GoM
m_proj('mercator','longitude',[-98 -78],'latitude',[17 32]) %initialize map
m_coast('line');
hold on;

%Plot SSS as a colormap
m_pcolor(lon1_int, lat1_int, sss_map_mean_SMOS(:,:,20)); 
shading interp;
colormap(jet(100));
clim([33 37.5]);
hold on;

%adding velocity streamlines over top 
line1 = m_streamline(lon3_int, lat3_int, u_map_mean(:,:,20), v_map_mean(:,:,20), 6);
for i = 1:length(line1)
    line1(i).LineWidth = 1.5;
    line1(i).Color = 'r';
end

%Making the plot look better
m_gshhs_i('patch',[0.8 0.8 0.8]);
m_grid('box','fancy','box','on','linewidth',3, 'fontsize', 18)
handles1=findobj(ax1, 'tag', 'm_grid_xticklabel');
delete(handles1());

title(ax1, 'August 2011', 'Units', 'normalized', 'Position', [0.051, 0.88, 0], 'HorizontalAlignment', 'left');
set(ax1,'fontname','times new roman','fontsize',24);
text(ax1, min(xlim + 0.004 ), min(ylim +0.003), '(a)', 'FontSize', 24, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');
%ylabel('Flood');
freezeColors;

%% 2019 - Flood

% Assign the subplot
nexttile(4);
ax2 = gca;

% Plotting the GoM
m_proj('mercator','longitude',[-98 -78],'latitude',[17 32]) %initialize map
m_coast('line');
hold on;

%Plot SSS as a colormap
m_pcolor(lon1_int, lat1_int, sss_map_mean_SMOS(:,:,116));
shading interp;
colormap(jet(100));
clim([33 37.5]);
hold on;

%adding velocity streamlines over top 
line2 = m_streamline(lon3_int, lat3_int, u_map_mean(:,:,116), v_map_mean(:,:,116), 6);
for i = 1:length(line2)
    line2(i).LineWidth = 1.5;
    line2(i).Color = 'r';
end

%Making the plot look better
m_gshhs_i('patch',[0.8 0.8 0.8]);
m_grid('box','fancy','box','on','linewidth',3, 'fontsize', 18)
handles2=findobj(ax2, 'tag', 'm_grid_xticklabel');
delete(handles2());

title(ax2, 'August 2019', 'Units', 'normalized', 'Position', [0.051, 0.88, 0], 'HorizontalAlignment', 'left');
set(ax2,'fontname','times new roman','fontsize',24);
text(ax2, min(xlim + 0.004 ), min(ylim +0.003), '(d)', 'FontSize', 24, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');
freezeColors;

%% 2012 - Drought

% Assign the subplot
nexttile(7);
ax3 = gca;

% Plotting the GoM
m_proj('mercator','longitude',[-98 -78],'latitude',[17 32]) %initialize map
m_coast('line');
hold on;

%Plot SSS as a colormap
m_pcolor(lon1_int, lat1_int, sss_map_mean_SMOS(:,:,32));
shading interp;
colormap(jet(100));
clim([33 37.5]);
hold on;

%adding velocity streamlines over top 
line3 = m_streamline(lon3_int, lat3_int, u_map_mean(:,:,32), v_map_mean(:,:,32), 6);
for i = 1:length(line3)
    line3(i).LineWidth = 1.5;
    line3(i).Color = 'r';
end

%Making the plot look better
m_gshhs_i('patch',[0.8 0.8 0.8]);
m_grid('box','fancy','box','on','linewidth',3, 'fontsize', 18)
handles3=findobj(ax3, 'tag', 'm_grid_xticklabel');
delete(handles3());

title(ax3, 'August 2012', 'Units', 'normalized', 'Position', [0.051, 0.88, 0], 'HorizontalAlignment', 'left');
set(ax3,'fontname','times new roman','fontsize',24);
text(ax3, min(xlim + 0.004 ), min(ylim +0.003), '(g)', 'FontSize', 24, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');
%ylabel('Drought');
freezeColors;

%% 2022 - Drought

% Assign the subplot
nexttile(10);
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
line4 = m_streamline(lon3_int, lat3_int, u_map_mean(:,:,152), v_map_mean(:,:,152), 6);
for i = 1:length(line4)
    line4(i).LineWidth = 1.5;
    line4(i).Color = 'r';
end

%Making the plot look better
m_gshhs_i('patch',[0.8 0.8 0.8]);
m_grid('box','fancy','box','on','linewidth',3, 'fontsize', 18)

title(ax4, 'August 2022', 'Units', 'normalized', 'Position', [0.051, 0.88, 0], 'HorizontalAlignment', 'left');
set(ax4,'fontname','times new roman','fontsize',24);
text(ax4, min(xlim + 0.004 ), min(ylim +0.003), '(j)', 'FontSize', 24, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');
cb1 = colorbar(ax4, "southoutside");
%set(cb1, 'Position', [0.055 0.03 0.27 0.008]);
cb1.Label.String = ('SSS (psu)');
cb1.FontSize = 18;

freezeColors;
freezeColors(cb1);

%% 2011 - U FW Flux

% Assign the subplot
nexttile(2);
ax5 = gca;

% Plotting the GoM
m_proj('mercator','longitude',[-98 -78],'latitude',[17 32]) %initialize map
m_coast('line');
hold on;

%Plot mer_flux as a colormap -use lon3 and lat3 - same grid
m_pcolor(lon3_int, lat3_int, zon_flux_SMOS(:,:,20)); 
shading interp;
colormap(redblue(24)); 
clim([-1000 1000]);
hold on;

%Making the plot look better
m_gshhs_i('patch',[0.8 0.8 0.8]);
m_grid('box','fancy','box','on','linewidth',3, 'fontsize', 18)
handles5=findobj(ax5, 'tag', 'm_grid_xticklabel');
delete(handles5());
handles5=findobj(ax5, 'tag', 'm_grid_yticklabel');
delete(handles5());

title(ax5, 'U FW Flux', 'Units', 'normalized', 'Position', [0.051, 0.88, 0], 'HorizontalAlignment', 'left');
set(ax5,'fontname','times new roman','fontsize',24);
text(ax5, min(xlim + 0.004 ), min(ylim +0.003), '(b)', 'FontSize', 24, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');
freezeColors;

%% 2019 - U FW Flux

% Assign the subplot
nexttile(5);
ax6 = gca;

% Plotting the GoM
m_proj('mercator','longitude',[-98 -78],'latitude',[17 32]) %initialize map
m_coast('line');
hold on;

%Plot mer_flux as a colormap -use lon3 and lat3 - same grid
m_pcolor(lon3_int, lat3_int, zon_flux_SMOS(:,:,116)); 
shading interp;
colormap(redblue(24)); 
clim([-1000 1000]);
hold on;

%Making the plot look better
m_gshhs_i('patch',[0.8 0.8 0.8]);
m_grid('box','fancy','box','on','linewidth',3, 'fontsize', 18)
handles6=findobj(ax6, 'tag', 'm_grid_xticklabel');
delete(handles6());
handles6=findobj(ax6, 'tag', 'm_grid_yticklabel');
delete(handles6());

title(ax6, 'U FW Flux', 'Units', 'normalized', 'Position', [0.051, 0.88, 0], 'HorizontalAlignment', 'left');
set(ax6,'fontname','times new roman','fontsize',24);
text(ax6, min(xlim + 0.004 ), min(ylim +0.003), '(e)', 'FontSize', 24, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');
freezeColors;

%% 2012 - U FW Flux

% Assign the subplot
nexttile(8);
ax7 = gca;

% Plotting the GoM
m_proj('mercator','longitude',[-98 -78],'latitude',[17 32]) %initialize map
m_coast('line');
hold on;

%Plot mer_flux as a colormap -use lon3 and lat3 - same grid
m_pcolor(lon3_int, lat3_int, zon_flux_SMOS(:,:,32)); 
shading interp;
colormap(redblue(24)); 
clim([-1000 1000]);
hold on;

%Making the plot look better
m_gshhs_i('patch',[0.8 0.8 0.8]);
m_grid('box','fancy','box','on','linewidth',3, 'fontsize', 18)
handles7=findobj(ax7, 'tag', 'm_grid_xticklabel');
delete(handles7());
handles7=findobj(ax7, 'tag', 'm_grid_yticklabel');
delete(handles7());

title(ax7, 'U FW Flux', 'Units', 'normalized', 'Position', [0.051, 0.88, 0], 'HorizontalAlignment', 'left');
set(ax7,'fontname','times new roman','fontsize',24);
text(ax7, min(xlim + 0.004 ), min(ylim +0.003), '(h)', 'FontSize', 24, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');
freezeColors;

%% 2022 - U FW Flux

% Assign the subplot
nexttile(11);
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

%Making the plot look better
m_gshhs_i('patch',[0.8 0.8 0.8]);
m_grid('box','fancy','box','on','linewidth',3, 'fontsize', 18)
handles8=findobj(ax8, 'tag', 'm_grid_yticklabel');
delete(handles8());

title(ax8, 'U FW Flux', 'Units', 'normalized', 'Position', [0.051, 0.88, 0], 'HorizontalAlignment', 'left');
set(ax8,'fontname','times new roman','fontsize',24);
text(ax8, min(xlim + 0.004 ), min(ylim +0.003), '(k)', 'FontSize', 24, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');
freezeColors;

%% 2011 - V FW Flux

% Assign the subplot
nexttile(3);
ax9 = gca;

% Plotting the GoM
m_proj('mercator','longitude',[-98 -78],'latitude',[17 32]) %initialize map
m_coast('line');
hold on;

%Plot mer_flux as a colormap -use lon3 and lat3 - same grid
m_pcolor(lon3_int, lat3_int, mer_flux_SMOS(:,:,20)); 
shading interp;
colormap(redblue(24)); 
clim([-1000 1000]);
hold on;

%Making the plot look better
m_gshhs_i('patch',[0.8 0.8 0.8]);
m_grid('box','fancy','box','on','linewidth',3, 'fontsize', 18)
handles9=findobj(ax9, 'tag', 'm_grid_xticklabel');
delete(handles9());
handles9=findobj(ax9, 'tag', 'm_grid_yticklabel');
delete(handles9());

title(ax9, 'V FW Flux', 'Units', 'normalized', 'Position', [0.051, 0.88, 0], 'HorizontalAlignment', 'left');
set(ax9,'fontname','times new roman','fontsize',24);
text(ax9, min(xlim + 0.004 ), min(ylim +0.003), '(c)', 'FontSize', 24, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');
freezeColors;

%% 2019 - V FW Flux

% Assign the subplot
nexttile(6);
ax10 = gca;

% Plotting the GoM
m_proj('mercator','longitude',[-98 -78],'latitude',[17 32]) %initialize map
m_coast('line');
hold on;

%Plot mer_flux as a colormap -use lon3 and lat3 - same grid
m_pcolor(lon3_int, lat3_int, mer_flux_SMOS(:,:,116)); 
shading interp;
colormap(redblue(24)); 
clim([-1000 1000]);
hold on;

%Making the plot look better
m_gshhs_i('patch',[0.8 0.8 0.8]);
m_grid('box','fancy','box','on','linewidth',3, 'fontsize', 18)
handles10=findobj(ax10, 'tag', 'm_grid_xticklabel');
delete(handles10());
handles10=findobj(ax10, 'tag', 'm_grid_yticklabel');
delete(handles10());

title(ax10, 'V FW Flux', 'Units', 'normalized', 'Position', [0.051, 0.88, 0], 'HorizontalAlignment', 'left');
set(ax10,'fontname','times new roman','fontsize',24);
text(ax10, min(xlim + 0.004 ), min(ylim +0.003), '(f)', 'FontSize', 24, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');
freezeColors;

%% 2012 - V FW Flux

% Assign the subplot
nexttile(9);
ax11 = gca;

% Plotting the GoM
m_proj('mercator','longitude',[-98 -78],'latitude',[17 32]) %initialize map
m_coast('line');
hold on;

%Plot mer_flux as a colormap -use lon3 and lat3 - same grid
m_pcolor(lon3_int, lat3_int, mer_flux_SMOS(:,:,32)); 
shading interp;
colormap(redblue(24)); 
clim([-1000 1000]);
hold on;

%Making the plot look better
m_gshhs_i('patch',[0.8 0.8 0.8]);
m_grid('box','fancy','box','on','linewidth',3, 'fontsize', 18)
handles11=findobj(ax11, 'tag', 'm_grid_xticklabel');
delete(handles11());
handles11=findobj(ax11, 'tag', 'm_grid_yticklabel');
delete(handles11());

title(ax11, 'V FW Flux', 'Units', 'normalized', 'Position', [0.051, 0.88, 0], 'HorizontalAlignment', 'left');
set(ax11,'fontname','times new roman','fontsize',24);
text(ax11, min(xlim + 0.004 ), min(ylim +0.003), '(i)', 'FontSize', 24, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');
freezeColors;

%% 2022 - V FW Flux

% Assign the subplot
nexttile(12);
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

%Making the plot look better
m_gshhs_i('patch',[0.8 0.8 0.8]);
m_grid('box','fancy','box','on','linewidth',3, 'fontsize', 18)
handles12=findobj(ax12, 'tag', 'm_grid_yticklabel');
delete(handles12());

title(ax12, 'V FW Flux', 'Units', 'normalized', 'Position', [0.051, 0.88, 0], 'HorizontalAlignment', 'left');
set(ax12,'fontname','times new roman','fontsize',24);
text(ax12, min(xlim + 0.004 ), min(ylim +0.003), '(l)', 'FontSize', 24, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');
cb2=colorbar('SouthOutside'); 
set(cb2, 'Position', [0.365 0.0508 0.59 0.01]);
cb2.Label.String = ('Surface Advective Freshwater Flux (m^{2}/s)');
cb2.FontSize = 18;
freezeColors;
freezeColors(cb2);

%% Overall plot specifications

figname = fullfile(savepath, 'Lee_Figure3_OSCAR.tiff');  
set(gcf, 'InvertHardcopy', 'off')
exportgraphics(gcf, figname, 'BackGroundColor', 'none'); 

disp('Finished');
