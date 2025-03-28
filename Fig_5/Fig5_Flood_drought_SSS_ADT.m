%% A 2x2 subplot that has SSS and ADT contours for flood and drought years

% Days for 2019 and 2022 determined by Subra, but 2011 and 2012 come from
% SMOS ADT colorplot movies - found the most retracted LC in 2011 and
% the mmost extened LC phase in 2012

close all;
clear;
clc;
addpath(genpath('/Users/pameladoran/Documents/Toolbox-19May2024'));
savepath = '/Volumes/PamelaResearch/Ricky_Project/Fig_5/';

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

year = 2011;
month = 8;
day = 15;

% Grabbing and renaming variables
[lon1_int_sss, lat1_int_sss, sss1_clip] = retrieveSMOS_SSS(year, month, day);

[~, ~, lon1_int, lat1_int, adt_int, ~] = retrieveADT(year, month, day);

v_positive=adt_int;
v_negative=adt_int;
v_positive(v_positive<0)=NaN;
v_negative(v_negative>0)=NaN;

%Plots and zooms in on the Gulf of Mexico
m_proj('mercator','longitude',[-98 -78],'latitude',[17 32]) %initialize map
m_coast('line');
hold on;

%Plot SSS as a colormap
m_pcolor(lon1_int_sss, lat1_int_sss, sss1_clip);
shading interp;
colormap(jet(100)); % Colormap used by Brokaw et al 2019
clim([33 37.5]);
hold on;

% Plot ADt contours
[C,h]=m_contour(lon1_int,lat1_int,v_positive,'-k','linewidth',1, 'LevelList', 0.1:0.1:0.9);
clabel(C,h,'fontsize',7)
[C,h]=m_contour(lon1_int,lat1_int,v_negative,'--k','linewidth',1, 'LevelList', -0.9:0.1:-0.1);
clabel(C,h,'fontsize',7)

%Added in extra contour line for 17 cm SSH
[~,~]=m_contour(lon1_int,lat1_int,v_positive,[0.17 0.17], '-k','linewidth',3);

%Making the plot look better
m_gshhs_i('patch',[0.8 0.8 0.8]);
m_grid('box','fancy','box','on','linewidth',3, 'fontsize', 16)
handles=findobj(ax1, 'tag', 'm_grid_xticklabel');
delete(handles());

