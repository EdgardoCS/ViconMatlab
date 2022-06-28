% The following code will calculate rom for the desire subject for "Upward Rotation" and "Posterior Tilt" model outputs.  
% EMG from Serrato and Trapezius muscles will also be calculated in the EMG
% section
% This code uses as input the data from Vicon nexus software, exported and
% stored in each subject .m file
%

%% clear workspace
clear; clc;

%% Get subject
prompt = "Select User: "; % subjects from 3 to 21
k = input(prompt);

matFiles = dir('data/*.mat'); % data directory
numFiles = length(matFiles) ; % numer of .m files in data directory

thisFileName = fullfile(matFiles(k-1).folder, matFiles(k-1).name);
fprintf('Processing "%s".\n', thisFileName);
target = load(thisFileName); % Target data

%% Data loaded
% Once the data is loaded, variables for each section (movement and EMG) are created
rotationPre1 = target.Frontal_Pre_ScapularTilt;
rotationPost1 = target.Frontal_Post_ScapularTilt;
rotationPre2 = target.Frontal_Pre_ScapularUpward;
rotationPost2 = target.Frontal_Post_ScapularUpward;

SerratoPreFrontal = target.SerratoPreFrontal;
SerratoPostFrontal = target.SerratoPostFrontal;
TrapezioPreFrontal = target.TrapezioPreFrontal;
TrapezioPostFrontal = target.TrapezioPostFrontal;
SerratoPreEscapular = target.SerratoPreEscapular;
SerratoPostEscapular = target.SerratoPostEscapular;
TrapezioPreEscapular = target.TrapezioPreEscapular;
TrapezioPostEscapular = target.TrapezioPostEscapular;

Trials = target.Trials;

%% Movement Section
% Splice the data into Pre and Post intervention, then divide into 10 equal
% sections
data1Pre = reshape(rotationPre1,round(length(rotationPre1)/10),[]);
data1Post = reshape(rotationPost1,round(length(rotationPost1)/10),[]);
data2Pre = reshape(rotationPre2,round(length(rotationPre2)/10),[]);
data2Post = reshape(rotationPost2,round(length(rotationPost2)/10),[]);

% MovementData function will identify each data from Pre and Post according
% to the target angle of movement (50 or 100)
% Then, it will store each movement data accordingly 
[tiltPre50,tiltPre100, tiltPost50 , tiltPost100, upwardPre50, upwardPre100, upwardPost50, upwardPost100] = movementData(data1Pre, data1Post, data2Pre, data2Post, Trials);

% Calculates MEAN for each movement
tiltMeanRomPre50 = mean(tiltPre50);
tiltMeanRomPre100 = mean(tiltPre100);
tiltMeanRomPost50 = mean(tiltPost50);
tiltMeanRomPost100 = mean(tiltPost100);
upwardMeanRomPre50 = mean(upwardPre50);
upwardMeanRomPre100 = mean(upwardPre100);
upwardMeanRomPost50 = mean(upwardPost50);
upwardMeanRomPost100 =mean(upwardPost100);

%Store trials for each subject (5) for each target degree of movement
tiltRomPre50(:,k-1) = (tiltPre50);
tiltRomPost50(:,k-1) = (tiltPost50);
tiltRomPre100(:,k-1) = (tiltPre100);
tiltRomPost100(:,k-1) = (tiltPost100);
upwardRomPre50(:,k-1) = (upwardPre50);
upwardRomPost50(:,k-1) = (upwardPost50);
upwardRomPre100(:,k-1) = (upwardPre100);
upwardRomPost100(:,k-1) = (upwardPost100);

% If EMG data fits the criteria, EMGData() will calculate the rms for each
% subject
% Each plane (frontal and sagital) has its own data. 
try
    [serratoFrontalPre50_rms, serratoFrontalPost50_rms, trapezioFrontalPre50_rms, trapezioFrontalPost50_rms, serratoFrontalPre100_rms, serratoFrontalPost100_rms, trapezioFrontalPre100_rms, trapezioFrontalPost100_rms] = emgDataFrontal(SerratoPreFrontal,SerratoPostFrontal, TrapezioPreFrontal, TrapezioPostFrontal, Trials);
catch
    disp('EMG data - Error')
end

