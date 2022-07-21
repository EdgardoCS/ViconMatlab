
%lets make sure there are no residual data in workspace and command window
clc; clear;
%clf; %just in case we have figures

%we want to show the long(short) version of decimal data
format short g

%load data for target subject, lets start with S03
load('C:\Users\VICON\MatlabProjects\data\S23.mat')

%Set up variables (cells) since data size (due frames) is no equal in
%data will be stored for both planes and four conditions (50, 100, pre,
%post)
frontalMovPre50 = {};
frontalMovPost50 = {};
frontalMovPre100 = {};
frontalMovPost100 = {};

sagitalMovPre50 = {};
sagitalMovPost50 = {};
sagitalMovPre100 = {};
sagitalMovPost100 = {};

frontalMusclePre50 = {};
frontalMusclePost50 = {};
frontalMusclePre100 = {};
frontalMusclePost100 = {};

sagitalMusclePre50 = {};
sagitalMusclePost50 = {};
sagitalMusclePre100 = {};
sagitalMusclePost100 = {};

%filter stage for movement data, cut off frequency obtained by spectrum
%analysis
Fs = 100; %sample freq
Fc = [10 0.4 10]; % cut freq
FTilt = Fc(1)/(Fs/2);
FUpward = Fc(2)/(Fs/2);
FAbd = Fc(3)/(Fs/2);

df = designfilt('lowpassfir','FilterOrder',100,'CutoffFrequency',FTilt); %design filter
Frontal_Pre_ScapularTilt = filtfilt(df,Frontal_Pre_ScapularTilt);
Frontal_Post_ScapularTilt = filtfilt(df,Frontal_Post_ScapularTilt);

df = designfilt('lowpassfir','FilterOrder',100,'CutoffFrequency',FUpward); %design filter
Frontal_Pre_ScapularUpward = filtfilt(df,Frontal_Pre_ScapularUpward);
Frontal_Post_ScapularUpward = filtfilt(df,Frontal_Post_ScapularUpward);

df = designfilt('lowpassfir','FilterOrder',100,'CutoffFrequency',FAbd); %design filter
Frontal_Pre_HumeroFrontal = filtfilt(df,Frontal_Pre_HumeroFrontal);
Frontal_Post_HumeroFrontal = filtfilt(df,Frontal_Post_HumeroFrontal);

df = designfilt('lowpassfir','FilterOrder',100,'CutoffFrequency',FAbd); %design filter
Escapular_Pre_HumeroScapular = filtfilt(df,Escapular_Pre_HumeroScapular);
Escapular_Post_HumeroScapular = filtfilt(df,Escapular_Post_HumeroScapular);

target1 = serratoMVC;
target2 = trapezioMVC;

target1([49201]:end,:) = [];
target2([49201]:end,:) = [];

target1 = reshape(target1,[],3);
target2 = reshape(target2,[],3);

peakRmsSe = [];
peakRmsTr = [];

for i = 1: 3
    peakRmsSe = [peakRmsSe, rms(target1(:,i))];
    peakRmsTr = [peakRmsTr, rms(target2(:,i))];
end

peakRmsSe = max(peakRmsSe);
peakRmsTr = max(peakRmsTr);

