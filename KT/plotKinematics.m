load('C:\Users\Usuario\Documents\GitHub\ViconMatlab\KT\DataMatlab\S03.mat')
v=100+zeros(length(Escapular_Pre_ScapularTilt),1);

createfigure(Frontal_Pre_ScapularTilt, Frontal_Post_ScapularTilt, v)

function createfigure(YMatrix1, Y1, Target)

%CREATEFIGURE(YMatrix1, Y1)
%  YMATRIX1:  matrix of plot y data
%  Y1:  vector of plot y data

%  Auto-generated by MATLAB on 21-Jul-2023 11:43:36

% Create figure
f = figure('WindowState','maximized');

% Create axes
axes1 = axes;
hold(axes1,'on');

% Create multiple line objects using matrix input to plot
plot1 = plot(abs(YMatrix1));
set(plot1(1),'DisplayName','Pre','LineWidth',1.5,'Color',[0 0 0]);
ylim([0 35])

% plot(Target,'DisplayName','Target (100°)','LineWidth',2,...
%     'Color',[0.501960784313725 0.501960784313725 0.501960784313725]);

% Create plot
plot(abs(Y1),'DisplayName','Post','LineWidth',1.5,'LineStyle','--',...
    'Color',[0.149019607843137 0.149019607843137 0.149019607843137]);
ylim([0 35])

% Create ylabel
ylabel({'Degrees'},'FontSize',18);

% Create xlabel
xlabel({'Time (s)'},'FontSize',18);

% Create title
title({'Kinematics - Scapula Joint - Frontal Plane'},'FontWeight','bold',...
    'FontSize',24);

box(axes1,'on');
hold(axes1,'off');
% Set the remaining axes properties
set(axes1,'XTickLabel',{'0','20','40','60','80','100','120','140'});

% Create legend
legend1 = legend(axes1,'show');
set(legend1,'FontSize',18);

exportgraphics(f,'Kinematics-ScapulaFrontalTilt.png','Resolution',300)

end
