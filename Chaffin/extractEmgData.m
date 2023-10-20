
% Escritura
% Lectura
% Digitacion
% FittsPc
% FittsTablet
% Manipulacion

% Elbow
% Shoulder
% Wrist


clc; clear;

targetSubject = "Subject34";

% Working directory between workstations
if exist("C:/Users/Usuario/", 'dir')
    destination = "C:/Users/Usuario/";
else
    destination = "C:/Users/VICON/";
end

target1 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_Escritorio\Data\Experiment\",targetSubject,"/Escritura01.csv"],"");
target2 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_Escritorio\Data\Experiment\",targetSubject,"/Escritura02.csv"],"");
target3 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_Escritorio\Data\Experiment\",targetSubject,"/Lectura01.csv"],"");
target4 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_Escritorio\Data\Experiment\",targetSubject,"/Lectura02.csv"],"");
target5 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_Escritorio\Data\Experiment\",targetSubject,"/Digitacion01.csv"],"");
target6 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_Escritorio\Data\Experiment\",targetSubject,"/Digitacion02.csv"],"");
target7 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_Escritorio\Data\Experiment\",targetSubject,"/FittsPc01.csv"],"");
target8 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_Escritorio\Data\Experiment\",targetSubject,"/FittsPc02.csv"],"");
target9 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_Escritorio\Data\Experiment\",targetSubject,"/FittsTablet01.csv"],"");
target10 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_Escritorio\Data\Experiment\",targetSubject,"/FittsTablet02.csv"],"");
target11 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_Escritorio\Data\Experiment\",targetSubject,"/Manipulacion01.csv"],"");
target12 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_Escritorio\Data\Experiment\",targetSubject,"/Manipulacion02.csv"],"");


startFrame = 12;

disp (join(['Extracting Data for', targetSubject]))

%% 
data = readmatrix(target1);
idx_start = data(4,1);
idx_end = data(end,1);

C01_T1_deltAnt = data((4:((idx_end-idx_start)+1)*20)+3,9);
C01_T1_deltMed = data((4:((idx_end-idx_start)+1)*20)+3,10);
C01_T1_trapSup = data((4:((idx_end-idx_start)+1)*20)+3,11);
C01_T1_trapMed = data((4:((idx_end-idx_start)+1)*20)+3,13);
C01_T1_trapInf = data((4:((idx_end-idx_start)+1)*20)+3,13);
C01_T1_serrAnt = data((4:((idx_end-idx_start)+1)*20)+3,14);
disp ('Task1, Condition1. Status Ok')

%%
data = readmatrix(target2);
idx_start = data(4,1);
idx_end = data(end,1);

C02_T1_deltAnt = data((4:((idx_end-idx_start)+1)*20)+3,9);
C02_T1_deltMed = data((4:((idx_end-idx_start)+1)*20)+3,10);
C02_T1_trapSup = data((4:((idx_end-idx_start)+1)*20)+3,11);
C02_T1_trapMed = data((4:((idx_end-idx_start)+1)*20)+3,13);
C02_T1_trapInf = data((4:((idx_end-idx_start)+1)*20)+3,13);
C02_T1_serrAnt = data((4:((idx_end-idx_start)+1)*20)+3,14);
disp ('Task1, Condition2. Status Ok')

%%
data = readmatrix(target3);
idx_start = data(4,1);
idx_end = data(end,1);

C01_T2_deltAnt = data((4:((idx_end-idx_start)+1)*20)+3,9);
C01_T2_deltMed = data((4:((idx_end-idx_start)+1)*20)+3,10);
C01_T2_trapSup = data((4:((idx_end-idx_start)+1)*20)+3,11);
C01_T2_trapMed = data((4:((idx_end-idx_start)+1)*20)+3,13);
C01_T2_trapInf = data((4:((idx_end-idx_start)+1)*20)+3,13);
C01_T2_serrAnt = data((4:((idx_end-idx_start)+1)*20)+3,14);
disp ('Task2, Condition1. Status Ok')

%%
data = readmatrix(target4);
idx_start = data(4,1);
idx_end = data(end,1);

C02_T2_deltAnt = data((4:((idx_end-idx_start)+1)*20)+3,9);
C02_T2_deltMed = data((4:((idx_end-idx_start)+1)*20)+3,10);
C02_T2_trapSup = data((4:((idx_end-idx_start)+1)*20)+3,11);
C02_T2_trapMed = data((4:((idx_end-idx_start)+1)*20)+3,13);
C02_T2_trapInf = data((4:((idx_end-idx_start)+1)*20)+3,13);
C02_T2_serrAnt = data((4:((idx_end-idx_start)+1)*20)+3,14);
disp ('Task2, Condition2. Status Ok')

%%
data = readmatrix(target5);
idx_start = data(4,1);
idx_end = data(end,1);

C01_T3_deltAnt = data((4:((idx_end-idx_start)+1)*20)+3,9);
C01_T3_deltMed = data((4:((idx_end-idx_start)+1)*20)+3,10);
C01_T3_trapSup = data((4:((idx_end-idx_start)+1)*20)+3,11);
C01_T3_trapMed = data((4:((idx_end-idx_start)+1)*20)+3,13);
C01_T3_trapInf = data((4:((idx_end-idx_start)+1)*20)+3,13);
C01_T3_serrAnt = data((4:((idx_end-idx_start)+1)*20)+3,14);
disp ('Task3, Condition1. Status Ok')