title(ax1, [int2str(month) '/' int2str(day) '/' int2str(year)] , 'Units', 'normalized', 'Position', [0.17,0.87, 0]);
set(ax1,'fontname','times new roman','fontsize',26);
text(ax1, min(xlim + 0.004 ), min(ylim +0.003), '(a)', 'FontSize', 26, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');
ylabel('Flood');

%% 2019 - Flood

% Assign the subplot
nexttile;
ax2 = gca;

year = 2019;
month = 9;
day = 22;

% Grabbing and renaming variables
[lon1_int_sss, lat1_int_sss, sss1_clip] = retrieveSMOS_SSS(year, month, day);

[~, ~, lon1_int, lat1_int, adt_int, ~] = retrieveADT(year, month, day);

v_positive=adt_int;
v_negative=adt_int;
v_positive(v_positive<0)=NaN;
v_negative(v_negative>0)=NaN;

%Plots and zooms in on the Gulf of Mexico
m_proj('mercator','longitude',[-98 -78],'latitude',[17 32]) %initialize map
m_coast('line');
hold on;

%Plot SSS as a colormap
m_pcolor(lon1_int_sss, lat1_int_sss, sss1_clip);
shading interp;
colormap(jet(100)); % Colormap used by Brokaw et al 2019
clim([33 37.5]);
hold on;

% Plot ADt contours
[C,h]=m_contour(lon1_int,lat1_int,v_positive,'-k','linewidth',1, 'LevelList', 0.1:0.1:0.9);
clabel(C,h,'fontsize',7)
[C,h]=m_contour(lon1_int,lat1_int,v_negative,'--k','linewidth',1, 'LevelList', -0.9:0.1:-0.1);
clabel(C,h,'fontsize',7)

%Added in extra contour line for 17 cm SSH
[~,~]=m_contour(lon1_int,lat1_int,v_positive,[0.17 0.17], '-k','linewidth',3);

%Making the plot look better
m_gshhs_i('patch',[0.8 0.8 0.8]);
m_grid('box','fancy','box','on','linewidth',3, 'fontsize', 16)
handles2=findobj(ax2, 'tag', 'm_grid_xticklabel');
delete(handles2());
handles3=findobj(ax2, 'tag', 'm_grid_yticklabel');
delete(handles3());

title(ax2, [int2str(month) '/' int2str(day) '/' int2str(year)] , 'Units', 'normalized', 'Position', [0.17,0.87, 0]);
set(ax2,'fontname','times new roman','fontsize',26);
text(ax2, min(xlim + 0.004 ), min(ylim +0.003), '(b)', 'FontSize', 26, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');


%% 2012 - Drought

% Assign the subplot
nexttile;
ax3 = gca;

year = 2012;
month = 5;
day = 25;

% Grabbing and renaming variables
[lon1_int_sss, lat1_int_sss, sss1_clip] = retrieveSMOS_SSS(year, month, day);

[~, ~, lon1_int, lat1_int, adt_int, ~] = retrieveADT(year, month, day);

v_positive=adt_int;
v_negative=adt_int;
v_positive(v_positive<0)=NaN;
v_negative(v_negative>0)=NaN;

%Plots and zooms in on the Gulf of Mexico
m_proj('mercator','longitude',[-98 -78],'latitude',[17 32]) %initialize map
m_coast('line');
hold on;

%Plot SSS as a colormap
m_pcolor(lon1_int_sss, lat1_int_sss, sss1_clip);
shading interp;
colormap(jet(100)); % Colormap used by Brokaw et al 2019
clim([33 37.5]);
hold on;

% Plot ADt contours
[C,h]=m_contour(lon1_int,lat1_int,v_positive,'-k','linewidth',1, 'LevelList', 0.1:0.1:0.9);
clabel(C,h,'fontsize',7)
[C,h]=m_contour(lon1_int,lat1_int,v_negative,'--k','linewidth',1, 'LevelList', -0.9:0.1:-0.1);
clabel(C,h,'fontsize',7)

%Added in extra contour line for 17 cm SSH
[~,~]=m_contour(lon1_int,lat1_int,v_positive,[0.17 0.17], '-k','linewidth',3);

%Making the plot look better
m_gshhs_i('patch',[0.8 0.8 0.8]);
m_grid('box','fancy','box','on','linewidth',3, 'fontsize', 16)

title(ax3, [int2str(month) '/' int2str(day) '/' int2str(year)] , 'Units', 'normalized', 'Position', [0.17,0.87, 0]);
set(ax3,'fontname','times new roman','fontsize',26);
text(ax3, min(xlim + 0.004 ), min(ylim +0.003), '(c)', 'FontSize', 26, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');
ylabel('Drought');

%% 2022 - Drought

% Assign the subplot
nexttile;
ax4 = gca;

year = 2022;
month = 4;
day = 23;

% Grabbing and renaming variables
[lon1_int_sss, lat1_int_sss, sss1_clip] = retrieveSMOS_SSS(year, month, day);

[lon1_int_mask, lat1_int_mask, lon1_int, lat1_int, adt_int, adt_int_mask] = retrieveADT(year, month, day);

v_positive=adt_int;
v_negative=adt_int;
v_positive(v_positive<0)=NaN;
v_negative(v_negative>0)=NaN;

%Plots and zooms in on the Gulf of Mexico
m_proj('mercator','longitude',[-98 -78],'latitude',[17 32]) %initialize map
m_coast('line');
hold on;

%Plot SSS as a colormap
m_pcolor(lon1_int_sss, lat1_int_sss, sss1_clip);
shading interp;
colormap(jet(100)); % Colormap used by Brokaw et al 2019
clim([33 37.5]);
hold on;

% Plot ADt contours
[C,h]=m_contour(lon1_int,lat1_int,v_positive,'-k','linewidth',1, 'LevelList', 0.1:0.1:0.9);
clabel(C,h,'fontsize',7)
[C,h]=m_contour(lon1_int,lat1_int,v_negative,'--k','linewidth',1, 'LevelList', -0.9:0.1:-0.1);
clabel(C,h,'fontsize',7)

%Added in extra contour line for 17 cm SSH
[C,h]=m_contour(lon1_int,lat1_int,v_positive,[0.17 0.17], '-k','linewidth',3);

%Making the plot look better
m_gshhs_i('patch',[0.8 0.8 0.8]);
m_grid('box','fancy','box','on','linewidth',3, 'fontsize', 16)
handles4=findobj(ax4, 'tag', 'm_grid_yticklabel');
delete(handles4());

title(ax4, [int2str(month) '/' int2str(day) '/' int2str(year)] , 'Units', 'normalized', 'Position', [0.17,0.87, 0]);
set(ax4,'fontname','times new roman','fontsize',26);
text(ax4, min(xlim + 0.004 ), min(ylim +0.003), '(d)', 'FontSize', 26, 'HorizontalAlignment','left', 'VerticalAlignment', 'bottom');

%% Overall plot specifications

% Common colorbar at the bottom
cb = colorbar('Position', [0.0922 0.07 0.82 0.008] , 'Orientation',  'horizontal'); 
cb.FontSize = 24;
cb.Label.String = ('SSS (psu)');

figname = fullfile(savepath, 'Fig5_SSS_ADT_SMOS_FloodvsDrought.tif');  
set(gcf, 'InvertHardcopy', 'off')
exportgraphics(gcf, figname, 'BackGroundColor', 'none'); 

disp('Finished');