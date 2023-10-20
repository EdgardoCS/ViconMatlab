% Created by E.Silva 17/07/23

% Calculate EMG variables from VICON + Delsys of target
% movement *shoulder flexion, shoulder abduction.
% including normalization (from MVC/RMS)


%{
Elbow(Y)        = Flexion (CW)
Shoulder(X)     = Abduction (ACW)
Shoulder(Y)     = Flexion (CW)
Wrist(X)        = Ulnar Deviation (ACW)
Wrist(Y)        = Extension (CW)
%}

clear ; clc;
format short

t = [
    "001"
    "002"
    "003"
    "004"
    "005"
    "006"
    "007"
    "008"
    "009"
    "010"
    "011"
    "012"
    "013"
    "014"
    "015"
    "016"
    "017"
    "018"
    "019"
    "020"
    "021"
    "022"
    "023"
    "024"
    "025"
    "026"
    "027"
    "028"
    "029"
    "030"
    "031"
    "032"
    "033"
    "034"
    ];


% targetMuscles = "serrAnt";
% targetTask = "T6";
% targetCondition = "C02";

targetMuscles = ["deltAnt" "deltMed" "serrAnt" "trapInf" "trapMed" "trapSup"];
targetTask = ["T1" "T2" "T3" "T4" "T5" "T6"];
targetCondition = ["C01" "C02"];

for m=1:length(t)
    target = t(m);

    destinationTask = join([pwd,'/DataEMG/', target, "/taskData.mat"],"")

    currentFolder = pwd;

    newData = {};

    for i= 1:length(targetCondition)
        for j= 1:length(targetTask)
            for k=1:length(targetMuscles)
                % disp(join(['Working on ',targetCondition(i),"_",targetTask(j),"_",targetMuscles(k)], ""))
                [rmsv, norm] = normalizedEMG(targetMuscles, targetTask, targetCondition,destinationTask, target, i,j,k);

                % lets calculate a simplified version of the muscle performance (%)

                tempMinEMG= min(norm);
                tempMaxEMG = max(norm);
                minEMGPercentage(k,j,i) = tempMinEMG;
                maxEMGPercentage(k,j,i) = tempMaxEMG;
                meanEMGPercentage(k,j,i) = abs(tempMinEMG-tempMaxEMG);


                % find ON/OFF
                temp = [];
                tempMeanMuscleActivity = [];
                threshold0 = 0.5; 
                threshold1 = 5;
                threshold2 = 15;
                threshold3 = 25;

                offLevel = [];
                lowLevel = [];
                moderateLevel = [];
                highLevel = [];
                veryHighLevel = [];

                % threshold=(rms(rmsv))+zeros(length(rmsv),1);
                for l=1:length(norm)
                    if norm(l) <= threshold0
                        offLevel(l,1) = 1; 
                    elseif norm(l)  > threshold0 && norm(l) <= threshold1
                        lowLevel(l,1) = 1;
                    elseif norm(l) > threshold1 && norm(l) <= threshold2
                        moderateLevel(l,1) = 1;
                    elseif norm(l) > threshold2 && norm(l) <= threshold3
                        highLevel(l,1) = 1;
                    elseif norm(l) > threshold3
                        veryHighLevel(l,1) = 1;
                    end
                end
                totalTime(k,j,i) = length(norm)/2000; 
                offTime(k,j,i) = length(find(offLevel))/2000;
                lowOnTime(k,j,i) = length(find(lowLevel))/2000;
                moderateOnTime(k,j,i) = length(find(moderateLevel))/2000;
                highOnTime(k,j,i) = length(find(highLevel))/2000;
                veryHighOnTime(k,j,i) = length(find(veryHighLevel))/2000;

                %tempMeanMuscleActivity = mean(tempMeanMuscleActivity);
                %meanEMG(k,j,i) = tempMeanMuscleActivity*1000; % saved as mV
            end
        end
    end

    %%
    disp('Exporting data...')


    varNames1 = {
        'Condition1-Muscle1';'Condition1-Muscle2';'Condition1-Muscle3';...
        'Condition1-Muscle4';'Condition1-Muscle5';'Condition1-Muscle6';...
        };
    varNames2 = {
        'Condition2-Muscle1';'Condition2-Muscle2';'Condition2-Muscle3';...
        'Condition2-Muscle4';'Condition2-Muscle5';'Condition2-Muscle6';...
        };

    %% For Normalized data
    %{
    destinationTask = join([pwd,'/DataEMG/', target, "/"],"");

    names = ["dataTask1.xlsx" "dataTask2.xlsx" "dataTask3.xlsx" ...
        "dataTask4.xlsx" "dataTask5.xlsx" "dataTask6.xlsx"];

    for j=1:6
        F1 = table(newData{1,j,1}, newData{2,j,1}, newData{3,j,1},...
            newData{4,j,1}, newData{5,j,1}, newData{6,j,1},...
            'VariableNames',varNames1);
        F2 = table(newData{1,j,2}, newData{2,j,2}, newData{3,j,2},...
            newData{4,j,2}, newData{5,j,2}, newData{6,j,2},...
            'VariableNames',varNames2);

        writetable(F1,join([destinationTask names(j)],""),'Sheet',1);
        writetable(F2,join([destinationTask names(j)],""),'Sheet',2);

        disp(join([names(j), ' ready'], ""))
    end
    %}

    %% For Calculations

    matFile = join(["C:/Users/Usuario/","OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_Escritorio\Data\DataEMG\", target, '/', target, '.mat'],"")
    save(matFile,'meanEMGPercentage', 'maxEMGPercentage', 'minEMGPercentage', 'lowOnTime', 'moderateOnTime', 'highOnTime', 'veryHighOnTime', 'offTime', 'totalTime')

    disp('Done');
    % clearvars -except t targetMuscles targetTask targetCondition


end

function [rmsv,norm] = normalizedEMG(targetMuscles, targetTask, targetCondition,destinationTask, target, i,j,k)

% Search and load target data from MVC, only once
destinationMVC = join([pwd,'/DataEMG/', target, '/', targetMuscles(k), '.mat'],"");
load(destinationMVC);

% for normalization, we will take the peak amplitude from MVC
peakEmg = max(Data(2,:)); %RMS MVC in mV

% Now, lets load target muscle activity according to current task
% and condition
load(destinationTask, join([targetCondition(i),"_",targetTask(j),"_",targetMuscles(k)], ""));
currentMuscle = load(destinationTask, join([targetCondition(i),"_",targetTask(j),"_",targetMuscles(k)], ""));

% get data from struct
currentName = fieldnames(currentMuscle);
currentName = currentName{1};

target = getfield(currentMuscle,currentName);

%remove outliers
target = rmoutliers(target, "mean");

% butterworth filter to raw data
fs = 2000; %sample freq
fn = fs/2; %nyquist freq
fch = 20;  %cut freq High
% fcl = 300; %cut freq Low

% 4th order butterworth band-pass
%[b,a] = butter(4,[fch,fcl]/fn, "bandpass");

% 2nd order butterworth low
[b,a] = butter(2,fch*1.25/fn,"low");
%apply filter
filteredData = filtfilt(b,a,target);

% rectifitaction
filteredData = abs(filteredData-mean(filteredData));

% calculate RMS from raw data
window = 500;
rmsv = sqrt((movmean(filteredData.^2, window)));

% To normalize:
% (data/(peak))*100
norm = (rmsv/peakEmg)*100;

end
