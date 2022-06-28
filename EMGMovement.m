clc; clear;
%%
load('C:\Users\VICON\MatlabProjects\data\S03.mat')

[musclesPre50, musclesPost50, musclesPre100, musclesPost100] = emgDataFrontal(SerratoPreFrontal,SerratoPostFrontal, TrapezioPreFrontal, TrapezioPostFrontal, framesPreFrontal, framesPreEscapular, framesPostFrontal, framesPostEscapular, Trials);
[mov1Pre50, mov1Post50, mov2Pre100, mov2Post100] = movementData(Frontal_Pre_ScapularTilt, Frontal_Post_ScapularTilt, Frontal_Pre_ScapularUpward, Frontal_Post_ScapularUpward, framesPreFrontal, framesPostFrontal, Trials);

clearvars -except musclesPre50 musclesPost50 musclesPre100 musclesPost100 mov1Pre50 mov1Post50 mov2Pre100 mov2Post100

%env = envelope(musclesPre50{1,1}, 2000, 'rms');

tiledlayout(2,2,'TileSpacing','Compact','Padding','Compact');
nexttile
plot(envelope(musclesPre50{1,1}, 2000, 'rms'), 'r')
hold on
plot(envelope(musclesPost50{1,1}, 2000, 'rms'),'k')
legend({'Pre','Post'},'Location','southwest')
title('Serratus Post Intervention - Target 50')

nexttile

plot(envelope(musclesPre50{1,3}, 2000, 'rms'), 'r')
hold on
plot(envelope(musclesPost50{1,3}, 2000, 'rms'), 'k')
legend({'Pre','Post'},'Location','southwest')
title('Trapezius Post Intervention - Target 50')

nexttile([1 2])
plot(mov1Pre50{1,1}, 'r')
hold on
plot(mov1Post50{1,1}, 'k')

plot(mov1Pre50{1,2}, 'r')
hold on
plot(mov1Post50{1,2}, 'k')

legend({'Pre Scapulat Tilt','Post Scapular Tilt', 'Pre Scapular Upward','Post Scapular Upward'},'Location','southwest')
title('Movement - Target 50')

%{
tiledlayout(2,2,'TileSpacing','Compact','Padding','Compact');
nexttile
plot(musclesPre50{1,1})
hold on
plot(musclesPre50{1,3})
legend({'Serrato','Trapezio'},'Location','southwest')
title('Muscles Pre Intervention - Target 50')

nexttile
plot(musclesPost50{1,1})
hold on
plot(musclesPost50{1,3})
legend({'Serrato','Trapezio'},'Location','southwest')
title('Muscles Post Intervention - Target 50')

nexttile
plot(mov1Pre50{1,1}, 'r')
hold on
plot(mov1Pre50{1,2}, 'k')
legend({'Scapular Tilt','Scapular Upward'},'Location','southwest')
title('Movement Pre Intervention - Target 50')

nexttile
plot(mov1Post50{1,1}, 'r')
hold on
plot(mov1Post50{1,2}, 'k')
legend({'Scapular Tilt','Scapular Upward'},'Location','southwest')
title('Movement Post Intervention - Target 50')
%}