for i=1:10
    if Trials(i) == 50
        data1Pre50 = Frontal_Pre_ScapularTilt(framesPreFrontal(i,1):framesPreFrontal(i,2));
        data1Post50 = Frontal_Post_ScapularTilt(framesPostFrontal(i,1):framesPostFrontal(i,2));
        data2Pre50 = Frontal_Pre_ScapularUpward(framesPreFrontal(i,1):framesPreFrontal(i,2));
        data2Post50 = Frontal_Post_ScapularUpward(framesPostFrontal(i,1):framesPostFrontal(i,2));
        data3Pre50 = Frontal_Pre_HumeroFrontal(framesPreFrontal(i,1):framesPreFrontal(i,2));
        data3Post50 = Frontal_Post_HumeroFrontal(framesPostFrontal(i,1):framesPostFrontal(i,2));
        data4Pre50 = Escapular_Pre_HumeroScapular(framesPreEscapular(i,1):framesPreEscapular(i,2));
        data4Post50 = Escapular_Post_HumeroScapular(framesPostEscapular(i,1):framesPostEscapular(i,2));

        frontal_serratoPre50_ROI = SerratoPreFrontal(framesPreFrontal(i,1)*20:framesPreFrontal(i,2)*20);
        frontal_serratoPost50_ROI = SerratoPostFrontal(framesPostFrontal(i,1)*20:framesPostFrontal(i,2)*20);
        frontal_trapezioPre50_ROI = TrapezioPreFrontal(framesPreFrontal(i,1)*20:framesPreFrontal(i,2)*20);
        frontal_trapezioPost50_ROI = TrapezioPostFrontal(framesPostFrontal(i,1)*20:framesPostFrontal(i,2)*20);

        sagital_serratoPre50_ROI = SerratoPreEscapular(framesPreEscapular(i,1)*20:framesPreEscapular(i,2)*20);
        sagital_serratoPost50_ROI = SerratoPostEscapular(framesPostEscapular(i,1)*20:framesPostEscapular(i,2)*20);
        sagital_trapezioPre50_ROI = TrapezioPreEscapular(framesPreEscapular(i,1)*20:framesPreEscapular(i,2)*20);
        sagital_trapezioPost50_ROI = TrapezioPostEscapular(framesPostEscapular(i,1)*20:framesPostEscapular(i,2)*20);

        sagitalMusclePre50 = [sagitalMusclePre50, sagital_serratoPre50_ROI, sagital_trapezioPre50_ROI]; % Serrato - Trapezio Pre 50 (Sagital plane)
        sagitalMusclePost50 = [sagitalMusclePost50, sagital_serratoPost50_ROI, sagital_trapezioPost50_ROI]; % Serrato - Trapezio Post 50 (Sagital plane)

        frontalMusclePre50 = [frontalMusclePre50, frontal_serratoPre50_ROI, frontal_trapezioPre50_ROI]; % Serrato - Trapezio Pre 50 (Frontal plane)
        frontalMusclePost50 = [frontalMusclePost50, frontal_serratoPost50_ROI, frontal_trapezioPost50_ROI]; % Serrato - Trapezio Post 50 (Frontal plane)

        frontalMovPre50 = [frontalMovPre50, data1Pre50, data2Pre50, data3Pre50]; % ScapTilt - ScapUp - HumeroAbd Pre 50 (Frontal plane)
        frontalMovPost50 = [frontalMovPost50, data1Post50, data2Post50, data3Post50]; % ScapTilt - ScapUp - HumeroAbd Post 50 (Frontal plane)

        sagitalMovPre50 = [sagitalMovPre50, data4Pre50]; % HumeroAbd Pre 50 (Sagital plane)
        sagitalMovPost50 = [sagitalMovPost50, data4Post50]; % HumeroAbd Post 50 (Sagital plane)

    elseif Trials(i) == 100
        data1Pre100 = Frontal_Pre_ScapularTilt(framesPreFrontal(i,1):framesPreFrontal(i,2));
        data1Post100 = Frontal_Post_ScapularTilt(framesPostFrontal(i,1):framesPostFrontal(i,2));
        data2Pre100 = Frontal_Pre_ScapularUpward(framesPreFrontal(i,1):framesPreFrontal(i,2));
        data2Post100 = Frontal_Post_ScapularUpward(framesPostFrontal(i,1):framesPostFrontal(i,2));
        data3Pre100 = Frontal_Pre_HumeroFrontal(framesPreFrontal(i,1):framesPreFrontal(i,2));
        data3Post100 = Frontal_Post_HumeroFrontal(framesPostFrontal(i,1):framesPostFrontal(i,2));
        data4Pre100 = Escapular_Pre_HumeroScapular(framesPreEscapular(i,1):framesPreEscapular(i,2));
        data4Post100 = Escapular_Post_HumeroScapular(framesPostEscapular(i,1):framesPostEscapular(i,2));

        frontal_serratoPre100_ROI = SerratoPreFrontal(framesPreFrontal(i,1)*20:framesPreFrontal(i,2)*20);
        frontal_serratoPost100_ROI = SerratoPostFrontal(framesPostFrontal(i,1)*20:framesPostFrontal(i,2)*20);
        frontal_trapezioPre100_ROI = TrapezioPreFrontal(framesPreFrontal(i,1)*20:framesPreFrontal(i,2)*20);
        frontal_trapezioPost100_ROI = TrapezioPostFrontal(framesPostFrontal(i,1)*20:framesPostFrontal(i,2)*20);

        sagital_serratoPre100_ROI = SerratoPreEscapular(framesPreEscapular(i,1)*20:framesPreEscapular(i,2)*20);
        sagital_serratoPost100_ROI = SerratoPostEscapular(framesPostEscapular(i,1)*20:framesPostEscapular(i,2)*20);
        sagital_trapezioPre100_ROI = TrapezioPreEscapular(framesPreEscapular(i,1)*20:framesPreEscapular(i,2)*20);
        sagital_trapezioPost100_ROI = TrapezioPostEscapular(framesPostEscapular(i,1)*20:framesPostEscapular(i,2)*20);

        sagitalMusclePre100 = [sagitalMusclePre100, sagital_serratoPre100_ROI, sagital_trapezioPre100_ROI]; % Serrato - Trapezio Pre 100 (Sagital plane)
        sagitalMusclePost100 = [sagitalMusclePost100, sagital_serratoPost100_ROI, sagital_trapezioPost100_ROI]; % Serrato - Trapezio Pre 100 (Sagital plane)

        frontalMusclePre100 = [frontalMusclePre100, frontal_serratoPre100_ROI, frontal_trapezioPre100_ROI]; % Serrato - Trapezio Pre 100 (Frontal plane)
        frontalMusclePost100 = [frontalMusclePost100, frontal_serratoPost100_ROI, frontal_trapezioPost100_ROI]; % Serrato - Trapezio Post 100 (Frontal plane)

        frontalMovPre100 = [frontalMovPre100, data1Pre100, data2Pre100, data3Pre100]; % ScapTilt - ScapUp - HumeroAbd Pre 100 (Frontal plane)
        frontalMovPost100 = [frontalMovPost100, data1Post100, data2Post100, data3Post100]; % ScapTilt - ScapUp - HumeroAbd Post 100 (Frontal plane)

        sagitalMovPre100 = [sagitalMovPre100, data4Pre100]; % HumeroAbd Pre 100 (Sagital plane)
        sagitalMovPost100 = [sagitalMovPost100, data4Post100]; % HumeroAbd Post 100 (Sagital plane)
    end

