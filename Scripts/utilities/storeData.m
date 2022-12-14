%% Escapular 
% Plano Sagital ZXY (X=Columna84)
% Scapulothoracic  (Y=Columna109, Z=Columna110)

Escapular_Pre_HumeroScapular = table2array(S23DinamicoPreEscapular(:,84));
Escapular_Post_HumeroScapular = table2array(S23DinamicoPostEscapular(:,84));

Escapular_Pre_ScapularUpward = table2array(S23DinamicoPreEscapular(:,109));
Escapular_Post_ScapularUpward = table2array(S23DinamicoPostEscapular(:,109));

Escapular_Pre_ScapularTilt = table2array(S23DinamicoPreEscapular(:,110));
Escapular_Post_ScapularTilt = table2array(S23DinamicoPostEscapular(:,110));


%% Frontal 
% Plano Frontal XYZ (X=Columna78)
% Scapulothoracic (Y=Columna109, Z=Columna110)

Frontal_Pre_HumeroFrontal = table2array(S23DinamicoPreFrontal(:,78));
Frontal_Post_HumeroFrontal = table2array(S23DinamicoPostFrontal(:,78));

Frontal_Pre_ScapularUpward = table2array(S23DinamicoPreFrontal(:,109));
Frontal_Post_ScapularUpward = table2array(S23DinamicoPostFrontal(:,109));

Frontal_Pre_ScapularTilt = table2array(S23DinamicoPreFrontal(:,110));
Frontal_Post_ScapularTilt = table2array(S23DinamicoPostFrontal(:,110));


