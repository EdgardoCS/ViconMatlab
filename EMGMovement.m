clc; clear;
%%
format short g

%load data for target subject, lets start with S03
load('C:\Users\VICON\MatlabProjects\data\S03.mat')

%using movement cues, cut data into several ROIs, applies for both planes
%of movement and emg data.

[frontal_musclesPre50, frontal_musclesPost50, frontal_musclesPre100, frontal_musclesPost100] = emgDataFrontal(SerratoPreFrontal,SerratoPostFrontal, TrapezioPreFrontal, TrapezioPostFrontal, framesPreFrontal, framesPostFrontal, Trials);

[scap_musclesPre50, scap_musclesPost50, scap_musclesPre100, scap_musclesPost100] = emgDataEscapular(SerratoPreEscapular,SerratoPostEscapular, TrapezioPreEscapular, TrapezioPostEscapular, framesPreEscapular, framesPostEscapular, Trials);

[movPre50, movPost50, movPre100, movPost100] = movementData(Frontal_Pre_ScapularTilt, Frontal_Post_ScapularTilt, Frontal_Pre_ScapularUpward, Frontal_Post_ScapularUpward, framesPreFrontal, framesPostFrontal, Trials);

clearvars -except frontal_musclesPre50 frontal_musclesPost50 frontal_musclesPre100 frontal_musclesPost100 scap_musclesPre50 scap_musclesPost50 scap_musclesPre100 scap_musclesPost100 movPre50 movPost50 movPre100 movPost100
%%
%calculate rom
[scapTiltRomPre50, scapTiltRomPre100, scapTiltRomPost50, scapTiltRomPost100, scapUpRomPre50, scapUpRomPre100, scapUpRomPost50, scapUpRomPost100] = romCalculation(movPre50, movPost50, movPre100, movPost100)
%%
%calculate rms (%frontal plane for now)
[serratoRmsPre50, serratoRmsPre100, serratoRmsPost50, serratoRmsPost100, trapezioRmsPre50, trapezioRmsPre100, trapezioRmsPost50, trapezioRmsPost100] = frontal_rmsCalculation(frontal_musclesPre50, frontal_musclesPost50, frontal_musclesPre100, frontal_musclesPost100)
%%

%%
%since movement is from frontal plane, lets plot movement and emg data of
%that plane
%{
%env = envelope(musclesPre50{1,1}, 2000, 'rms');

tiledlayout(2,2,'TileSpacing','Compact','Padding','Compact');
nexttile
plot(envelope(frontal_musclesPre50{1,1}, 2000, 'rms'), 'r')
hold on
plot(envelope(frontal_musclesPost50{1,1}, 2000, 'rms'),'k')
legend({'Pre','Post'},'Location','southwest')
title('Serratus Pre-Post Intervention - Target 50')

nexttile

plot(envelope(frontal_musclesPre50{1,2}, 2000, 'rms'), 'r')
hold on
plot(envelope(frontal_musclesPost50{1,2}, 2000, 'rms'), 'k')
legend({'Pre','Post'},'Location','southwest')
title('Trapezius Pre-Post Intervention - Target 50')

nexttile([1 2])
plot(movPre50{1,1}, 'r')
hold on
plot(movPost50{1,1}, 'k')

plot(movPre50{1,2}, 'r')
hold on
plot(movPost50{1,2}, 'k')

legend({'Pre Scapulat Tilt','Post Scapular Tilt', 'Pre Scapular Upward','Post Scapular Upward'},'Location','southwest')
title('Movement - Target 50')
%}

%%
function [a, b, c, d] = emgDataFrontal(SerratoPreFrontal,SerratoPostFrontal, TrapezioPreFrontal, TrapezioPostFrontal,framesPreFrontal, framesPostFrontal,  Trials)

a = {};
b = {};

c = {};
d = {};