end


%clearvars -except sagitalMusclePre50 sagitalMusclePost50 sagitalMusclePre100 sagitalMusclePost100 frontalMusclePre50 frontalMusclePost50 frontalMusclePre100 frontalMusclePost100 sagitalMusclePost50 sagitalMusclePre100 sagitalMusclePost100 frontalMovPre50 frontalMovPost50 frontalMovPre100 frontalMovPost100 sagitalMovPre50 sagitalMovPost50 sagitalMovPre100 sagitalMovPost100

%{
data is distributed according to: 
frontalMov = {ScapularTilt, ScapularUpward, HumeroFrontal, ScapularTilt, ScapularUpward, HumeroFrontal, ScapularTilt, ScapularUpward, HumeroFrontal, ...} 
sagitalMov =  {HumeroScapular, HumeroScapular, HumeroScapular, HumeroScapular, ...}
frontalMuscle = {Serrato, Trapezio, ,Serrato, Trapezio, ...}
sagitalMuscle = {Serrato, Trapezio, ,Serrato, Trapezio, ...}
%}

%diary data.csv
[scapTiltRomPre50, scapTiltRomPost50, scapTiltRomPre100, scapTiltRomPost100, scapUpRomPre50, scapUpRomPost50,scapUpRomPre100, scapUpRomPost100, abdRomPre50, abdRomPost50, abdRomPre100, abdRomPost100] = frontalRomCalculation(frontalMovPre50, frontalMovPost50, frontalMovPre100, frontalMovPost100);

[sagitalbAbdRomPre50, sagitalbAbdRomPost50, sagitalbAbdRomPre100, sagitalbAbdRomPost100] = sagitalRomCalculation(sagitalMovPre50, sagitalMovPost50, sagitalMovPre100, sagitalMovPost100);

