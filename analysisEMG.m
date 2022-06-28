clc; clear;
%% Set Path through startup function
run('startup.m');

%% Load data
prompt = "Select User: ";
x = input(prompt, "s");

prompt2 = "Select target muscle: ";
x2 = input(prompt2, "s");

prompt3 = "Select target plane: ";
x3 = input(prompt3, "s");

req = strcat('C:\Users\VICON\MatlabProjects\data\',x,'.mat');
req2 = strcat(x2,'Pre',x3);
req3 = strcat(x2,'Post',x3);

try
    temp1 = load(req,req2);
    temp2 = load(req,req3);
    temp3 = load(req,'Trials');

    disp('Data loaded succesfully');
catch
    warning('User data does not exist');
end

temp1 = struct2cell(temp1);
musclePre = temp1{1};
temp2 = struct2cell(temp2);
musclePost = temp2{1};
temp3 = struct2cell(temp3);
trials = temp3{1};


%% Asign data to variable

%create variable in case plot fails
limitA = 0;
limitB = 0;

%% Plot data
f = figure('units','centimeters','position',[1,5,40,20]);

plot(musclePre, Color=[0 0.4470 0.7410])
hold on
plot(musclePost, Color =[0.4660 0.6740 0.1880]);
ylim([-2.0e-4 2.0e-4])

%% Create cursor (from CreateCursor.m)
n1=CreateCursor(f);
SetCursorLocation(n1, (length(musclePre)/2)-10000);
n2=CreateCursor(f);
SetCursorLocation(n2, (length(musclePre)/2)+10000);

%% Call function to control cursor
c = uicontrol;
c.String = ' GO ';
c.Callback= @(src,event)pushedButton(musclePre, musclePost, c, f);
disp('---------------');
disp('Gui is now open');

%% Wait for plot to be closed, then calculate rms
waitfor(c);
disp('Gui is now closed');

[pre50_rms, post50_rms, pre100_rms, post100_rms] = moveData(limitA,limitB,musclePre, musclePost, trials);

%clearvars -except pre50_rms post50_rms pre100_rms post100_rms
function pushedButton(musclePre, musclePost, c, f)
%This function get the cursor location (from GetCursorLocation.m) and creates a workspace variable,
%limitA and limitB
a = GetCursorLocation(1);
b = GetCursorLocation(2);
assignin('base','limitA',a);
assignin('base','limitB',b);
% Plot a, b into GUI
p = uipanel(f,'Position',[0.07 0.02 0.07 0.06]);
c = uicontrol(p, 'Style','text', 'String',strcat('Start:  ',int2str(a)));
p2 = uipanel(f,'Position',[0.15 0.02 0.07 0.06]);
c2 = uicontrol(p2, 'Style','text', 'String',strcat('End:  ',int2str(b)));
%f = msgbox("Limits set","Aviso","warn");
return
end

%% Move data window and calculate RMS
function [c, d, e, f] = moveData(a,b,musclePre, musclePost, trials)
%This function takes both cursors position, select the ROI of data and
%calculate the rms
%Then, it moves to the next data window

%create storage variables
c = [];
d = [];
e = [];
f = [];

%set for cycle to move across trials
for i = 1 : 10
    %set data window (x axis)
    plusX = 24000*(i-1);

    timeLimits = [round(a) round(b)]+ plusX;

    %data for ROI
    musclePre_ROI = musclePre(:);
    musclePost_ROI = musclePost(:);

    if trials(i) == 50
        musclePre50_ROI = musclePre_ROI(timeLimits(1):timeLimits(2));
        musclePost50_ROI = musclePost_ROI(timeLimits(1):timeLimits(2));
        c = [c, rms(musclePre50_ROI)];
        d = [d, rms(musclePost50_ROI)];
    elseif trials(i) == 100
        musclePre100_ROI = musclePre_ROI(timeLimits(1):timeLimits(2));
        musclePost100_ROI = musclePost_ROI(timeLimits(1):timeLimits(2));
        e = [e, rms(musclePre100_ROI)];
        f = [f, rms(musclePost100_ROI)];
    end
end
end

