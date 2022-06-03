%% Escapular %%
% Plano Sagital ZXY (X=Columna84)
%HumSca = HumeroScapular (Sagital)
S14_PostHumSca = table2array(S14DinamicoPostEscapular(:,84));
S14_PreHumSca = table2array(S14DinamicoPreEscapular(:,84));

%% Frontal %%
% Plano Frontal XYZ (X=Columna78)
% Scapulothoracic (Y=Columna109, Z=Columna110)

%HumFro = HumeroFrontal 
%ScapUp = UpwardRotation Scapula
%ScapTi = PosteriorTilr Scapula
S14_PreHumFro = table2array(S14DinamicoPreFrontal(:,78));
S14_PostHumFro = table2array(S14DinamicoPostFrontal(:,78));
S14_PreScapUp = table2array(S14DinamicoPreFrontal(:,109));
S14_PreScapTi = table2array(S14DinamicoPreFrontal(:,110));
S14_PostScapUp = table2array(S14DinamicoPostFrontal(:,109));
S14_PostScapTi = table2array(S14DinamicoPostFrontal(:,110));