[serratoPre50, serratoPre100, serratoPost50, serratoPost100, trapezioPre50, trapezioPre100, trapezioPost50, trapezioPost100] = frontal_rawCalculation(frontalMusclePre50, frontalMusclePost50, frontalMusclePre100, frontalMusclePost100);

[sagitalSerratoPre50, sagitalSerratoPre100, sagitalSerratoPost50, sagitalSerratoPost100, sagitalTrapezioPre50, sagitalTrapezioPre100, sagitalTrapezioPost50, sagitalTrapezioPost100] = sagital_rawCalculation(sagitalMusclePre50, sagitalMusclePost50, sagitalMusclePre100, sagitalMusclePost100);

[rmsSerratoPre50, rmsSerratoPre100, rmsSerratoPost50, rmsSerratoPost100, rmsTrapezioPre50, rmsTrapezioPre100, rmsTrapezioPost50, rmsTrapezioPost100] = frontal_rmsCalculation(frontalMusclePre50, frontalMusclePost50, frontalMusclePre100, frontalMusclePost100, peakRmsSe, peakRmsTr);

[sagitalRmsSerratoPre50, sagitalRmsSerratoPre100, sagitalRmsSerratoPost50, sagitalRmsSerratoPost100, sagitalRmsTrapezioPre50, sagitalRmsTrapezioPre100, sagitalRmsTrapezioPost50, sagitalRmsTrapezioPost100] = sagital_rmsCalculation(sagitalMusclePre50, sagitalMusclePost50, sagitalMusclePre100, sagitalMusclePost100, peakRmsSe, peakRmsTr);

%diary off

zero = zeros(1,5);
varNames = {'Pre50';'Post50';'Pre100';'Post100';'SPre50';'SPost50';'SPre100';'SPost100'};
F = table( ...
    [abdRomPre50; scapUpRomPre50; scapTiltRomPre50;serratoPre50;trapezioPre50;rmsSerratoPre50;rmsTrapezioPre50], ...
    [abdRomPost50; scapUpRomPost50; scapTiltRomPost50;serratoPost50;trapezioPost50;rmsSerratoPost50;rmsTrapezioPost50], ...
    [abdRomPre100; scapUpRomPre100; scapTiltRomPre100;serratoPre100;trapezioPre100;rmsSerratoPre100;rmsTrapezioPre100], ...
    [abdRomPost100; scapUpRomPost100; scapTiltRomPost100;serratoPost100;trapezioPost100;rmsSerratoPost100;rmsTrapezioPost100], ...
    [sagitalbAbdRomPre50; zero; zero ;sagitalSerratoPre50; sagitalTrapezioPre50;sagitalRmsSerratoPre50;sagitalRmsTrapezioPre50], ...
    [sagitalbAbdRomPost50; zero ; zero ;sagitalSerratoPost50; sagitalTrapezioPost50;sagitalRmsSerratoPost50;sagitalRmsTrapezioPost50], ...
    [sagitalbAbdRomPre100; zero ; zero ;sagitalSerratoPre100; sagitalTrapezioPre100;sagitalRmsSerratoPre100;sagitalRmsTrapezioPre100],...
    [sagitalbAbdRomPost100; zero ; zero ;sagitalSerratoPost100; sagitalTrapezioPost100;sagitalRmsSerratoPost100;sagitalRmsTrapezioPost100],...
    'VariableNames',varNames);
writetable(F,'data.csv');

%close all

disp('Done');


function [scapTiltRomPre50, scapTiltRomPost50, scapTiltRomPre100, scapTiltRomPost100, scapUpRomPre50, scapUpRomPost50,scapUpRomPre100, scapUpRomPost100, abdRomPre50, abdRomPost50, abdRomPre100, abdRomPost100 ] = frontalRomCalculation(frontalMovPre50, frontalMovPost50, frontalMovPre100, frontalMovPost100)

temp1 = [];
temp2 = [];
temp3 = [];
temp4 = [];

temp5 = [];
temp6 = [];
temp7 = [];
temp8 = [];

temp9 = [];
temp10 = [];
temp11 = [];
temp12 = [];