for i = 1 : 10

    serratoPre = SerratoPreFrontal(:);
    serratoPost = SerratoPostFrontal(:);
    trapezioPre = TrapezioPreFrontal(:);
    trapezioPost = TrapezioPostFrontal(:);

    if Trials(i) == 50
        frontal_serratoPre50_ROI = serratoPre(framesPreFrontal(i,1)*20:framesPreFrontal(i,2)*20);
        frontal_serratoPost50_ROI = serratoPost(framesPostFrontal(i,1)*20:framesPostFrontal(i,2)*20);

        frontal_trapezioPre50_ROI = trapezioPre(framesPreFrontal(i,1)*20:framesPreFrontal(i,2)*20);
        frontal_trapezioPost50_ROI = trapezioPost(framesPostFrontal(i,1)*20:framesPostFrontal(i,2)*20);

        a = [a, frontal_serratoPre50_ROI, frontal_trapezioPre50_ROI];
        b = [b, frontal_serratoPost50_ROI, frontal_trapezioPost50_ROI];

    elseif Trials(i) == 100
        frontal_serratoPre100_ROI = serratoPre(framesPreFrontal(i,1)*20:framesPreFrontal(i,2)*20);
        frontal_serratoPost100_ROI = serratoPost(framesPostFrontal(i,1)*20:framesPostFrontal(i,2)*20);

        frontal_trapezioPre100_ROI = trapezioPre(framesPreFrontal(i,1)*20:framesPreFrontal(i,2)*20);
        frontal_trapezioPost100_ROI = trapezioPost(framesPostFrontal(i,1)*20:framesPostFrontal(i,2)*20);

        c = [c, frontal_serratoPre100_ROI, frontal_trapezioPre100_ROI];
        d = [d, frontal_serratoPost100_ROI, frontal_trapezioPost100_ROI];

    end
end
end

function [a, b, c, d] = emgDataEscapular(SerratoPreEscapular,SerratoPostEscapular, TrapezioPreEscapular, TrapezioPostEscapular,framesPreEscapular, framesPostEscapular,  Trials)

a = {};
b = {};

c = {};
d = {};

for i = 1 : 10

    serratoPre = SerratoPreEscapular(:);
    serratoPost = SerratoPostEscapular(:);
    trapezioPre = TrapezioPreEscapular(:);
    trapezioPost = TrapezioPostEscapular(:);

    if Trials(i) == 50
        escapular_serratoPre50_ROI = serratoPre(framesPreEscapular(i,1)*20:framesPreEscapular(i,2)*20);
        escapular_serratoPost50_ROI = serratoPost(framesPostEscapular(i,1)*20:framesPostEscapular(i,2)*20);
        escapular_trapezioPre50_ROI = trapezioPre(framesPreEscapular(i,1)*20:framesPreEscapular(i,2)*20);
        escapular_trapezioPost50_ROI = trapezioPost(framesPostEscapular(i,1)*20:framesPostEscapular(i,2)*20);

        a = [a, escapular_serratoPre50_ROI, escapular_trapezioPre50_ROI];
        b = [b, escapular_serratoPost50_ROI, escapular_trapezioPost50_ROI];

    elseif Trials(i) == 100
        escapular_serratoPre100_ROI = serratoPre(framesPreEscapular(i,1)*20:framesPreEscapular(i,2)*20);
        escapular_serratoPost100_ROI = serratoPost(framesPostEscapular(i,1)*20:framesPostEscapular(i,2)*20);
        escapular_trapezioPre100_ROI = trapezioPre(framesPreEscapular(i,1)*20:framesPreEscapular(i,2)*20);
        escapular_trapezioPost100_ROI = trapezioPost(framesPostEscapular(i,1)*20:framesPostEscapular(i,2)*20);

        c = [c, escapular_serratoPre100_ROI, escapular_trapezioPre100_ROI];
        d = [d, escapular_serratoPost100_ROI, escapular_trapezioPost100_ROI];

    end
end
end

function [movPre50, movPost50, movPre100, movPost100] = movementData(Frontal_Pre_ScapularTilt, Frontal_Post_ScapularTilt, Frontal_Pre_ScapularUpward, Frontal_Post_ScapularUpward, framesPreFrontal, framesPostFrontal, Trials)

movPre50 = {};
movPost50 = {};
movPre100 = {};
movPost100 = {};

for i=1:10
    if Trials(i) == 50
        data1Pre50= Frontal_Pre_ScapularTilt(framesPreFrontal(i,1):framesPreFrontal(i,2));
        data1Post50 = Frontal_Post_ScapularTilt(framesPostFrontal(i,1):framesPostFrontal(i,2));
        data2Pre50 = Frontal_Pre_ScapularUpward(framesPreFrontal(i,1):framesPreFrontal(i,2));
        data2Post50 = Frontal_Post_ScapularUpward(framesPostFrontal(i,1):framesPostFrontal(i,2));
        movPre50 = [movPre50, data1Pre50, data2Pre50]; %ScapTilt - ScapUp Pre 50
        movPost50 = [movPost50, data1Post50, data2Post50]; %ScapTilt - ScapUP Post 50
    else
        data1Pre100 = Frontal_Pre_ScapularTilt(framesPreFrontal(i,1):framesPreFrontal(i,2));
        data1Post100 = Frontal_Post_ScapularTilt(framesPostFrontal(i,1):framesPostFrontal(i,2));
        data2Pre100 = Frontal_Pre_ScapularUpward(framesPreFrontal(i,1):framesPreFrontal(i,2));
        data2Post100 = Frontal_Post_ScapularUpward(framesPostFrontal(i,1):framesPostFrontal(i,2));
        movPre100 = [movPre100, data1Pre100, data2Pre100]; %ScapTilt - ScapUp Pre 100
        movPost100 = [movPost100, data1Post100, data2Post100]; %ScapTilt - ScapUP Post 100
    end 