try
    [serratoEscapularPre50_rms, serratoEscapularPost50_rms, trapezioEscapularPre50_rms, trapezioEscapularPost50_rms, serratoEscapularPre100_rms, serratoEscapularPost100_rms, trapezioEscapularPre100_rms, trapezioEscapularPost100_rms] = emgDataEscapular(SerratoPreEscapular,SerratoPostEscapular, TrapezioPreEscapular, TrapezioPostEscapular, Trials);
catch
    disp('EMG data - Error')
end

%plot for each subject (Default: 50°)
subplot(2,1,1)
plot(tiltPre50, '-xr')
hold on
plot(tiltPost50, '--xr')
hold on
xlim([0 6])
plot(upwardPre50, '-xk')
hold on
plot(upwardPost50, '--xk')
legend({'TiltPre','TiltPost','UpwardRotationPre','UpwardRotationPost'},'Location','southwest')
title('Movement - Target = 50°')

try
    subplot(2,1,2)
    plot(serratoFrontalPre50_rms, '-xr')
    hold on
    plot(serratoFrontalPost50_rms, '--xr')
    hold on
    xlim([0 6])
    plot(trapezioFrontalPre50_rms, '-xk')
    hold on
    plot(trapezioFrontalPost50_rms, '--xk')
    legend({'SerratoPre','SerratoPost','TrapezioPre','TrapezioPost'},'Location','southwest')
    title('Target Muscles RMS')
catch
    disp ('Plot unavailable')
end

function [tiltPre50,tiltPre100, tiltPost50 , tiltPost100, upwardPre50, upwardPre100, upwardPost50, upwardPost100] = movementData(data1Pre, data1Post, data2Pre, data2Post, Trials)

data1Pre50 = [];
data1Post50 = [];
data1Pre100 = [];
data1Post100 = [];

data2Pre50 = [];
data2Post50 = [];
data2Pre100 = [];
data2Post100 = [];

for i=1:length(Trials)
    if Trials(i) == 50
        data1Pre50= [data1Pre50,data1Pre(:,i)];
        data1Post50= [data1Post50,data1Post(:,i)];
        data2Pre50= [data2Pre50,data2Pre(:,i)];
        data2Post50= [data2Post50,data2Post(:,i)];
    else
        data1Pre100= [data1Pre100,data1Pre(:,i)];
        data1Post100= [data1Post100,data1Post(:,i)];
        data2Pre100= [data2Pre100,data2Pre(:,i)];
        data2Post100= [data2Post100,data2Post(:,i)];
    end
end


tiltRomPre50 = [];
tiltRomPre100 = [];
tiltRomPost50 = [];
tiltRomPost100 = [];
rom2Pre50 = [];
rom2Pre100 = [];
rom2Post50 = [];
rom2Post100 = [];

tiltPre50=[];
tiltPre100=[];
tiltPost50=[];
tiltPost100=[];
upwardPre50=[];
upwardPre100=[];
upwardPost50=[];
upwardPost100=[];

for b = 1: 5

    A = data1Pre50(:,b);
    B = data1Post50(:,b);
    C = data1Pre100(:,b);
    D = data1Post100(:,b);
    A2 = data2Pre50(:,b);
    B2 = data2Post50(:,b);
    C2 = data2Pre100(:,b);
    D2 = data2Post100(:,b);

    start1Pre50 = min(A(1:round(length(A)/2),1));
    start1Post50 = min(B(1:round(length(B)/2),1));
    end1Pre50 = max(A);
    end1Post50 = max(B);

    start1Pre100 = min(C(1:round(length(C)/2),1));
    start1Post100 = min(D(1:round(length(D)/2),1));
    end1Pre100 = max(C);
    end1Post100 = max(D);

    start2Pre50= min(A2(1:round(length(A2)/2),1));
    start2Post50 = min(B2(1:round(length(B2)/2),1));
    end2Pre50= max(A2);
    end2Post50 = max(B2);

    start2Pre100 = min(C2(1:round(length(C2)/2),1));
    start2Post100 = min(D2(1:round(length(D2)/2),1));
    end2Pre100 = max(C2);
    end2Post100 = max(D2);

    tiltPre50 = [tiltPre50, end1Pre50-start1Pre50];
    tiltPre100 = [tiltPre100, end1Pre100-start1Pre100];
    tiltPost50 = [tiltPost50, end1Post50-start1Post50];
    tiltPost100 = [tiltPost100, end1Post100-start1Post100];

    upwardPre50 = [upwardPre50,end2Pre50-start2Pre50];
    upwardPre100 = [upwardPre100, end2Pre100-start2Pre100];
    upwardPost50 = [upwardPost50,end2Post50-start2Post50];
    upwardPost100 = [upwardPost100,end2Post100-start2Post100];

