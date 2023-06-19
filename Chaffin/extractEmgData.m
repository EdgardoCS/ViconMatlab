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


location = "D:\Vicon Database\Tesis_Escritorio\Experiment\Subject01\Manipulacion02.csv";
startFrame = 12;
endFrame = 365831;

temp  = extractDataEmg(location, startFrame, endFrame);

C02_T6_deltAnt = temp(:,6);
C02_T6_deltMed = temp(:,5);
C02_T6_trapSup = temp(:,4);
C02_T6_trapMed = temp(:,3);
C02_T6_trapInf = temp(:,2);
C02_T6_serrAnt = temp(:,1);

clear endFrame location startFrame temp


function [data] = extractDataEmg(location, startFrame, endFrame)

opts = delimitedTextImportOptions("NumVariables", 18);

% Specify range and delimiter
opts.DataLines = [startFrame, endFrame];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "IMEMG7", "IMEMG8", "IMEMG9", "IMEMG10", "IMEMG11", "IMEMG12", "Var15", "Var16", "Var17", "Var18"];
opts.SelectedVariableNames = ["IMEMG7", "IMEMG8", "IMEMG9", "IMEMG10", "IMEMG11", "IMEMG12"];
opts.VariableTypes = ["string", "string", "string", "string", "string", "string", "string", "string", "double", "double", "double", "double", "double", "double", "string", "string", "string", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var15", "Var16", "Var17", "Var18"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var15", "Var16", "Var17", "Var18"], "EmptyFieldRule", "auto");

% Import the data
data = readtable(location, opts);

end