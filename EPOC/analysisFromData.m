% Created by E.Silva
% Modified by E.Silva 18/10/23

clc; clear;

s = ['1', '2', '3', '4', '5'];
%s = ['1'];

BRom = [];
BTime = [];
BRomSpirometry = [];
BTimeSpirometry = [];

PRom = [];
PTime = [];
PRomSpirometry = [];
PTimeSpirometry = [];

TRom = [];
TTime = [];
TRomSpirometry = [];
TTimeSpirometry = [];

for t = 1:length(s)

    targetData = join(['data\sujeto', s(t),'.mat'],'');
    load(targetData);
    nNames = fieldnames(peaks);
    A = [];  % ROM
    B = [];  % TIME
    C = [];  % ROM Spirometry
    D = [];  % TIME Spirometry

    for i = 1:3
        dataPeaks = peaks.(nNames{i});
        dataemg = emgrms.(nNames{i});
        [A(i,:), B(i,:), C(i,:), D(i,:)] = extractRom(dataPeaks);
    end

    BRom = [BRom, A];
    BTime = [BTime, B];
    BRomSpirometry = [BRomSpirometry, C];
    BTimeSpirometry = [BTimeSpirometry, D];

    A = [];  % ROM
    B = [];  % TIME
    C = [];  % ROM Spirometry
    D = [];  % TIME Spirometry

    for i = 4:6
        dataPeaks = peaks.(nNames{i});
        dataemg = emgrms.(nNames{i});
        [A(i-3,:), B(i-3,:), C(i-3,:), D(i-3,:)] = extractRom(dataPeaks);
    end

    PRom = [PRom, A];
    PTime = [PTime, B];
    PRomSpirometry = [PRomSpirometry, C];
    PTimeSpirometry = [PTimeSpirometry, D];

    A = [];  % ROM
    B = [];  % TIME
    C = [];  % ROM Spirometry
    D = [];  % TIME Spirometry

    for i = 7:9
        dataPeaks = peaks.(nNames{i});
        dataemg = emgrms.(nNames{i});
        [A(i-6,:), B(i-6,:), C(i-6,:), D(i-6,:)] = extractRom(dataPeaks);
    end

    TRom = [TRom, A];
    TTime = [TTime, B];
    TRomSpirometry = [TRomSpirometry, C];
    TTimeSpirometry = [TTimeSpirometry, D];
end

BRom = reshape(BRom, [length(s)*3, 1]);
BTime = reshape(BTime, [length(s)*3, 1]);
BRomSpirometry = reshape(BRomSpirometry, [length(s)*3, 1]);
BTimeSpirometry = reshape(BTimeSpirometry, [length(s)*3, 1]);

PRom = reshape(BRom, [length(s)*3, 1]);
PTime = reshape(PTime, [length(s)*3, 1]);
PRomSpirometry = reshape(PRomSpirometry, [length(s)*3, 1]);
PTimeSpirometry = reshape(PTimeSpirometry, [length(s)*3, 1]);

TRom = reshape(BRom, [length(s)*3, 1]);
TTime = reshape(TTime, [length(s)*3, 1]);
TRomSpirometry = reshape(TRomSpirometry, [length(s)*3, 1]);
TTimeSpirometry = reshape(TTimeSpirometry, [length(s)*3, 1]);


disp('Done')

function [romBasal, timeBasal, spiroBasal, timeSpiroBasal] = extractRom(inputData)

counter = 0 ;
data = inputData;

for i = 1:2:6

    counter = counter + 1;

    xstart = data(i,1);
    xend = data(i+1,1);

    ystart = data(i,2);
    yend = data(i+1,2);

    timeDiaphragm(counter,:) = abs(xend- xstart);
    romDiaphragm(counter,:) = abs(yend-ystart);

    timeBasal = mean(timeDiaphragm)/100; %seconds
    romBasal = mean(romDiaphragm); % cm

    timeSpiroBasal = abs(data(8,1)-data(7,1))/100; %seconds
    spiroBasal = abs(data(8,2)-data(7,2)); %cm
    % romDiaphragmSpiroIns = abs(data(9,2)-data(8,2))
end

end

% emgBasalActivity1 = mean([mean(emgrms.EB1(:,1)), mean(emgrms.EB2(:,1)), mean(emgrms.EB3(:,1))]);
% emgBasalActivity2 = mean([mean(emgrms.EB1(:,2)), mean(emgrms.EB2(:,2)), mean(emgrms.EB3(:,2))]);
% emgBasalActivity3 = mean([mean(emgrms.EB1(:,3)), mean(emgrms.EB2(:,3)), mean(emgrms.EB3(:,3))]);
% emgBasalActivity4 = mean([mean(emgrms.EB1(:,4)), mean(emgrms.EB2(:,4)), mean(emgrms.EB3(:,4))]);
% emgBasalActivity5 = mean([mean(emgrms.EB1(:,5)), mean(emgrms.EB2(:,5)), mean(emgrms.EB3(:,5))]);
% emgBasalActivity6 = mean([mean(emgrms.EB1(:,6)), mean(emgrms.EB2(:,6)), mean(emgrms.EB3(:,6))]);
%     muscleActivity1(counter,:) = (mean(dataemg(xstart*20:xend*20,1))*100)/basalActivity1
%     muscleActivity2(counter,:) = (mean(dataemg(xstart*20:xend*20,1))*100)/basalActivity2
%     muscleActivity3(counter,:) = (mean(dataemg(xstart*20:xend*20,1))*100)/basalActivity3
%     muscleActivity4(counter,:) = (mean(dataemg(xstart*20:xend*20,1))*100)/basalActivity4
%     muscleActivity5(counter,:) = (mean(dataemg(xstart*20:xend*20,1))*100)/basalActivity5
%     muscleActivity6(counter,:) = (mean(dataemg(xstart*20:xend*20,1))*100)/basalActivity6