end
end

function [a, b, c, d, e, f, g, h] = emgDataFrontal(SerratoPreFrontal,SerratoPostFrontal, TrapezioPreFrontal, TrapezioPostFrontal, Trials)

a = [];
b = [];
c = [];
d = [];
e = [];
f = [];
g = [];
h = [];

for i = 1 : 10

    timePlus = [24000 24000];
    timeLimits = [1 24000] + (timePlus*(i-1));

    muscle1Pre_ROI = SerratoPreFrontal(:);
    muscle1Post_ROI = SerratoPostFrontal(:);
    muscle2Pre_ROI = TrapezioPreFrontal(:);
    muscle2Post_ROI = TrapezioPostFrontal(:);

    if Trials(i) == 50
        muscle1Pre50_ROI = muscle1Pre_ROI(timeLimits(1):timeLimits(2));
        muscle1Post50_ROI = muscle1Post_ROI(timeLimits(1):timeLimits(2));
        muscle2Pre50_ROI = muscle2Pre_ROI(timeLimits(1):timeLimits(2));
        muscle2Post50_ROI = muscle2Post_ROI(timeLimits(1):timeLimits(2));
        a = [a, rms(muscle1Pre50_ROI)];
        b = [b, rms(muscle1Post50_ROI)];
        c = [c, rms(muscle2Pre50_ROI)];
        d = [d, rms(muscle2Post50_ROI)];

    elseif Trials(i) == 100
        muscle1Pre100_ROI = muscle1Pre_ROI(timeLimits(1):timeLimits(2));
        muscle1Post100_ROI = muscle1Post_ROI(timeLimits(1):timeLimits(2));
        muscle2Pre100_ROI = muscle2Pre_ROI(timeLimits(1):timeLimits(2));
        muscle2Post100_ROI = muscle2Post_ROI(timeLimits(1):timeLimits(2));
        e = [e, rms(muscle1Pre100_ROI)];
        f = [f, rms(muscle1Post100_ROI)];
        g = [g, rms(muscle2Pre100_ROI)];
        h = [h, rms(muscle2Post100_ROI)];
    end
end
end

function [a, b, c, d, e, f, g, h] = emgDataEscapular(SerratoPreEscapular,SerratoPostEscapular, TrapezioPreEscapular, TrapezioPostEscapular, Trials)

a = [];
b = [];
c = [];
d = [];
e = [];
f = [];
g = [];
h = [];

for i = 1 : 10

    timePlus = [24000 24000];
    timeLimits = [1 24000] + (timePlus*(i-1));

    muscle1Pre_ROI = SerratoPreEscapular(:);
    muscle1Post_ROI = SerratoPostEscapular(:);
    muscle2Pre_ROI = TrapezioPreEscapular(:);
    muscle2Post_ROI = TrapezioPostEscapular(:);

    if Trials(i) == 50
        muscle1Pre50_ROI = muscle1Pre_ROI(timeLimits(1):timeLimits(2));
        muscle1Post50_ROI = muscle1Post_ROI(timeLimits(1):timeLimits(2));
        muscle2Pre50_ROI = muscle2Pre_ROI(timeLimits(1):timeLimits(2));
        muscle2Post50_ROI = muscle2Post_ROI(timeLimits(1):timeLimits(2));
        a = [a, rms(muscle1Pre50_ROI)];
        b = [b, rms(muscle1Post50_ROI)];
        c = [c, rms(muscle2Pre50_ROI)];
        d = [d, rms(muscle2Post50_ROI)];

    elseif Trials(i) == 100
        muscle1Pre100_ROI = muscle1Pre_ROI(timeLimits(1):timeLimits(2));
        muscle1Post100_ROI = muscle1Post_ROI(timeLimits(1):timeLimits(2));
        muscle2Pre100_ROI = muscle2Pre_ROI(timeLimits(1):timeLimits(2));
        muscle2Post100_ROI = muscle2Post_ROI(timeLimits(1):timeLimits(2));
        e = [e, rms(muscle1Pre100_ROI)];
        f = [f, rms(muscle1Post100_ROI)];
        g = [g, rms(muscle2Pre100_ROI)];
        h = [h, rms(muscle2Post100_ROI)];
    end
end
end