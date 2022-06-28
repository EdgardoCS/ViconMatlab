% Extract time region of interest from signals
clc; clear;
% Generated by MATLAB(R) 9.12 and Signal Processing Toolbox 9.0.
% Generated on: 16-Jun-2022 11:13:11

load('C:\Users\VICON\MatlabProjects\data\S21.mat', 'SerratoPostEscapular', 'SerratoPostFrontal', 'SerratoPreEscapular', 'SerratoPreFrontal', 'TrapezioPostEscapular', 'TrapezioPostFrontal', 'TrapezioPreEscapular', 'TrapezioPreFrontal')

%%
try
    timeLimits = [7000 240000];
    SerratoPostEscapular_ROI = SerratoPostEscapular(:);
    SerratoPostEscapular_ROI = SerratoPostEscapular_ROI(timeLimits(1):timeLimits(2));
    SerratoPostEscapular_ROI(end,:) = [];
catch
    SerratoPostEscapular_ROI = SerratoPostEscapular(:);
    disp('not enough data')
end

%%
try
    timeLimits = [7000 240000];
    SerratoPostFrontal_ROI = SerratoPostFrontal(:);
    SerratoPostFrontal_ROI = SerratoPostFrontal_ROI(timeLimits(1):timeLimits(2));
    SerratoPostFrontal_ROI(end,:) = [];
catch
    SerratoPostFrontal_ROI = SerratoPostFrontal(:);
    disp('not enough data')
end
%%
try
    timeLimits = [7000 240000];
    SerratoPreEscapular_ROI = SerratoPreEscapular(:);
    SerratoPreEscapular_ROI = SerratoPreEscapular_ROI(timeLimits(1):timeLimits(2));
    SerratoPreEscapular_ROI(end,:) = [];
catch
    SerratoPreEscapular_ROI = SerratoPreEscapular(:);
    disp('not enough data')
end
%%
try
    timeLimits = [7000 240000];
    SerratoPreFrontal_ROI = SerratoPreFrontal(:);
    SerratoPreFrontal_ROI = SerratoPreFrontal_ROI(timeLimits(1):timeLimits(2));
    SerratoPreFrontal_ROI(end,:) = [];
catch
    SerratoPreFrontal_ROI = SerratoPreFrontal(:);
    disp('not enough data')
end
%%
try
    timeLimits = [7000 240000];
    TrapezioPostFrontal_ROI = TrapezioPostFrontal(:);
    TrapezioPostFrontal_ROI = TrapezioPostFrontal_ROI(timeLimits(1):timeLimits(2));
    TrapezioPostFrontal_ROI(end,:) = [];
catch
    TrapezioPreEscapular_ROI = TrapezioPreEscapular(:);
    disp('not enough data')
end
%%
try
    timeLimits = [7000 240000]; 
    TrapezioPreEscapular_ROI = TrapezioPreEscapular(:);
    TrapezioPreEscapular_ROI = TrapezioPreEscapular_ROI(timeLimits(1):timeLimits(2));
    TrapezioPreEscapular_ROI(end,:) = [];
catch
    TrapezioPreEscapular_ROI = TrapezioPreEscapular(:);
    disp('not enough data')
end
%%
try
    timeLimits = [7000 240000];
    TrapezioPreFrontal_ROI = TrapezioPreFrontal(:);
    TrapezioPreFrontal_ROI = TrapezioPreFrontal_ROI(timeLimits(1):timeLimits(2));
    TrapezioPreFrontal_ROI(end,:) = [];
catch
    TrapezioPreFrontal_ROI = TrapezioPreFrontal(:);
    disp('not enough data')
end
%%
try
    timeLimits = [7000 240000]; 
    TrapezioPostEscapular_ROI = TrapezioPostEscapular(:);
    TrapezioPostEscapular_ROI = TrapezioPostEscapular_ROI(timeLimits(1):timeLimits(2));
    TrapezioPostEscapular_ROI(end,:) = [];
catch
    TrapezioPostEscapular_ROI = TrapezioPostEscapular(:);
    disp('not enough data')
end
%%
disp('Wait...Saving')

save('data/S21.mat','SerratoPostEscapular_ROI','SerratoPostFrontal_ROI','SerratoPreEscapular_ROI','SerratoPreFrontal_ROI','TrapezioPostFrontal_ROI','TrapezioPreEscapular_ROI','TrapezioPreFrontal_ROI', 'TrapezioPostEscapular_ROI','-append')

disp('Done')