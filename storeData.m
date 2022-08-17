
% The following will take the data from previously loaded csv data, which
% contains all model outputs from Vicon Software pipeline process, and
% store the desire sections into the target subject data file (.m). Data
% collected belongs to both Sagital and Frontal planes according to the
% experimental design. Each column of interest is describe accordingly.
% Written by Edgardo Silva, 25/05/2022

% clear workspace and command window just in case
clear; clc;

%% Sagital

% Sagital Plane ZXY (X=Column 84) Scapulothoracic Plane  (Y=Column 109,
% Z=Column 110)
load('C:\Users\VICON\MatlabProjects\data\S01.mat') %target data file

Sagital_Pre_HumeroScapular = table2array(S8DinamicoPreEscapular(:,84));
Sagital_Post_HumeroScapular = table2array(S8DinamicoPostEscapular(:,84));

Sagital_Pre_ScapularUpward = table2array(S8DinamicoPreEscapular(:,109));
Sagital_Post_ScapularUpward = table2array(S8DinamicoPostEscapular(:,109));

Sagital_Pre_ScapularTilt = table2array(S8DinamicoPreEscapular(:,110));
Sagital_Post_ScapularTilt = table2array(S8DinamicoPostEscapular(:,110));


%% Frontal

% Frontal Plane XYZ (X=Column 78) Scapulothoracic Plane (Y=Column 109,
% Z=Column 110)

Frontal_Pre_HumeroFrontal = table2array(S8DinamicoPreFrontal(:,78));
Frontal_Post_HumeroFrontal = table2array(S8DinamicoPostFrontal(:,78));

Frontal_Pre_ScapularUpward = table2array(S8DinamicoPreFrontal(:,109));
Frontal_Post_ScapularUpward = table2array(S8DinamicoPostFrontal(:,109));

Frontal_Pre_ScapularTilt = table2array(S8DinamicoPreFrontal(:,110));
Frontal_Post_ScapularTilt = table2array(S8DinamicoPostFrontal(:,110));

save 'C:\Users\VICON\MatlabProjects\data\S01.mat'...
    'Sagital_Pre_HumeroScapular' 'Sagital_Post_HumeroScapular'...
    'Sagital_Pre_ScapularUpward' 'Sagital_Post_ScapularUpward'...
    'Sagital_Pre_ScapularTilt' 'Sagital_Post_ScapularTilt'...
    'Frontal_Pre_HumeroFrontal' 'Frontal_Post_HumeroFrontal'...
    'Frontal_Pre_ScapularUpward' 'Frontal_Post_ScapularUpward'...
    'Frontal_Pre_ScapularTilt' 'Frontal_Post_ScapularTilt'...
    '-append';

disp(' Done ')