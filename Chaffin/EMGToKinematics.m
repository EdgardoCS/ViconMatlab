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


target = "001"; % target subject (data)
targetMuscles = ["deltAnt" "deltMed" "serrAnt" "trapInf" "trapMed" "trapSup"];
targetTask = ["T1" "T2" "T3" "T4" "T5" "T6"];
targetCondition = ["C01" "C02"];

destinationTask = join([pwd,'/DataEMG/', target, "/taskData.mat"],"");

currentFolder = pwd;

newData = {};

for i= 1:length(targetCondition)
    for j= 1:length(targetTask)
        for k=1:length(targetMuscles)
            disp(join(['Working on ',targetCondition(i),"_",targetTask(j),"_",targetMuscles(k)], ""))
            [norm, meanMuscleUsePercentage] = normalizedEMG(targetMuscles, targetTask, targetCondition,destinationTask, target, i,j,k);

            newData{k,j,i} = norm(:,1); % x,y,z == muscle, task, condition
        end
    end
end

disp('Exporting data...')

varNames1 = {
    'Condition1-Muscle1';'Condition1-Muscle2';'Condition1-Muscle3';...
    'Condition1-Muscle4';'Condition1-Muscle5';'Condition1-Muscle6';...
    };
varNames2 = {
    'Condition2-Muscle1';'Condition2-Muscle2';'Condition2-Muscle3';...
    'Condition2-Muscle4';'Condition2-Muscle5';'Condition2-Muscle6';...
    };

names = ["dataTask1.xlsx" "dataTask2.xlsx" "dataTask3.xlsx" ...
        "dataTask4.xlsx" "dataTask5.xlsx" "dataTask6.xlsx"];

for j=1:6
    F1 = table(newData{1,j,1}, newData{2,j,1}, newData{3,j,1},...
        newData{4,j,1}, newData{5,j,1}, newData{6,j,1},...
        'VariableNames',varNames1);
    F2 = table(newData{1,j,2}, newData{2,j,2}, newData{3,j,2},...
        newData{4,j,2}, newData{5,j,2}, newData{6,j,2},...
        'VariableNames',varNames2);

    writetable(F1,names(j),'Sheet',1);
    writetable(F2,names(j),'Sheet',2);

    disp(join([names(j), ' ready'], ""))
end


clear


function [norm, meanMuscleUsePercentage] = normalizedEMG(targetMuscles, targetTask, targetCondition,destinationTask, target, i,j,k)
% Search and load target data from MVC, only once
destinationMVC = join([pwd,'/DataEMG/', target, '/', targetMuscles(k), '.mat'],"");
load(destinationMVC);

% for normalization, we will take the peak amplitude from MVC
peakEmg = max(Data(2,:));

% Now, lets load target muscle activity according to current task
% and condition
load(destinationTask, join([targetCondition(i),"_",targetTask(j),"_",targetMuscles(k)], ""));
currentMuscle = load(destinationTask, join([targetCondition(i),"_",targetTask(j),"_",targetMuscles(k)], ""));

% get data from struct
currentName = fieldnames(currentMuscle);
currentName = currentName{1};
target = getfield(currentMuscle,currentName);

% calculate RMS from raw data
rmsv = sqrt((movmean(target.^2, 1000)));

% To normalize:
% (data/(peak))*100
norm = (rmsv/peakEmg)*100;

% lets calculate a simplified version of the muscle performance (%)
minEMG = min(norm);
maxEMG = max(norm);
meanMuscleUsePercentage = abs(minEMG-maxEMG);

end