for i = 1:3:15

    A = frontalMovPre50{:,i};
    B = frontalMovPre100{:,i};
    C = frontalMovPost50{:,i};
    D = frontalMovPost100{:,i};

    %{
    A = abs(A);
    B = abs(B);
    C = abs(C);
    D = abs(D);
    %}

    [endMovPre50, endIndex50] = max(A);
    [startMovPre50, index1] = min(A(1:endIndex50));
    temp1 = [temp1, endMovPre50-startMovPre50]; %ScapTilt Pre50

    [endMovPre100, endIndex100] = max(B);
    [startMovPre100, index2] = min(B(1:endIndex100));
    temp2 = [temp2, endMovPre100-startMovPre100]; %ScapTilt Pre100

    [endMovPost50, endIndex50] = max(C);
    [startMovPost50, index3] = min(C(1:endIndex50));
    temp3 = [temp3, endMovPost50-startMovPost50]; %ScapTilt Post50

    [endMovPost100, endIndex100] = max(D);
    [startMovPost100, index4] = min(D(1:endIndex100));
    temp4 = [temp4, endMovPost100-startMovPost100]; %ScapTilt Post100

    %{
    figure(1)
    subplot(2,2,1)
    plot(A)
    hold on
    plot(endIndex50, endMovPre50, 'rx')
    plot(index1, startMovPre50, 'bo')
    title('ScapularTilt Pre - 50')
    subplot(2,2,3)
    plot(B)
    hold on
    plot(endIndex100, endMovPre100, 'rx')
    plot(index2, startMovPre100, 'bo')
    title('ScapularTilt Pre - 100')
    subplot(2,2,2)
    plot(C)
    hold on
    plot(endIndex50, endMovPost50, 'rx')
    plot(index3, startMovPost50, 'bo')
    title('ScapularTilt Post - 50')
    subplot(2,2,4)
    plot(D)
    hold on
    plot(endIndex100, endMovPost100, 'rx')
    plot(index4, startMovPost100, 'bo')
    title('ScapularTilt Post - 100')
    %}

end

for i = 2:3:15 % movement 2

    A = frontalMovPre50{:,i};
    B = frontalMovPre100{:,i};
    C = frontalMovPost50{:,i};
    D = frontalMovPost100{:,i};

    [endMovPre50, endIndex50] = max(A);
    [startMovPre50, index1] = min(A(1:endIndex50));
    temp5 = [temp5, endMovPre50-startMovPre50]; %ScapUp Pre50

    [endMovPre100, endIndex100] = max(B);
    [startMovPre100, index2] = min(B(1:endIndex100));
    temp6 = [temp6, endMovPre100-startMovPre100]; %ScapUp Pre100

    [endMovPost50, endIndex50] = max(C);
    [startMovPost50, index3] = min(C(1:endIndex50));
    temp7 = [temp7, endMovPost50-startMovPost50]; %ScapUp Post50

    [endMovPost100, endIndex100] = max(D);
    [startMovPost100, index4] = min(D(1:endIndex100));
    temp8 = [temp8, endMovPost100-startMovPost100]; %ScapUp Post100

    %{
    figure(2)
    subplot(2,2,1)
    plot(A)
    hold on
    plot(endIndex50, endMovPre50, 'rx')
    plot(index1, startMovPre50, 'bo')
    title('ScapularUpward Pre - 50')
    subplot(2,2,3)
    plot(B)
    hold on
    plot(endIndex100, endMovPre100, 'rx')
    plot(index2, startMovPre100, 'bo')
    title('ScapularUpward Pre - 100')
    subplot(2,2,2)
    plot(C)
    hold on
    plot(endIndex50, endMovPost50, 'rx')
    plot(index3, startMovPost50, 'bo')
    title('ScapularUpward Post - 50')
    subplot(2,2,4)
    plot(D)
    hold on
    plot(endIndex100, endMovPost100, 'rx')
    plot(index4, startMovPost100, 'bo')
    title('ScapularUpward Post - 100')
    %}

end