end
end
%%
function [scapTiltRomPre50, scapTiltRomPre100, scapTiltRomPost50, scapTiltRomPost100, scapUpRomPre50, scapUpRomPre100, scapUpRomPost50, scapUpRomPost100] = romCalculation(movPre50, movPost50, movPre100, movPost100)

temp1 = [];
temp2 = [];
temp3 = [];
temp4 = [];
temp5 = [];
temp6 = [];
temp7 = [];
temp8 = [];

for i = 1:2:10 % movement 1
    A = movPre50{:,i};
    B = movPre100{:,i};
    C = movPost50{:,i};
    D = movPost100{:,i};

    [startMov, index1] = min(A); 
    [endMov, index2] = max(A);
    temp1 = [temp1, endMov-startMov]; %ScapTilt Pre50
    [startMov, index1] = min(B);
    [endMov, index2] = max(B);
    temp2 = [temp2, endMov-startMov]; %ScapTilt Pre100
    [startMov, index1] = min(C);
    [endMov, index2] = max(C);
    temp3 = [temp3, endMov-startMov]; %ScapTilt Post50
    [startMov, index1] = min(D);
    [endMov, index2] = max(D);
    temp4 = [temp4, endMov-startMov]; %ScapTilt Post100
end

for i = 2:2:10 % movement 2
    A = movPre50{:,i};
    B = movPre100{:,i};
    C = movPost50{:,i};
    D = movPost100{:,i};

    [startMov, index1] = min(A);
    [endMov, index2] = max(A);
    temp5 = [temp5, endMov-startMov]; %ScapUp Pre50 
    [startMov, index1] = min(B);
    [endMov, index2] = max(B);
    temp6 = [temp6, endMov-startMov]; %ScapUp Pre100 
    [startMov, index1] = min(C);
    [endMov, index2] = max(C);
    temp7 = [temp7, endMov-startMov]; %ScapUp Post50 
    [startMov, index1] = min(D);
    [endMov, index2] = max(D);
    temp8 = [temp8, endMov-startMov]; %ScapUp Post100 
end
% mromPre50 = [mromPre50,mean(temp1)];
scapTiltRomPre50(:,:) = (temp1);
scapTiltRomPost50(:,:) = (temp3);
scapTiltRomPre100(:,:) = (temp2);
scapTiltRomPost100(:,:) = (temp4);

scapUpRomPre50(:,:) = (temp5);
scapUpRomPost50(:,:) = (temp6);
scapUpRomPre100(:,:) = (temp7);
scapUpRomPost100(:,:) = (temp8);

end

function [serratoRmsPre50, serratoRmsPre100, serratoRmsPost50, serratoRmsPost100, trapezioRmsPre50, trapezioRmsPre100, trapezioRmsPost50, trapezioRmsPost100] = frontal_rmsCalculation(frontal_musclesPre50, frontal_musclesPost50, frontal_musclesPre100, frontal_musclesPost100)
temp1 = [];
temp2 = [];
temp3 = [];
temp4 = [];
temp5 = [];
temp6 = [];
temp7 = [];
temp8 = [];

for i = 1:2:10
    A = frontal_musclesPre50{:,i};
    B = frontal_musclesPre100{:,i};
    C = frontal_musclesPost50{:,i};
    D = frontal_musclesPost100{:,i};
    temp1 = [temp1, rms(A)];
    temp2 = [temp2, rms(B)];
    temp3 = [temp3, rms(C)];
    temp4 = [temp4, rms(D)];
end
for i = 2:2:10
    A = frontal_musclesPre50{:,i};
    B = frontal_musclesPre100{:,i};
    C = frontal_musclesPost50{:,i};
    D = frontal_musclesPost100{:,i};
    temp5 = [temp5, rms(A)];
    temp6 = [temp6, rms(B)];
    temp7 = [temp7, rms(C)];
    temp8 = [temp8, rms(D)];
end
serratoRmsPre50 = temp1;
serratoRmsPre100 = temp2;
serratoRmsPost50 = temp3;
serratoRmsPost100 = temp4;

trapezioRmsPre50 = temp5;
trapezioRmsPre100 = temp6;
trapezioRmsPost50 = temp7;
trapezioRmsPost100 = temp8;
end
