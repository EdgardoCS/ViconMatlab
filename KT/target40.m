% lets clear everything
clc; clear;

%Also, we want to show the long(short) version of decimal data
format short g

target = "S22"; % here modify target subject

currentFolder = pwd;
destination = [pwd,"\DataMatlab\",target,".mat"];
targetData = join(destination,"");
load(targetData); %this folder may vary

% Frontal_Pre_HumeroFrontal
% Frontal_Pre_ScapularTilt
% Frontal_Pre_ScapularUpward

dataKinematics = Frontal_Pre_HumeroFrontal;

dataEmg1 = TrapezioPreFrontal;
dataEmg2 = SerratoPreFrontal;
mvcEmg1 = trapezioMVCRMS;
mvcEmg2 = serratoMVCRMS;

dataOn = [];
dataOff = [];

[emgFilt1, emgRms1] = filterEMG(dataEmg1);
[emgFilt2, emgRms2] = filterEMG(dataEmg2);

[normEmg1] = normalizeActivity(emgRms1,mvcEmg1);
[normEmg2] = normalizeActivity(emgRms2,mvcEmg2);

target1 = -5;
target2 = -40;

% data = dataKinematics <= target1 & dataKinematics >= target2


for i=1:length(dataKinematics)-1
    if dataKinematics(i) <= target1 && dataKinematics(i) >= target2
        dataOn(i,:) = dataKinematics(i);
    else
        dataOn(i,:) = NaN;
    end
end

for i=1:length(dataOn)-1
    if dataOn(i+1)-dataOn(i)<0
        dataOn(i) = dataOn(i);
    else
        dataOn(i) = 0;
    end
end

plot(dataKinematics)
hold on
plot(dataOn)
linearIndexes = find(dataOn ~= 0)

starto = linearIndexes(1);
endo = [];

for i=1:length(linearIndexes)-1
    if linearIndexes(i+1)-linearIndexes(i) >300
        endo = [endo,linearIndexes(i)]; 
        starto = [starto, linearIndexes(i+1)];
    end
end
starto(11) = [];


ttemp = {};
stemp = {}; 


for i = 1:10
    ttemp = [ttemp, dataEmg1(starto(i)*20:endo(i)*20)];
    stemp = [stemp, dataEmg2(starto(i)*20:endo(i)*20)];
end

trapezio50 = {};
trapezio100 = {};
serrato50 = {};
serrato100 = {};

for i = 1 :10
    if Trials(i) == 50
        trapezio50 = [trapezio50,ttemp(:,i)];
        serrato50 = [serrato50,stemp(:,i)];
    else
        trapezio100 = [trapezio100,ttemp(:,i)];
        serrato100 = [serrato100,stemp(:,i)];
    end
end


% Wrap it up
TrapezioTarget50.Trial1 = trapezio50{1};
TrapezioTarget50.Trial2 = trapezio50{2};
TrapezioTarget50.Trial3 = trapezio50{3};
TrapezioTarget50.Trial4 = trapezio50{4};
TrapezioTarget50.Trial5 = trapezio50{5};

TrapezioTarget100.Trial1 = trapezio100{1};
TrapezioTarget100.Trial2 = trapezio100{2};
TrapezioTarget100.Trial3 = trapezio100{3};
TrapezioTarget100.Trial4 = trapezio100{4};
TrapezioTarget100.Trial5 = trapezio100{5};

SerratoTarget50.Trial1 = serrato50{1};
SerratoTarget50.Trial2 = serrato50{2};
SerratoTarget50.Trial3 = serrato50{3};
SerratoTarget50.Trial4 = serrato50{4};
SerratoTarget50.Trial5 = serrato50{5};

SerratoTarget100.Trial1 = serrato100{1};
SerratoTarget100.Trial2 = serrato100{2};
SerratoTarget100.Trial3 = serrato100{3};
SerratoTarget100.Trial4 = serrato100{4};
SerratoTarget100.Trial5 = serrato100{5};

clearvars -except SerratoTarget50 SerratoTarget100 TrapezioTarget50 TrapezioTarget100 dataOn

disp('Done')

function [emgFilt, emgRms] = filterEMG(inputData)
    Fs = 2000;
    emgFilt = bandpass(inputData,[30 300],Fs);
    emgRms = sqrt(movmean(emgFilt.^ 2, 1000));
end

function [normEmg] = normalizeActivity(inputData1,inputData2)
    normEmg = (inputData1*100)/mean(inputData2);
end
