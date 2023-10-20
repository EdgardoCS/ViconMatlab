% Created by E.Silva
% Modified by E.Silva 02/08/23


%{
Escritura
Lectura
Digitacion
FittsPc
FittsTablet
Manipulacion
%}

%{
Elbow
Shoulder
Wrist
%}

clc; clear; 

% subjects = ["Subject01","Subject02","Subject03","Subject04","Subject05","Subject06",...
% "Subject07","Subject08","Subject09","Subject10","Subject11","Subject12","Subject13",...
% "Subject14","Subject15","Subject16","Subject17","Subject18","Subject19","Subject20",...
% "Subject21","Subject22","Subject23","Subject24","Subject25","Subject26","Subject27",...
% "Subject28","Subject29","Subject30","Subject31","Subject32","Subject33","Subject34",...
% ];

 subjects = [
 "Subject21","Subject22","Subject23","Subject24","Subject25","Subject26","Subject27",...
 "Subject28","Subject29","Subject30","Subject31","Subject32","Subject33","Subject34",...
 ];

for i=1:length(subjects)
    targetSubject = subjects(i);

    clearvars -except subjects targetSubject;
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

    %%
    data = readmatrix(target1);
    idx_start = data(4,1);
    idx_end = data(end,1);

    modelstart = (((idx_end-idx_start)+2)*20)-2;
    modelend = modelstart+idx_end-idx_start;

    C01_T1_Elbow(:,1) = data(modelstart-9:modelend-9,6); %x Column 6 (F)
    C01_T1_Elbow(:,2) = data(modelstart-9:modelend-9,7); %y Column 7 (G)
    C01_T1_Elbow(:,3) = data(modelstart-9:modelend-9,8); %z Column 8 (H)

    C01_T1_Shoulder(:,1) = data(modelstart-9:modelend-9,12); %x Column 12 (L)
    C01_T1_Shoulder(:,2) = data(modelstart-9:modelend-9,13); %y Column 13 (M)
    C01_T1_Shoulder(:,3) = data(modelstart-9:modelend-9,14); %z Column 14 (N)

    C01_T1_Wrist(:,1) = data(modelstart-9:modelend-9,20); %x Column 20 (U)
    C01_T1_Wrist(:,2) = data(modelstart-9:modelend-9,21); %y Column 21 (V)
    C01_T1_Wrist(:,3) = data(modelstart-9:modelend-9,22); %z Column 22 (W)

    %%
    data = readmatrix(target2);
    idx_start = data(4,1);
    idx_end = data(end,1);

    modelstart = (((idx_end-idx_start)+2)*20)-2;
    modelend = modelstart+idx_end-idx_start;

    C02_T1_Elbow(:,1) = data(modelstart-9:modelend-9,6); %x Column 6 (F)
    C02_T1_Elbow(:,2) = data(modelstart-9:modelend-9,7); %y Column 7 (G)
    C02_T1_Elbow(:,3) = data(modelstart-9:modelend-9,8); %z Column 8 (H)

    C02_T1_Shoulder(:,1) = data(modelstart-9:modelend-9,12); %x Column 12 (L)
    C02_T1_Shoulder(:,2) = data(modelstart-9:modelend-9,13); %y Column 13 (M)
    C02_T1_Shoulder(:,3) = data(modelstart-9:modelend-9,14); %z Column 14 (N)

    C02_T1_Wrist(:,1) = data(modelstart-9:modelend-9,21); %x Column 20 (U)
    C02_T1_Wrist(:,2) = data(modelstart-9:modelend-9,22); %y Column 21 (V)
    C02_T1_Wrist(:,3) = data(modelstart-9:modelend-9,23); %z Column 22 (W)

    %%
    data = readmatrix(target3);
    idx_start = data(4,1);
    idx_end = data(end,1);

    modelstart = (((idx_end-idx_start)+2)*20)-2;
    modelend = modelstart+idx_end-idx_start;

    C01_T2_Elbow(:,1) = data(modelstart-9:modelend-9,6); %x Column 6 (F)
    C01_T2_Elbow(:,2) = data(modelstart-9:modelend-9,7); %y Column 7 (G)
    C01_T2_Elbow(:,3) = data(modelstart-9:modelend-9,8); %z Column 8 (H)

    C01_T2_Shoulder(:,1) = data(modelstart-9:modelend-9,12); %x Column 12 (L)
    C01_T2_Shoulder(:,2) = data(modelstart-9:modelend-9,13); %y Column 13 (M)
    C01_T2_Shoulder(:,3) = data(modelstart-9:modelend-9,14); %z Column 14 (N)

    C01_T2_Wrist(:,1) = data(modelstart-9:modelend-9,20); %x Column 20 (U)
    C01_T2_Wrist(:,2) = data(modelstart-9:modelend-9,21); %y Column 21 (V)
    C01_T2_Wrist(:,3) = data(modelstart-9:modelend-9,22); %z Column 22 (W)

    %%
    data = readmatrix(target4);
    idx_start = data(4,1);
    idx_end = data(end,1);

    modelstart = (((idx_end-idx_start)+2)*20)-2;
    modelend = modelstart+idx_end-idx_start;

    C02_T2_Elbow(:,1) = data(modelstart-9:modelend-9,6); %x Column 6 (F)
    C02_T2_Elbow(:,2) = data(modelstart-9:modelend-9,7); %y Column 7 (G)
    C02_T2_Elbow(:,3) = data(modelstart-9:modelend-9,8); %z Column 8 (H)

    C02_T2_Shoulder(:,1) = data(modelstart-9:modelend-9,12); %x Column 12 (L)
    C02_T2_Shoulder(:,2) = data(modelstart-9:modelend-9,13); %y Column 13 (M)
    C02_T2_Shoulder(:,3) = data(modelstart-9:modelend-9,14); %z Column 14 (N)

    C02_T2_Wrist(:,1) = data(modelstart-9:modelend-9,20); %x Column 20 (U)
    C02_T2_Wrist(:,2) = data(modelstart-9:modelend-9,21); %y Column 21 (V)
    C02_T2_Wrist(:,3) = data(modelstart-9:modelend-9,22); %z Column 22 (W)

    %%
    data = readmatrix(target5);
    idx_start = data(4,1);
    idx_end = data(end,1);

    modelstart = (((idx_end-idx_start)+2)*20)-2;
    modelend = modelstart+idx_end-idx_start;

    C01_T3_Elbow(:,1) = data(modelstart-9:modelend-9,6); %x Column 6 (F)
    C01_T3_Elbow(:,2) = data(modelstart-9:modelend-9,7); %y Column 7 (G)
    C01_T3_Elbow(:,3) = data(modelstart-9:modelend-9,8); %z Column 8 (H)

    C01_T3_Shoulder(:,1) = data(modelstart-9:modelend-9,12); %x Column 12 (L)
    C01_T3_Shoulder(:,2) = data(modelstart-9:modelend-9,13); %y Column 13 (M)
    C01_T3_Shoulder(:,3) = data(modelstart-9:modelend-9,14); %z Column 14 (N)

    C01_T3_Wrist(:,1) = data(modelstart-9:modelend-9,20); %x Column 20 (U)
    C01_T3_Wrist(:,2) = data(modelstart-9:modelend-9,21); %y Column 21 (V)
    C01_T3_Wrist(:,3) = data(modelstart-9:modelend-9,22); %z Column 22 (W)

    %%
    data = readmatrix(target6);
    idx_start = data(4,1);
    idx_end = data(end,1);

    modelstart = (((idx_end-idx_start)+2)*20)-2;
    modelend = modelstart+idx_end-idx_start;

    C02_T3_Elbow(:,1) = data(modelstart-9:modelend-9,6); %x Column 6 (F)
    C02_T3_Elbow(:,2) = data(modelstart-9:modelend-9,7); %y Column 7 (G)
    C02_T3_Elbow(:,3) = data(modelstart-9:modelend-9,8); %z Column 8 (H)

    C02_T3_Shoulder(:,1) = data(modelstart-9:modelend-9,12); %x Column 12 (L)
    C02_T3_Shoulder(:,2) = data(modelstart-9:modelend-9,13); %y Column 13 (M)
    C02_T3_Shoulder(:,3) = data(modelstart-9:modelend-9,14); %z Column 14 (N)

    C02_T3_Wrist(:,1) = data(modelstart-9:modelend-9,20); %x Column 20 (U)
    C02_T3_Wrist(:,2) = data(modelstart-9:modelend-9,21); %y Column 21 (V)
    C02_T3_Wrist(:,3) = data(modelstart-9:modelend-9,22); %z Column 22 (W)

    %%
    data = readmatrix(target7);
    idx_start = data(4,1);
    idx_end = data(end,1);

    modelstart = (((idx_end-idx_start)+2)*20)-2;
    modelend = modelstart+idx_end-idx_start;

    C01_T4_Elbow(:,1) = data(modelstart-9:modelend-9,6); %x Column 6 (F)
    C01_T4_Elbow(:,2) = data(modelstart-9:modelend-9,7); %y Column 7 (G)
    C01_T4_Elbow(:,3) = data(modelstart-9:modelend-9,8); %z Column 8 (H)

    C01_T4_Shoulder(:,1) = data(modelstart-9:modelend-9,12); %x Column 12 (L)
    C01_T4_Shoulder(:,2) = data(modelstart-9:modelend-9,13); %y Column 13 (M)
    C01_T4_Shoulder(:,3) = data(modelstart-9:modelend-9,14); %z Column 14 (N)

    C01_T4_Wrist(:,1) = data(modelstart-9:modelend-9,20); %x Column 20 (U)
    C01_T4_Wrist(:,2) = data(modelstart-9:modelend-9,21); %y Column 21 (V)
    C01_T4_Wrist(:,3) = data(modelstart-9:modelend-9,22); %z Column 22 (W)

    %%
    data = readmatrix(target8);
    idx_start = data(4,1);
    idx_end = data(end,1);

    modelstart = (((idx_end-idx_start)+2)*20)-2;
    modelend = modelstart+idx_end-idx_start;

    C02_T4_Elbow(:,1) = data(modelstart-9:modelend-9,6); %x Column 6 (F)
    C02_T4_Elbow(:,2) = data(modelstart-9:modelend-9,7); %y Column 7 (G)
    C02_T4_Elbow(:,3) = data(modelstart-9:modelend-9,8); %z Column 8 (H)

    C02_T4_Shoulder(:,1) = data(modelstart-9:modelend-9,12); %x Column 12 (L)
    C02_T4_Shoulder(:,2) = data(modelstart-9:modelend-9,13); %y Column 13 (M)
    C02_T4_Shoulder(:,3) = data(modelstart-9:modelend-9,14); %z Column 14 (N)

    C02_T4_Wrist(:,1) = data(modelstart-9:modelend-9,20); %x Column 20 (U)
    C02_T4_Wrist(:,2) = data(modelstart-9:modelend-9,21); %y Column 21 (V)
    C02_T4_Wrist(:,3) = data(modelstart-9:modelend-9,22); %z Column 22 (W)

    %%
    data = readmatrix(target9);
    idx_start = data(4,1);
    idx_end = data(end,1);

    modelstart = (((idx_end-idx_start)+2)*20)-2;
    modelend = modelstart+idx_end-idx_start;

    C01_T5_Elbow(:,1) = data(modelstart-9:modelend-9,6); %x Column 6 (F)
    C01_T5_Elbow(:,2) = data(modelstart-9:modelend-9,7); %y Column 7 (G)
    C01_T5_Elbow(:,3) = data(modelstart-9:modelend-9,8); %z Column 8 (H)

    C01_T5_Shoulder(:,1) = data(modelstart-9:modelend-9,12); %x Column 12 (L)
    C01_T5_Shoulder(:,2) = data(modelstart-9:modelend-9,13); %y Column 13 (M)
    C01_T5_Shoulder(:,3) = data(modelstart-9:modelend-9,14); %z Column 14 (N)

    C01_T5_Wrist(:,1) = data(modelstart-9:modelend-9,20); %x Column 20 (U)
    C01_T5_Wrist(:,2) = data(modelstart-9:modelend-9,21); %y Column 21 (V)
    C01_T5_Wrist(:,3) = data(modelstart-9:modelend-9,22); %z Column 22 (W)

    %%
    data = readmatrix(target10);
    idx_start = data(4,1);
    idx_end = data(end,1);

    modelstart = (((idx_end-idx_start)+2)*20)-2;
    modelend = modelstart+idx_end-idx_start;

    C02_T5_Elbow(:,1) = data(modelstart-9:modelend-9,6); %x Column 6 (F)
    C02_T5_Elbow(:,2) = data(modelstart-9:modelend-9,7); %y Column 7 (G)
    C02_T5_Elbow(:,3) = data(modelstart-9:modelend-9,8); %z Column 8 (H)

    C02_T5_Shoulder(:,1) = data(modelstart-9:modelend-9,12); %x Column 12 (L)
    C02_T5_Shoulder(:,2) = data(modelstart-9:modelend-9,13); %y Column 13 (M)
    C02_T5_Shoulder(:,3) = data(modelstart-9:modelend-9,14); %z Column 14 (N)

    C02_T5_Wrist(:,1) = data(modelstart-9:modelend-9,20); %x Column 20 (U)
    C02_T5_Wrist(:,2) = data(modelstart-9:modelend-9,21); %y Column 21 (V)
    C02_T5_Wrist(:,3) = data(modelstart-9:modelend-9,22); %z Column 22 (W)

    %%
    data = readmatrix(target11);
    idx_start = data(4,1);
    idx_end = data(end,1);

    modelstart = (((idx_end-idx_start)+2)*20)-2;
    modelend = modelstart+idx_end-idx_start;

    C01_T6_Elbow(:,1) = data(modelstart-9:modelend-9,6); %x Column 6 (F)
    C01_T6_Elbow(:,2) = data(modelstart-9:modelend-9,7); %y Column 7 (G)
    C01_T6_Elbow(:,3) = data(modelstart-9:modelend-9,8); %z Column 8 (H)

    C01_T6_Shoulder(:,1) = data(modelstart-9:modelend-9,12); %x Column 12 (L)
    C01_T6_Shoulder(:,2) = data(modelstart-9:modelend-9,13); %y Column 13 (M)
    C01_T6_Shoulder(:,3) = data(modelstart-9:modelend-9,14); %z Column 14 (N)

    C01_T6_Wrist(:,1) = data(modelstart-9:modelend-9,20); %x Column 20 (U)
    C01_T6_Wrist(:,2) = data(modelstart-9:modelend-9,21); %y Column 21 (V)
    C01_T6_Wrist(:,3) = data(modelstart-9:modelend-9,22); %z Column 22 (W)

    %%
    data = readmatrix(target12);
    idx_start = data(4,1);
    idx_end = data(end,1);

    modelstart = (((idx_end-idx_start)+2)*20)-2;
    modelend = modelstart+idx_end-idx_start;

    C02_T6_Elbow(:,1) = data(modelstart-9:modelend-9,6); %x Column 6 (F)
    C02_T6_Elbow(:,2) = data(modelstart-9:modelend-9,7); %y Column 7 (G)
    C02_T6_Elbow(:,3) = data(modelstart-9:modelend-9,8); %z Column 8 (H)

    C02_T6_Shoulder(:,1) = data(modelstart-9:modelend-9,12); %x Column 12 (L)
    C02_T6_Shoulder(:,2) = data(modelstart-9:modelend-9,13); %y Column 13 (M)
    C02_T6_Shoulder(:,3) = data(modelstart-9:modelend-9,14); %z Column 14 (N)

    C02_T6_Wrist(:,1) = data(modelstart-9:modelend-9,20); %x Column 20 (U)
    C02_T6_Wrist(:,2) = data(modelstart-9:modelend-9,21); %y Column 21 (V)
    C02_T6_Wrist(:,3) = data(modelstart-9:modelend-9,22); %z Column 22 (W)

    %%

    C = strsplit(targetSubject,'t');
    targetFile = join(["S",C(2),".mat"],"");

    disp(join(['saving data...',targetFile],""))

    save(targetFile,"C01_T1_Elbow","C01_T1_Shoulder","C01_T1_Wrist","C01_T2_Elbow","C01_T2_Shoulder","C01_T2_Wrist","C01_T3_Elbow","C01_T3_Shoulder","C01_T3_Wrist","C01_T4_Elbow","C01_T4_Shoulder","C01_T4_Wrist","C01_T5_Elbow","C01_T5_Shoulder","C01_T5_Wrist","C01_T6_Elbow","C01_T6_Shoulder","C01_T6_Wrist","C02_T1_Elbow","C02_T1_Shoulder","C02_T1_Wrist","C02_T2_Elbow","C02_T2_Shoulder","C02_T2_Wrist","C02_T3_Elbow","C02_T3_Shoulder","C02_T3_Wrist","C02_T4_Elbow","C02_T4_Shoulder","C02_T4_Wrist","C02_T5_Elbow","C02_T5_Shoulder","C02_T5_Wrist","C02_T6_Elbow","C02_T6_Shoulder","C02_T6_Wrist")

