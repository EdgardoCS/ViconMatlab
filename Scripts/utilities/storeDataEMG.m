%% EMG %%

%{
S23DinamicoPreFrontal(end,:) = [];
S23DinamicoPreEscapular(end,:) = [];
S23DinamicoPostFrontal(end,:) = [];
S23DinamicoPostEscapular(end,:) = [];
%}

%Serrato (1) Trapezio (2)

SerratoPreFrontal = table2array(S23DinamicoPreFrontal(:,1));
TrapezioPreFrontal = table2array(S23DinamicoPreFrontal(:,2));
SerratoPostFrontal = table2array(S23DinamicoPostFrontal(:,1));
TrapezioPostFrontal = table2array(S23DinamicoPostFrontal(:,2));

%%
% Escapular
SerratoPreEscapular = table2array(S23DinamicoPreEscapular(:,1));
TrapezioPreEscapular = table2array(S23DinamicoPreEscapular(:,2));
SerratoPostEscapular = table2array(S23DinamicoPostEscapular(:,1));
TrapezioPostEscapular = table2array(S23DinamicoPostEscapular(:,2));