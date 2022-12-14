% Clear workspace
clear; clc;

matFiles = dir('data/*.mat');
numFiles = length(matFiles) ;

romPre50 = [];
romPre100 = [];
romPost50 = [];
romPost100 = [];

for k = 2: numFiles

    temp1=[];
    temp2=[];
    temp3=[];
    temp4=[];

    % Load data
    thisFileName = fullfile(matFiles(k).folder, matFiles(k).name);
    fprintf('Processing "%s".\n', thisFileName);
    target = load(thisFileName);

    trials = target.Trials;


    % Asign Pre Post
    rotationPre = target.Escapular_Pre_ScapularUpward ; % target movement
    rotationPost = target.Escapular_Post_ScapularUpward ; % target movement

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
            dataPost50= [dataPost50,dataPost(:,i)]; %append
        else
            dataPre100= [dataPre100,dataPre(:,i)]; %append
            dataPost100= [dataPost100,dataPost(:,i)]; %append
        end
    end

    %% Calculate Min for 1/2 data and store index
    for b = 1 : 5
        A = dataPre50(:,b);
        B = dataPost50(:,b);
        C = dataPre100(:,b);
        D = dataPost100(:,b);

        [startPre50, index1] = min(A(1:round(length(A)/2),1));
        [startPost50, index2] = min(B(1:round(length(B)/2),1));
        [endPre50,index3] = max(A);
        [endPost50,index4] = max(B);

        startPre100 = min(C(1:round(length(C)/2),1));
        startPost100 = min(D(1:round(length(D)/2),1));
        endPre100 = max(C);
        endPost100 = max(D);

        %{
disp(['Pre50 ', num2str(endPre50-startPre50)])
disp(['Post50 ', num2str(endPost50-startPost50)])
disp(['Pre100 ', num2str(endPre100-startPre100)])
disp(['Post100 ', num2str(endPost100-startPost100)])
        %}

        %%

        % store temp variable for ROM calculations
        temp1 = [temp1,endPre50-startPre50];
        temp2 = [temp2, endPre100-startPre100];
        temp3 = [temp3,endPost50-startPost50];
        temp4 = [temp4,endPost100-startPost100];
    end

    %calculate mean(ROM) for each subject
    romPre50 = [romPre50,mean(temp1)];
    romPre100 = [romPre100,mean(temp2)];
    romPost50 = [romPost50,mean(temp3)];
    romPost100 = [romPost100,mean(temp4)];
end


clearvars -except romPre50 romPre100 romPost50 romPost100


subplot(2,1,1)
plot(romPre50,'-ko')
hold on
plot(romPost50,'-ro')
legend({'Pre','Post'},'Location','southwest')
title('ROM Scapula (Upward Rotation) - 50°')

subplot(2,1,2)
plot(romPre100,'-ko')
hold on
plot(romPost100,'-ro')
legend({'Pre','Post'},'Location','southwest')
title('ROM Scapula (Upward Rotation) - 100°')