end

disp ('All Done')

%%
%C01_T1_Elbow = data(modelstart:((idx_end*20)+4+9)+idx_end+1,6);
%C01_T1_deltAnt = data(4:(((idx_end-idx_start)+1)*20)+3,9);

% subject = "02";
% condition = "01";
% task = "Escritura";
%
% target = ["D:\Vicon Database\Tesis_Escritorio\Experiment\Subject",subject,"\",task,condition,".csv"];
% location = join(target,"");

%{
location = "D:\Vicon Database\Tesis_Escritorio\Experiment\Subject10\Manipulacion02.csv";

startFrame = 459598;
endFrame =  482576;

C02_T6_Elbow = extractData1(location, startFrame, endFrame);
C02_T6_Shoulder = extractData2(location, startFrame, endFrame);
C02_T6_Wrist = extractData3(location, startFrame, endFrame);

clear endFrame location startFrame Condition Subject target Task

function [data] = extractData1(location, startFrame, endFrame)

% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 23);

% Specify range and delimiter
opts.DataLines = [startFrame, endFrame];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Var1", "Var2", "Var3", "Var4", "Var5", "X1", "Y1", "Z1", "Var9", "Var10", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17", "Var18", "Var19", "Var20", "Var21", "Var22", "Var23"];
opts.SelectedVariableNames = ["X1", "Y1", "Z1"];
opts.VariableTypes = ["string", "string", "string", "string", "string", "double", "double", "double", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string","string","string","string","string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var9", "Var10", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17", "Var18","Var19","Var20","Var21","Var22","Var23"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var9", "Var10", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17", "Var18","Var19","Var20","Var21","Var22","Var23"], "EmptyFieldRule", "auto");

