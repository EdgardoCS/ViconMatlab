%format short

%clc; clear;

subjects = "Subject02" ;

targetSubject = subjects;

%clearvars -except subjects targetSubject;

% Working directory between workstations
if exist("C:/Users/Usuario/", 'dir')
    destination = "C:/Users/Usuario/";
else
    destination = "C:/Users/VICON/";
end

target1 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_EPOC\",targetSubject,"/EB1.csv"],"");
target2 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_EPOC\",targetSubject,"/EB2.csv"],"");
target3 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_EPOC\",targetSubject,"/EB3.csv"],"");

target4 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_EPOC\",targetSubject,"/EP1.csv"],"");
target5 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_EPOC\",targetSubject,"/EP2.csv"],"");
target6 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_EPOC\",targetSubject,"/EP3.csv"],"");

target7 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_EPOC\",targetSubject,"/ET1.csv"],"");
target8 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_EPOC\",targetSubject,"/ET2.csv"],"");
target9 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_EPOC\",targetSubject,"/ET3.csv"],"");

trialsEB = [target1, target2, target3];
trialsEP = [target4, target5, target6];
trialsET = [target7, target8, target9];

data = readmatrix(target9);

idx_end = data(end,1);
idx_start = data(4,1);

if idx_start ~= 0
    idx_end = data(end,1) - idx_start+1;
    idx_start = 1;
end

modelstart = idx_start;
modelend = (idx_end*20)+3;

EMG7 = data(4:modelend,9);
EMG8 = data(4:modelend,10);
EMG9 = data(4:modelend,11);
EMG10 = data(4:modelend,12);
EMG11 = data(4:modelend,13);
EMG12 = data(4:modelend,14);

