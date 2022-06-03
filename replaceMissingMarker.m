% This script will replace a marker that is missing on a 4
% marker rigid body cluster during a dynamic trial, but is present in a
% static trial. 
%
% If the marker is present for at least 1 frame in the trial, this code will not work.
% Please use the companion code "replace4Macro.m" instead.
%
% This code must be run in Matlab and cannot be run in Nexus 2 as it 
% requres the user to open trials manually in Nexus 2 and this 
% cannot be done through a pipeline. 
%
% When executing the code, you will be prompted to open the trial in Nexus 
% 2 that contains all 4 markers on the rigid body segment, and to then press 
% OK in the Matlab prompt. 
% You will then be prompted to type in the subject name (the same as the 
% vsk) in Matlab. You will then be prompted to type the names of the four markers 
% on the rigid body cluster via Matlab. 
%
% After pressing OK, a Matlab prompt will then ask you if you want to load a DYNAMIC
% trial in Nexus 2 where a marker is missing on the rigid body segment. This marker 
% has to be missing for the entirety of the trial. If Yes is selected, 
% you will need to load the appropriate trial in Nexus.
%
% It will prompt you to save the trial within Nexus. It will then ask if you 
% would like to repeat the process for other trials where a marker 
% on the same cluster is missing. If you would like to use this on other trials, 
% Press yes, and load as many dynamic trials as you would like to
% run the operation on, and save them within Nexus 2. 
%
% When all trials have been processed,press No, or Cancel. 
% 
% If a dynamic trial has the missing marker present in even a single frame, the code will
% not work. Instead, please use the script "replace4Macro.m"
%
% Written by Nev Pires, 1/11/2020

%% Clear the workspace

clear; clc;

%% Load the Static Trial

uiwait(msgbox('Please load the static trial, where all 4 markers on the rigid body segment are present in Nexus','Load Static Trial','modal'));

%% Connect to Nexus

vicon = ViconNexus();

%% Check to see whether the subject name has been entered correctly

yes = false;
while yes == false
    
    %% Get List of Subject Names
    
    subjectNames = vicon.GetSubjectNames();
    
    %% Define Subject Name
    
    subjectInput = inputdlg({'Enter Subject Name'});
    subject = subjectInput{1};
    
    %% Check to see whether the subject name entered matches the subjet name in the list of subject names from Nexus
    
    if ~any(strcmp(subject, subjectNames))
    questdlg('The Subject Name does not match the VSK. Please enter the correct Subject Name', ...
        '','Ok','Ok');
    else
        yes = true;
    end
    
end

%% Get the Marker Information

markers = inputdlg({'Marker1', 'Marker2', 'Marker3', 'Marker4'}, 'Rigid Body Marker Clusters');
markers = sort(markers);

FullMarkerList = vicon.GetMarkerNames(subject);

found = logical(true(1,length(markers)));
for j = 1:length(markers)
    found(j) = false;
    for i = 1:length(FullMarkerList)
        if strcmp(FullMarkerList(i), markers{j}) == 1
            found(j) = true;
        end
    end
end

%% Check if Trial has all four markers present

TrajExists = logical(true(1,length(markers)));

for i = 1:length(markers)
    if found(i) == true
        TrajExists(i) = vicon.HasTrajectory(subject, markers{i});
        if TrajExists(i) == false
            error('A marker has not been labelled in the trial')
        end
    else
        error('A marker does not exist in the VSK. Please check the marker names.')
    end
end

%% Get Marker Data

for i = 1:length(markers)
    
    [trajX.(markers{i}), trajY.(markers{i}), trajZ.(markers{i}), exists.(markers{i})] = vicon.GetTrajectory(subject, markers{i});
    markerData.(markers{i}) = [trajX.(markers{i}); trajY.(markers{i}); trajZ.(markers{i})];
    
end

%% Create Nexus trajectory objects for each marker and populate them with the marker data that has already been imported

marker1 = NexusTrajectory(subject);
marker1.SetPosition(markerData.(markers{1}));

marker2 = NexusTrajectory(subject);
marker2.SetPosition(markerData.(markers{2}));

marker3 = NexusTrajectory(subject);
marker3.SetPosition(markerData.(markers{3}));

marker4 = NexusTrajectory(subject);
marker4.SetPosition(markerData.(markers{4}));

%% Define Segment if marker 1 is missing

s234 = NexusSegment(subject);
s234.Populate(marker3, marker2 - marker3, marker3 - marker4, 'xyz');

%% Globalize P1 in segment s234

p1V1 = s234.LocalisePoint(marker1);

%% Define Segment if marker 2 is missing

s134 = NexusSegment(subject);
s134.Populate(marker3, marker1 - marker3, marker3 - marker4, 'xyz');

%% Globalize P2 in segment s134

p2V1 = s134.LocalisePoint(marker2);

%% Define Segment if marker 3 is missing

s124 = NexusSegment(subject);
s124.Populate(marker2, marker1 - marker2, marker2 - marker4, 'xyz');

%% Globalize P3 in segment 124

p3V1 = s124.LocalisePoint(marker3);

%% Define Segment if marker 4 is missing

s123 = NexusSegment(subject);
s123.Populate(marker2, marker1 - marker2, marker2 - marker3, 'xyz');