% Import the data
data = readtable(location, opts);

% Clear temporary variables
clear opts

end

function [data] = extractData2(location, startFrame, endFrame)

% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 23);

% Specify range and delimiter
opts.DataLines = [startFrame, endFrame];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "Var10", "Var11", "X3", "Y3", "Z3", "Var15", "Var16", "Var17", "Var18", "Var19", "Var20", "Var21", "Var22", "Var23"];
opts.SelectedVariableNames = ["X3", "Y3", "Z3"];
opts.VariableTypes = ["string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "double", "double", "double", "string", "string", "string", "string", "string","string","string","string","string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "Var10", "Var11", "Var15", "Var16", "Var17", "Var18","Var19","Var20","Var21","Var22","Var23"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "Var10", "Var11", "Var15", "Var16", "Var17", "Var18","Var19","Var20","Var21","Var22","Var23"], "EmptyFieldRule", "auto");

% Import the data
data = readtable(location, opts);

% Clear temporary variables
clear opts

end

function [data] = extractData3(location, startFrame, endFrame)

% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 23);

% Specify range and delimiter
opts.DataLines = [startFrame, endFrame];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "Var10", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17", "Var18", "Var19", "Var20", "X6", "Y6", "Z6"];
opts.SelectedVariableNames = ["X6", "Y6", "Z6"];
opts.VariableTypes = ["string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "Var10", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17", "Var18", "Var19", "Var20"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "Var10", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17", "Var18", "Var19", "Var20"], "EmptyFieldRule", "auto");

% Import the data
data = readtable(location, opts);

% Clear temporary variables
clear opts

end

%}