for i = 3:3:15 % movement 3
    A = frontalMovPre50{:,i};
    B = frontalMovPre100{:,i};
    C = frontalMovPost50{:,i};
    D = frontalMovPost100{:,i};

    A = abs(A);
    B = abs(B);
    C = abs(C);
    D = abs(D);

    [endMovPre50, endIndex50] = max(A);
    [startMovPre50, index1] = min(A(1:endIndex50));
    temp9 = [temp9, endMovPre50-startMovPre50]; %Abd Pre50

    [endMovPre100, endIndex100] = max(B);
    [startMovPre100, index2] = min(B(1:endIndex100));
    temp10 = [temp10, endMovPre100-startMovPre100]; %Abd Pre100

    [endMovPost50, endIndex50] = max(C);
    [startMovPost50, index3] = min(C(1:endIndex50));
    temp11 = [temp11, endMovPost50-startMovPost50]; %Abd Post50

    [endMovPost100, endIndex100] = max(D);
    [startMovPost100, index4] = min(D(1:endIndex100));
    temp12 = [temp12, endMovPost100-startMovPost100]; %Abd Post100

    %{
    figure(3)
    subplot(2,2,1)
    plot(A)
    hold on
    plot(endIndex50, endMovPre50, 'rx')
    plot(index1, startMovPre50, 'bo')
    title('HumeroAbd - 50')
    subplot(2,2,3)
    plot(B)
    hold on
    plot(endIndex100, endMovPre100, 'rx')
    plot(index2, startMovPre100, 'bo')
    title('HumeroAbd Pre - 100')
    subplot(2,2,2)
    plot(C)
    hold on
    plot(endIndex50, endMovPost50, 'rx')
    plot(index3, startMovPost50, 'bo')
    title('HumeroAbd Post - 50')
    subplot(2,2,4)
    plot(D)
    hold on
    plot(endIndex100, endMovPost100, 'rx')
    plot(index4, startMovPost100, 'bo')
    title('HumeroAbd Post - 100')
    %}

end

% mromPre50 = [mromPre50,mean(temp1)];
scapTiltRomPre50(:,:) = (temp1);
scapTiltRomPost50(:,:) = (temp3);
scapTiltRomPre100(:,:) = (temp2);
scapTiltRomPost100(:,:) = (temp4);

scapUpRomPre50(:,:) = (temp5);
scapUpRomPost50(:,:) = (temp7);
scapUpRomPre100(:,:) = (temp6);
scapUpRomPost100(:,:) = (temp8);

abdRomPre50(:,:) = (temp9);
abdRomPost50(:,:) = (temp11);
abdRomPre100(:,:) = (temp10);
abdRomPost100(:,:) = (temp12);
end

function [sagitalbAbdRomPre50, sagitalbAbdRomPost50, sagitalbAbdRomPre100, sagitalbAbdRomPost100 ] = sagitalRomCalculation(sagitalMovPre50, sagitalMovPost50, sagitalMovPre100, sagitalMovPost100)

temp1 = [];
temp2 = [];
temp3 = [];
temp4 = [];

for i = 1:5

    A = sagitalMovPre50{:,i};
    B = sagitalMovPre100{:,i};
    C = sagitalMovPost50{:,i};
    D = sagitalMovPost100{:,i};

    [endMovPre50, endIndex50] = max(A);
    [startMovPre50, index1] = min(A(1:endIndex50));
    temp1 = [temp1, endMovPre50-startMovPre50]; %ScapTilt Pre50

    [endMovPre100, endIndex100] = max(B);
    [startMovPre100, index2] = min(B(1:endIndex100));
    temp2 = [temp2, endMovPre100-startMovPre100]; %ScapTilt Pre100

    [endMovPost50, endIndex50] = max(C);
    [startMovPost50, index3] = min(C(1:endIndex50));
    temp3 = [temp3, endMovPost50-startMovPost50]; %ScapTilt Post50

    [endMovPost100, endIndex100] = max(D);
    [startMovPost100, index4] = min(D(1:endIndex100));
    temp4 = [temp4, endMovPost100-startMovPost100]; %ScapTilt Post100

    %{
    figure(4)
    subplot(2,2,1)
    plot(A)
    hold on
    plot(endIndex50, endMovPre50, 'rx')
    plot(index1, startMovPre50, 'bo')
    title('Sagital Humerus Abd Pre - 50')

    subplot(2,2,3)
    plot(B)
    hold on
    plot(endIndex100, endMovPre100, 'rx')
    plot(index2, startMovPre100, 'bo')
    title('Sagital Humerus Abd Pre - 100')
    subplot(2,2,2)
    plot(C)
    hold on
    plot(endIndex50, endMovPost50, 'rx')
    plot(index3, startMovPost50, 'bo')
    title('Sagital Humerus Abd Post - 50')

    subplot(2,2,4)
    plot(D)
    hold on
    plot(endIndex100, endMovPost100, 'rx')
    plot(index4, startMovPost100, 'bo')
    title('Sagital Humerus Abd Post - 100')
    %}