function [a, b, c, d] = emgDataFrontal(SerratoPreFrontal,SerratoPostFrontal, TrapezioPreFrontal, TrapezioPostFrontal,framesPreFrontal, framesPreEscapular, framesPostFrontal, framesPostEscapular,  Trials)

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
        escapular_serratoPre50_ROI = serratoPre(framesPreEscapular(i,1)*20:framesPreEscapular(i,2)*20);
        escapular_serratoPost50_ROI = serratoPost(framesPostEscapular(i,1)*20:framesPostEscapular(i,2)*20);
        
        frontal_trapezioPre50_ROI = trapezioPre(framesPreFrontal(i,1)*20:framesPreFrontal(i,2)*20);
        frontal_trapezioPost50_ROI = trapezioPost(framesPostFrontal(i,1)*20:framesPostFrontal(i,2)*20);
        escapular_trapezioPre50_ROI = trapezioPre(framesPreEscapular(i,1)*20:framesPreEscapular(i,2)*20);
        escapular_trapezioPost50_ROI = trapezioPost(framesPostEscapular(i,1)*20:framesPostEscapular(i,2)*20);

        a = [a, frontal_serratoPre50_ROI, escapular_serratoPre50_ROI, frontal_trapezioPre50_ROI, escapular_trapezioPre50_ROI];
        b = [b, frontal_serratoPost50_ROI, escapular_serratoPost50_ROI, frontal_trapezioPost50_ROI, escapular_trapezioPost50_ROI];

    elseif Trials(i) == 100
        frontal_serratoPre100_ROI = serratoPre(framesPreFrontal(i,1)*20:framesPreFrontal(i,2)*20);
        frontal_serratoPost100_ROI = serratoPost(framesPostFrontal(i,1)*20:framesPostFrontal(i,2)*20);
        escapular_serratoPre100_ROI = serratoPre(framesPreEscapular(i,1)*20:framesPreEscapular(i,2)*20);
        escapular_serratoPost100_ROI = serratoPost(framesPostEscapular(i,1)*20:framesPostEscapular(i,2)*20);

        frontal_trapezioPre100_ROI = trapezioPre(framesPreFrontal(i,1)*20:framesPreFrontal(i,2)*20);
        frontal_trapezioPost100_ROI = trapezioPost(framesPostFrontal(i,1)*20:framesPostFrontal(i,2)*20);
        escapular_trapezioPre100_ROI = trapezioPre(framesPreEscapular(i,1)*20:framesPreEscapular(i,2)*20);
        escapular_trapezioPost100_ROI = trapezioPost(framesPostEscapular(i,1)*20:framesPostEscapular(i,2)*20);

        c = [c, frontal_serratoPre100_ROI, escapular_serratoPre100_ROI, frontal_trapezioPre100_ROI,escapular_trapezioPre100_ROI];
        d = [d, frontal_serratoPost100_ROI, escapular_serratoPost100_ROI, frontal_trapezioPost100_ROI,escapular_trapezioPost100_ROI];

    end
end
end

function [a, b, c, d] = movementData(Frontal_Pre_ScapularTilt, Frontal_Post_ScapularTilt, Frontal_Pre_ScapularUpward, Frontal_Post_ScapularUpward, framesPreFrontal, framesPostFrontal, Trials)

a = {};
b = {};
c = {};
d = {};

for i=1:10
    if Trials(i) == 50
        data1Pre50= Frontal_Pre_ScapularTilt(framesPreFrontal(i,1):framesPreFrontal(i,2));
        data1Post50 = Frontal_Post_ScapularTilt(framesPostFrontal(i,1):framesPostFrontal(i,2));
        data2Pre50 = Frontal_Pre_ScapularUpward(framesPreFrontal(i,1):framesPreFrontal(i,2));
        data2Post50 = Frontal_Post_ScapularUpward(framesPostFrontal(i,1):framesPostFrontal(i,2));
        a = [a, data1Pre50, data2Pre50];
        b = [b, data1Post50, data2Post50];
    else
        data1Pre100 = Frontal_Pre_ScapularTilt(framesPreFrontal(i,1):framesPreFrontal(i,2));
        data1Post100 = Frontal_Post_ScapularTilt(framesPostFrontal(i,1):framesPostFrontal(i,2));
        data2Pre100 = Frontal_Pre_ScapularUpward(framesPreFrontal(i,1):framesPreFrontal(i,2));
        data2Post100 = Frontal_Post_ScapularUpward(framesPostFrontal(i,1):framesPostFrontal(i,2));
        c = [c, data1Pre100, data2Pre100];
        d = [d, data1Post100, data2Post100];
    end
end
end