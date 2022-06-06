% Clear workspace
clear; clc;

matFiles = dir('*.mat');
numFiles = length(matFiles) ;

%for k = 2: numFiles
k = 2;
% Load data
thisFileName = fullfile(pwd, matFiles(k).name);
fprintf('Processing "%s".\n', thisFileName);
target = load(thisFileName);

%% Start calculations
trials = target.Trials;
% Asign Pre Post
rotationPre = target.PreScapUp;
rotationPost = target.PostScapUp;
dataPre = reshape(rotationPre,round(length(rotationPre)/10),[]); %divide Predata into 10 sections
dataPost = reshape(rotationPost,round(length(rotationPost)/10),[]); %divide Postdata into 10 sections

%store variables
dataPre50 = [];
dataPost50 = [];
dataPre100 = [];
dataPost100 = [];
%% Asign 50 or 100 Trial
for i=1:length(trials)
    % if trial is 50, store, else is 100 and store
    if trials(i) == 50
        dataPre50= [dataPre50,dataPre(:,i)]; %append
        dataPost50= [dataPost50,dataPre(:,i)]; %append
    else
        dataPre100= [dataPre100,dataPre(:,i)]; %append
        dataPost100= [dataPost100,dataPre(:,i)]; %append
    end
end


%Calculate ROM
for u=1:5
    A = dataPre50(:,u);
    B = dataPost50(:,:);
    C = dataPre100(:,:);
    D = dataPost100(:,:);
    %Calculate Min for 1/2 data and store index
    [startPre50, index1] = min(A(1:round(length(A)/2),1));
    [startPost50, index2] = min(B(1:round(length(B)/2),1));
    [endPre50,index3] = max(A);
    [endPost50,index4] = max(B);

    startPre100 = min(C(1:round(length(C)/2),1));
    startPost100 = min(D(1:round(length(D)/2),1));
    endPre100 = max(C);
    endPost100 = max(D);


    %Calculate ROM
    romPre50 = mean(endPre50-startPre50);
    romPre100 = mean(endPre100-startPre100);
    romPost50 = mean(endPost50-startPost50);
    romPost100 = mean(endPost100-startPost100);
    
    plot(A(:,:));
    hold on
    for a = 1 :10
        plot(index1,startPre50,'X')
        hold on
        plot(index3,endPre50,'O')
    end
end
%end