end

% mromPre50 = [mromPre50,mean(temp1)];
sagitalbAbdRomPre50(:,:) = (temp1);
sagitalbAbdRomPost50(:,:) = (temp3);
sagitalbAbdRomPre100(:,:) = (temp2);
sagitalbAbdRomPost100(:,:) = (temp4);

end

function [serratoPre50, serratoPre100, serratoPost50, serratoPost100, trapezioPre50, trapezioPre100, trapezioPost50, trapezioPost100] = frontal_rawCalculation(frontalMusclePre50, frontalMusclePost50, frontalMusclePre100, frontalMusclePost100)
temp1 = [];
temp2 = [];
temp3 = [];
temp4 = [];
temp5 = [];
temp6 = [];
temp7 = [];
temp8 = [];

for i = 1:2:10
    A = frontalMusclePre50{:,i};
    B = frontalMusclePre100{:,i};
    C = frontalMusclePost50{:,i};
    D = frontalMusclePost100{:,i};
    temp1 = [temp1, mean(A)];
    temp2 = [temp2, mean(B)];
    temp3 = [temp3, mean(C)];
    temp4 = [temp4, mean(D)];
end


for i = 2:2:10
    A = frontalMusclePre50{:,i};
    B = frontalMusclePre100{:,i};
    C = frontalMusclePost50{:,i};
    D = frontalMusclePost100{:,i};
    temp5 = [temp5, mean(A)];
    temp6 = [temp6, mean(B)];
    temp7 = [temp7, mean(C)];
    temp8 = [temp8, mean(D)];
end

serratoPre50 = temp1;
serratoPre100 = temp2;
serratoPost50 = temp3;
serratoPost100 = temp4;

trapezioPre50 = temp5;
trapezioPre100 = temp6;
trapezioPost50 = temp7;
trapezioPost100 = temp8;

end

function [sagitalSerratoPre50, sagitalSerratoPre100, sagitalSerratoPost50, sagitalSerratoPost100, sagitalTrapezioPre50, sagitalTrapezioPre100, sagitalTrapezioPost50, sagitalTrapezioPost100] = sagital_rawCalculation(sagitalMusclePre50, sagitalMusclePost50, sagitalMusclePre100, sagitalMusclePost100)

temp1 = [];
temp2 = [];
temp3 = [];
temp4 = [];
temp5 = [];
temp6 = [];
temp7 = [];
temp8 = [];

for i = 1:2:10
    A = sagitalMusclePre50{:,i};
    B = sagitalMusclePre100{:,i};
    C = sagitalMusclePost50{:,i};
    D = sagitalMusclePost100{:,i};
    temp1 = [temp1, mean(A)];
    temp2 = [temp2, mean(B)];
    temp3 = [temp3, mean(C)];
    temp4 = [temp4, mean(D)];
end

for i = 2:2:10
    A = sagitalMusclePre50{:,i};
    B = sagitalMusclePre100{:,i};
    C = sagitalMusclePost50{:,i};
    D = sagitalMusclePost100{:,i};
    temp5 = [temp5, mean(A)];
    temp6 = [temp6, mean(B)];
    temp7 = [temp7, mean(C)];
    temp8 = [temp8, mean(D)];
end

sagitalSerratoPre50 = temp1;
sagitalSerratoPre100 = temp2;
sagitalSerratoPost50 = temp3;
sagitalSerratoPost100 = temp4;

sagitalTrapezioPre50 = temp5;
sagitalTrapezioPre100 = temp6;
sagitalTrapezioPost50 = temp7;
sagitalTrapezioPost100 = temp8;
end

