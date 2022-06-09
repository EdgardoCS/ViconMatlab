%% Clear the workspace

clear; clc;

%% Load the Static Trial

%uiwait(msgbox('Please load the static trial, where all 4 markers on the rigid body segment are present in Nexus','Load Static Trial','modal'));

%% Connect to Nexus

vicon = ViconNexus();

%% Get the Marker Information

subjectName = vicon.GetSubjectNames;

FullMarkerList = vicon.GetMarkerNames(subjectName{1});

deviceIDs = vicon.GetDeviceIDs();
[~,~,~,outputIDs,~,~] = vicon.GetDeviceDetails(deviceIDs(3));
%EMG Device9 == Serrato
[~,~,~,~,~,channelIDs] = vicon.GetDeviceOutputDetails(deviceIDs(3),outputIDs(9));
[data, ready, rate] = vicon.GetDeviceChannel(deviceIDs(3),outputIDs(9),channelIDs(1));
subplot(2,1,1)
plot(data)

%EMG Device10 == Trapezio
[~,~,~,~,~,channelIDs] = vicon.GetDeviceOutputDetails(deviceIDs(3),outputIDs(10));
[data, ready, rate] = vicon.GetDeviceChannel(deviceIDs(3),outputIDs(10),channelIDs(1));
subplot(2,1,2)
plot(data)