%%
data = readmatrix(target6);
idx_start = data(4,1);
idx_end = data(end,1);

C02_T3_deltAnt = data((4:((idx_end-idx_start)+1)*20)+3,9);
C02_T3_deltMed = data((4:((idx_end-idx_start)+1)*20)+3,10);
C02_T3_trapSup = data((4:((idx_end-idx_start)+1)*20)+3,11);
C02_T3_trapMed = data((4:((idx_end-idx_start)+1)*20)+3,13);
C02_T3_trapInf = data((4:((idx_end-idx_start)+1)*20)+3,13);
C02_T3_serrAnt = data((4:((idx_end-idx_start)+1)*20)+3,14);
disp ('Task3, Condition2. Status Ok')

%%
data = readmatrix(target7);
idx_start = data(4,1);
idx_end = data(end,1);

C01_T4_deltAnt = data((4:((idx_end-idx_start)+1)*20)+3,9);
C01_T4_deltMed = data((4:((idx_end-idx_start)+1)*20)+3,10);
C01_T4_trapSup = data((4:((idx_end-idx_start)+1)*20)+3,11);
C01_T4_trapMed = data((4:((idx_end-idx_start)+1)*20)+3,13);
C01_T4_trapInf = data((4:((idx_end-idx_start)+1)*20)+3,13);
C01_T4_serrAnt = data((4:((idx_end-idx_start)+1)*20)+3,14);
disp ('Task4, Condition1. Status Ok')

%%
data = readmatrix(target8);
idx_start = data(4,1);
idx_end = data(end,1);

C02_T4_deltAnt = data((4:((idx_end-idx_start)+1)*20)+3,9);
C02_T4_deltMed = data((4:((idx_end-idx_start)+1)*20)+3,10);
C02_T4_trapSup = data((4:((idx_end-idx_start)+1)*20)+3,11);
C02_T4_trapMed = data((4:((idx_end-idx_start)+1)*20)+3,13);
C02_T4_trapInf = data((4:((idx_end-idx_start)+1)*20)+3,13);
C02_T4_serrAnt = data((4:((idx_end-idx_start)+1)*20)+3,14);
disp ('Task4, Condition2. Status Ok')

%%
data = readmatrix(target9);
idx_start = data(4,1);
idx_end = data(end,1);

C01_T5_deltAnt = data((4:((idx_end-idx_start)+1)*20)+3,9);
C01_T5_deltMed = data((4:((idx_end-idx_start)+1)*20)+3,10);
C01_T5_trapSup = data((4:((idx_end-idx_start)+1)*20)+3,11);
C01_T5_trapMed = data((4:((idx_end-idx_start)+1)*20)+3,13);
C01_T5_trapInf = data((4:((idx_end-idx_start)+1)*20)+3,13);
C01_T5_serrAnt = data((4:((idx_end-idx_start)+1)*20)+3,14);
disp ('Task5, Condition1. Status Ok')

%%
data = readmatrix(target10);
idx_start = data(4,1);
idx_end = data(end,1);

C02_T5_deltAnt = data((4:((idx_end-idx_start)+1)*20)+3,9);
C02_T5_deltMed = data((4:((idx_end-idx_start)+1)*20)+3,10);
C02_T5_trapSup = data((4:((idx_end-idx_start)+1)*20)+3,11);
C02_T5_trapMed = data((4:((idx_end-idx_start)+1)*20)+3,13);
C02_T5_trapInf = data((4:((idx_end-idx_start)+1)*20)+3,13);
C02_T5_serrAnt = data((4:((idx_end-idx_start)+1)*20)+3,14);
disp ('Task5, Condition2. Status Ok')

%%
data = readmatrix(target11);
idx_start = data(4,1);
idx_end = data(end,1);

C01_T6_deltAnt = data((4:((idx_end-idx_start)+1)*20)+3,9);
C01_T6_deltMed = data((4:((idx_end-idx_start)+1)*20)+3,10);
C01_T6_trapSup = data((4:((idx_end-idx_start)+1)*20)+3,11);
C01_T6_trapMed = data((4:((idx_end-idx_start)+1)*20)+3,13);
C01_T6_trapInf = data((4:((idx_end-idx_start)+1)*20)+3,13);
C01_T6_serrAnt = data((4:((idx_end-idx_start)+1)*20)+3,14);
disp ('Task6, Condition1. Status Ok')

%%
data = readmatrix(target12);
idx_start = data(4,1);
idx_end = data(end,1);

C02_T6_deltAnt = data((4:((idx_end-idx_start)+1)*20)+3,9);
C02_T6_deltMed = data((4:((idx_end-idx_start)+1)*20)+3,10);
C02_T6_trapSup = data((4:((idx_end-idx_start)+1)*20)+3,11);
C02_T6_trapMed = data((4:((idx_end-idx_start)+1)*20)+3,13);
C02_T6_trapInf = data((4:((idx_end-idx_start)+1)*20)+3,13);
C02_T6_serrAnt = data((4:((idx_end-idx_start)+1)*20)+3,14);
disp ('Task6, Condition2. Status Ok')

%%
disp('All done')