%% Globalize P4 in segment 123

p4V1 = s123.LocalisePoint(marker4);

%% Load Dynamic Trial

yes = true;
Dynamicmarkers{length(markers)-1} = [];

while yes == true
    
    LoadDynamic = questdlg('Do You Want to Load a Dynamic Trial?', ...
                         'Load Dynamic Trial?', ...
                         'Yes', 'No', 'Cancel', 'No');
                     
                     if strcmp(LoadDynamic,'Yes')
                         yes = true;
                     elseif strcmp(LoadDynamic,'No')
                         break
                     elseif strcmp(LoadDynamic,'Cancel')
                         break
                     end
    
    uiwait(msgbox('Please the load dynamic trial, where one marker on the rigid body segment is missing for the entirety of the trial in Nexus','Load Dynamic Trial','modal'));
    
    vicon = ViconNexus();
    
    %% Check which markers exist
    
    MarkerExist = logical(true(1,length(markers)));
    
    for i = 1:length(markers)
        
        MarkerExist(i) = vicon.HasTrajectory(subject, markers{i});
        
    end
    
    %% Give an error if the markers are present in at least one frame of the trial 
    
    if sum(MarkerExist) == 4
        msgbox('Each marker has data for at least one frame in this trial. Please use the "Replace4Macro.m" Script instead.')
        error('Each marker has data for at least one frame in this trial. Please use the "Replace4Macro.m" Script instead.')
    end
    
    %% Determine Which Local Coordinate System to Use
    
    if MarkerExist(1) == 0
        Local = p1V1;
    elseif MarkerExist(2) == 0
        Local = p2V1;
    elseif MarkerExist(3) == 0
        Local = p3V1;
    elseif MarkerExist(4) == 0
        Local = p4V1;
    end
    
    Local = Local(:,all(~isnan(Local)));
    
    %% Define Marker Data if Marker Exists
    
    for i = 1:length(MarkerExist)
        if MarkerExist(i) == 1
            DynamicMarkers{i} = markers{i};
        end
    end
    
    DynamicMarkers = reshape(DynamicMarkers(~cellfun(@isempty,DynamicMarkers)),1,[]);
    
    
    %% Get Dynamic Marker Data
    
    for i = 1:length(DynamicMarkers)
        
        [X.(DynamicMarkers{i}), Y.(DynamicMarkers{i}), Z.(DynamicMarkers{i}), DynamicExists.(DynamicMarkers{i})] = vicon.GetTrajectory(subject, DynamicMarkers{i});
        DynamicMarkerData.(DynamicMarkers{i}) = [X.(DynamicMarkers{i}); Y.(DynamicMarkers{i}); Z.(DynamicMarkers{i})];
        
    end
    
    %% Create Nexus trajectory objects for each marker in the dynamic trial and populate them with the marker data that has already been imported
    
    dynamicMarker1 = NexusTrajectory(subject);
    dynamicMarker1.SetPosition(DynamicMarkerData.(DynamicMarkers{1}));
    
    dynamicMarker2 = NexusTrajectory(subject);
    dynamicMarker2.SetPosition(DynamicMarkerData.(DynamicMarkers{2}));
    

    dynamicMarker3 = NexusTrajectory(subject);
    dynamicMarker3.SetPosition(DynamicMarkerData.(DynamicMarkers{3}));
   
    
    %% Define Missing Segment
    
    dynamicSegment = NexusSegment(subject);
    dynamicSegment.Populate(dynamicMarker2, dynamicMarker1 - dynamicMarker2, dynamicMarker2 - dynamicMarker3);
    
    
    %% Do the Local to Global Transformation
    
    globalPoint = NexusTrajectory(subject);
    globalPoint.SetPosition(dynamicSegment.GlobalisePoint(mean(Local')'));
    
    globalPoint_Position = globalPoint.Position;
    
    %% Select the appropriate Output Marker
    
    if MarkerExist(1) == 0
        OutputMarker = markers{1};
    elseif MarkerExist(2) == 0
        OutputMarker = markers{2};
    elseif MarkerExist(3) == 0
        OutputMarker = markers{3};
    elseif MarkerExist(4) == 0
        OutputMarker = markers{4};
    end
    
    %% Determine if Marker Exists or not in a given frame.
    
    ExistsOutput = logical(true(1,length(DynamicExists.(DynamicMarkers{1}))));
    
    for i = 1:length(DynamicMarkers)
        for j = 1:length(DynamicExists.(DynamicMarkers{1}))
            
            if DynamicExists.(DynamicMarkers{1})(j) == 1 && DynamicExists.(DynamicMarkers{2})(j) == 1 && DynamicExists.(DynamicMarkers{3})(j) == 1
                ExistsOutput(j) = true;
            else
                ExistsOutput(j) = false;
            end
            
        end
    end
   
    %% Write Data to c3d
    
    vicon.SetTrajectory(subject, OutputMarker, globalPoint_Position(1,:), globalPoint_Position(2,:), globalPoint_Position(3,:), ExistsOutput);
    
    %% Save Trial
    
    uiwait(msgbox('Please Save The Trial In Nexus','modal'));
    
    DynamicMarkers = [];
    
end