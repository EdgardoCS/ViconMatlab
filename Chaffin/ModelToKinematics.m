% Created by E.Silva 19/05/23
% Last modification: 02/08/23

% Reference for model outputs
% https://docs.vicon.com/display/Nexus213/Upper+body+angles+as+output+from+Plug-in+Gait
% Calculate Amplitude, Duration, mean Velocity, mean Acceleration, Mean,
% RMS, and Variance of kinematic model output from Vicon for target
% movement *shoulder flexion, shoulder abduction. 

%{
Elbow(Y)        = Flexion (CW)
Shoulder(X)     = Abduction (ACW)
Shoulder(Y)     = Flexion (CW)
Wrist(X)        = Ulnar Deviation (ACW)
Wrist(Y)        = Extension (CW)
%}

clear ; clc;
format short

target = "S18"; %target subject (data)
% Working directory between workstations
if exist("C:/Users/Usuario/", 'dir')
    destination = ["C:/Users/Usuario/","OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_Escritorio\Data\DataModel\", target, ".mat"];
else
    destination = ["C:/Users/VICON/","OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_Escritorio\Data\DataModel\", target, ".mat"];
end

targetData = join(destination,"");
load(targetData);

%
% task 1. Writting.
% task 2. Reading
% task 3. Typing
% task 4. Perfomance (Pc)
% task 5. Perfomance (Tablet) 
% task 6. Object manipulation

% read table from subject's data. 
% store it in temp variable. 
% C01_T1_Shoulder = table2array(C01_T1_Shoulder);
% C02_T1_Shoulder = table2array(C02_T1_Shoulder);
% 
% C01_T2_Shoulder = table2array(C01_T2_Shoulder);
% C02_T2_Shoulder = table2array(C02_T2_Shoulder);
% 
% C01_T3_Shoulder = table2array(C01_T3_Shoulder);
% C02_T3_Shoulder = table2array(C02_T3_Shoulder);
% 
% C01_T4_Shoulder = table2array(C01_T4_Shoulder);
% C02_T4_Shoulder = table2array(C02_T4_Shoulder);
% 
% C01_T5_Shoulder = table2array(C01_T5_Shoulder);
% C02_T5_Shoulder = table2array(C02_T5_Shoulder);
% 
% C01_T6_Shoulder = table2array(C01_T6_Shoulder);
% C02_T6_Shoulder = table2array(C02_T6_Shoulder);

% Each dimension of the table represent an axis of movement, we are
% interested in x axis (abduction) and y axis (flexion)
% Data(x) = data(:,x,:) == data(:,1,:)
% Data(y) = data(:,y,:) == data(:,2,:)

shoulder1Abd1 = C01_T1_Shoulder(:,1,:);
shoulder1Abd2 = C02_T1_Shoulder(:,1,:);
shoulder1Flex1 = C01_T1_Shoulder(:,2,:);
shoulder1Flex2 = C02_T1_Shoulder(:,2,:);

shoulder2Abd1 = C01_T2_Shoulder(:,1,:);
shoulder2Abd2 = C02_T2_Shoulder(:,1,:);
shoulder2Flex1 = C01_T2_Shoulder(:,2,:);
shoulder2Flex2 = C02_T2_Shoulder(:,2,:);

shoulder3Abd1 = C01_T3_Shoulder(:,1,:);
shoulder3Abd2 = C02_T3_Shoulder(:,1,:);
shoulder3Flex1 = C01_T3_Shoulder(:,2,:);
shoulder3Flex2 = C02_T3_Shoulder(:,2,:);

shoulder4Abd1 = C01_T4_Shoulder(:,1,:);
shoulder4Abd2 = C02_T4_Shoulder(:,1,:);
shoulder4Flex1 = C01_T4_Shoulder(:,2,:);
shoulder4Flex2 = C02_T4_Shoulder(:,2,:);

shoulder5Abd1 = C01_T5_Shoulder(:,1,:);
shoulder5Abd2 = C02_T5_Shoulder(:,1,:);
shoulder5Flex1 = C01_T5_Shoulder(:,2,:);
shoulder5Flex2 = C02_T5_Shoulder(:,2,:);

shoulder6Abd1 = C01_T6_Shoulder(:,1,:);
shoulder6Abd2 = C02_T6_Shoulder(:,1,:);
shoulder6Flex1 = C01_T6_Shoulder(:,2,:);
shoulder6Flex2 = C02_T6_Shoulder(:,2,:);

tasks = {
    shoulder1Abd1, shoulder2Abd1, shoulder3Abd1, shoulder4Abd1, shoulder5Abd1, shoulder6Abd1, ...
    shoulder1Abd2, shoulder2Abd2, shoulder3Abd2, shoulder4Abd2, shoulder5Abd2, shoulder6Abd2, ...
    shoulder1Flex1, shoulder2Flex1, shoulder3Flex1, shoulder4Flex1, shoulder5Flex1, shoulder6Flex1, ...
    shoulder1Flex2, shoulder2Flex2, shoulder3Flex2, shoulder4Flex2, shoulder5Flex2, shoulder6Flex2, ...
    };

%{
tasks = {
    shoulder1Abd1, shoulder1Abd2, shoulder1Flex1, shoulder1Flex2,...
    shoulder2Abd1, shoulder2Abd2, shoulder2Flex1, shoulder2Flex2,...
    shoulder3Abd1, shoulder3Abd2, shoulder3Flex1, shoulder3Flex2,...
    shoulder4Abd1, shoulder4Abd2, shoulder4Flex1, shoulder4Flex2,...
    shoulder5Abd1, shoulder5Abd2, shoulder5Flex1, shoulder5Flex2,...
    shoulder6Abd1, shoulder6Abd2, shoulder6Flex1, shoulder6Flex2
    };
%}

for i= 1:length(tasks)
    task = tasks(i);
    % extract data using extractData function
    [amplitude, duration, v_mean, v_max, a_max, mean, rms, variance] = extractData(cell2mat(task)); 

    amplitudes(i) = round(amplitude,3);
    durations(i) = round(duration,3);
    v_means(i) = round(v_mean,3);
    v_maxs(i) = round(v_max,3);
    a_maxs(i) = round(a_max,3);
    means(i) = round(mean,3);
    rmss(i) = round(rms,3);
    variances(i) = round(variance,3);

end

Rows = {
    'ShoulderAbduction_Write1'; 'ShoulderAbduction_Read1';'ShoulderAbduction_Type1'; 'ShoulderAbduction_FittsPc1';'ShoulderAbduction_FittsTablet1'; 'ShoulderAbduction_Manipulate1';
    'ShoulderAbduction_Write2'; 'ShoulderAbduction_Read2';'ShoulderAbduction_Type2'; 'ShoulderAbduction_FittsPc2';'ShoulderAbduction_FittsTablet2'; 'ShoulderAbduction_Manipulate2';
    'ShoulderFlexion_Write1'; 'ShoulderFlexion_Read1';'ShoulderFlexion_Type1'; 'ShoulderFlexion_FittsPc1';'ShoulderFlexion_FittsTablet1'; 'ShoulderFlexion_Manipulate1';
    'ShoulderFlexion_Write2'; 'ShoulderFlexion_Read2';'ShoulderFlexion_Type2'; 'ShoulderFlexion_FittsPc2';'ShoulderFlexion_FittsTablet2'; 'ShoulderFlexion_Manipulate2';
    };

%{
Rows = {
    'ShoulderAbduction_Write1'; 'ShoulderAbduction_Write2';'ShoulderFlexion_Write1'; 'ShoulderFlexion_Write2';
    'ShoulderAbduction_Read1'; 'ShoulderAbduction_Read2';'ShoulderFlexion_Read1'; 'ShoulderFlexion_Read2';
    'ShoulderAbduction_Type1'; 'ShoulderAbduction_Type2';'ShoulderFlexion_Type1'; 'ShoulderFlexion_Type2';
    'ShoulderAbduction_FittsPc1'; 'ShoulderAbduction_FittsPc2';'ShoulderFlexion_FittsPc1'; 'ShoulderFlexion_FittsPc2';
    'ShoulderAbduction_FittsTablet1'; 'ShoulderAbduction_FittsTablet2';'ShoulderFlexion_FittsTablet1'; 'ShoulderFlexion_FittsTablet2';
    'ShoulderAbduction_Manipulate1'; 'ShoulderAbduction_Manipulate2';'ShoulderFlexion_Manipulate1'; 'ShoulderFlexion_Manipulate2';
    };
%}

Columns = {'Amplitude'; 'Duration'; 'Vel_mean'; 'Vel_max'; 'Acc_max'; 'Mean'; 'RMS'; 'Variance'};

modelOutput = table(amplitudes.', durations.', v_means.', v_maxs.', a_maxs.', means.', rmss.', variances.',...
    'RowNames',Rows, 'VariableNames',Columns)


% Save to .xlsx
filename = join([target,'.xlsx'],"");
writetable(modelOutput,filename,"WriteRowNames",true)

% Save to .mat
save(targetData,'modelOutput','-append')

clear

%%
% Functions

function [v_max,a_max] = calculateAcc(a,b)
x = a;
t = 1:b;

dx = diff(x); %derivada de posicion
dt = diff(t); %derivada de tiempo

% v - velocity
v = dx./dt;
v = v*100;
v_max = max(v,[],"all");

% a - acceleration
dv = diff(v); %derivada de velocidad

a = dv./dt(1:end);
a = a*100;
a_max = max(a,[],"all");
end

function [amplitude, duration, v_mean, v_max, a_max, taskMean, taskRms, variance] = extractData(task)

%{
Camera sampling rate == 100 hz
EMG sampling rate == 2000 hz
%}

cameraRate = 100;

% AMPLITUDE : Rotation amplitude of the executed movement, i.e., the
% angular distance (expressed in degrees) travelled by the arm during the
% execution of a task
% amplitude = abs(max - min)

amplitude = abs(max(task)-min(task));

% DURATION : Difference between the end and start point of the movement
% (expressed in seconds)
duration = length(task)/cameraRate;

% MEAN VELOCITY : Ratio between the amplitude and the duration of the
% movement (expressed in degrees per second)

v_mean = (amplitude/duration)*100;

% MAXIMUM VELOCITY : Maximum value of the velocity within the movement
% (expreseed in degrees per second)

% MAXIMUM ACCELERATION : Maximum value of the acceleration within the
% movement (expressed in degrees per squared second)

[v_max,a_max] = calculateAcc(task, duration);

%MEAN RMS VARIANCE

taskMean = mean(task);
taskRms = rms(task);
variance = var(task);

end



