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

% subject = "02";
% condition = "01";
% task = "Escritura";
% 
% target = ["D:\Vicon Database\Tesis_Escritorio\Experiment\Subject",subject,"\",task,condition,".csv"];
% location = join(target,"");


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