function [rmsSerratoPre50, rmsSerratoPre100, rmsSerratoPost50, rmsSerratoPost100, rmsTrapezioPre50, rmsTrapezioPre100, rmsTrapezioPost50, rmsTrapezioPost100] = frontal_rmsCalculation(frontalMusclePre50, frontalMusclePost50, frontalMusclePre100, frontalMusclePost100, peakRmsSe, peakRmsTr)
temp1 = [];
temp2 = [];
temp3 = [];
temp4 = [];
temp5 = [];
temp6 = [];
temp7 = [];
temp8 = [];

for i = 1:2:10
    A = frontalMusclePre50{:,i};
    B = frontalMusclePre100{:,i};
    C = frontalMusclePost50{:,i};
    D = frontalMusclePost100{:,i};
    temp1 = [temp1, (rms(A)/peakRmsSe)*100];
    temp2 = [temp2, (rms(B)/peakRmsSe)*100];
    temp3 = [temp3, (rms(C)/peakRmsSe)*100];
    temp4 = [temp4, (rms(D)/peakRmsSe)*100];

end


for i = 2:2:10
    A = frontalMusclePre50{:,i};
    B = frontalMusclePre100{:,i};
    C = frontalMusclePost50{:,i};
    D = frontalMusclePost100{:,i};
    temp5 = [temp5, (rms(A)/peakRmsTr)*100];
    temp6 = [temp6, (rms(B)/peakRmsTr)*100];
    temp7 = [temp7, (rms(C)/peakRmsTr)*100];
    temp8 = [temp8, (rms(D)/peakRmsTr)*100];
end

rmsSerratoPre50 = temp1;
rmsSerratoPre100 = temp2;
rmsSerratoPost50 = temp3;
rmsSerratoPost100 = temp4;

rmsTrapezioPre50 = temp5;
rmsTrapezioPre100 = temp6;
rmsTrapezioPost50 = temp7;
rmsTrapezioPost100 = temp8;

end

function [sagitalRmsSerratoPre50, sagitalRmsSerratoPre100, sagitalRmsSerratoPost50, sagitalRmsSerratoPost100, sagitalRmsTrapezioPre50, sagitalRmsTrapezioPre100, sagitalRmsTrapezioPost50, sagitalRmsTrapezioPost100] = sagital_rmsCalculation(sagitalMusclePre50, sagitalMusclePost50, sagitalMusclePre100, sagitalMusclePost100, peakRmsSe, peakRmsTr)

temp1 = [];
temp2 = [];
temp3 = [];
temp4 = [];
temp5 = [];
temp6 = [];
temp7 = [];
temp8 = [];

for i = 1:2:10
    A = sagitalMusclePre50{:,i};
    B = sagitalMusclePre100{:,i};
    C = sagitalMusclePost50{:,i};
    D = sagitalMusclePost100{:,i};
    temp1 = [temp1, (rms(A)/peakRmsSe)*100];
    temp2 = [temp2, (rms(B)/peakRmsSe)*100];
    temp3 = [temp3, (rms(C)/peakRmsSe)*100];
    temp4 = [temp4, (rms(D)/peakRmsSe)*100];
end

for i = 2:2:10
    A = sagitalMusclePre50{:,i};
    B = sagitalMusclePre100{:,i};
    C = sagitalMusclePost50{:,i};
    D = sagitalMusclePost100{:,i};
    temp5 = [temp5, (rms(A)/peakRmsTr)*100];
    temp6 = [temp6, (rms(B)/peakRmsTr)*100];
    temp7 = [temp7, (rms(C)/peakRmsTr)*100];
    temp8 = [temp8, (rms(D)/peakRmsTr)*100];
end

sagitalRmsSerratoPre50 = temp1;
sagitalRmsSerratoPre100 = temp2;
sagitalRmsSerratoPost50 = temp3;
sagitalRmsSerratoPost100 = temp4;

sagitalRmsTrapezioPre50 = temp5;
sagitalRmsTrapezioPre100 = temp6;
sagitalRmsTrapezioPost50 = temp7;
sagitalRmsTrapezioPost100 = temp8;
end
