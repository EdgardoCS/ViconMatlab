clc; clear;

format short g

load('C:\Users\VICON\MatlabProjects\data\S03.mat')

Fs = 100;
Fc = 6;
FAbd = Fc/(Fs/2);

df = designfilt('lowpassfir','FilterOrder',100,'CutoffFrequency',FAbd);
Escapular_Pre_HumeroScapular = filtfilt(df,Escapular_Pre_HumeroScapular);
Escapular_Post_HumeroScapular = filtfilt(df,Escapular_Post_HumeroScapular);

% KINEMATIC
frontalMovPre50 = {};
frontalMovPost50 = {};
frontalMovPre100 = {};
frontalMovPost100 = {};

sagitalMovPre50 = {};
sagitalMovPost50 = {};
sagitalMovPre100 = {};
sagitalMovPost100 = {};

% EMG
frontalMusclePre50 = {};
frontalMusclePost50 = {};
frontalMusclePre100 = {};
frontalMusclePost100 = {};

sagitalMusclePre50 = {};
sagitalMusclePost50 = {};
sagitalMusclePre100 = {};
sagitalMusclePost100 = {};

for j=1:10
    if Trials(j) == 50

        data1Pre50 = Frontal_Pre_HumeroFrontal(framesPreFrontal(j,1):framesPreFrontal(j,2));
        data2Post50 = Frontal_Post_HumeroFrontal(framesPostFrontal(j,1):framesPostFrontal(j,2));
        data3Pre50 = Escapular_Pre_HumeroScapular(framesPreEscapular(j,1):framesPreEscapular(j,2));
        data4Post50 = Escapular_Post_HumeroScapular(framesPostEscapular(j,1):framesPostEscapular(j,2));

        frontal_serratoPre50_ROI = SerratoPreFrontal(framesPreFrontal(j,1)*20:framesPreFrontal(j,2)*20);
        frontal_serratoPost50_ROI = SerratoPostFrontal(framesPostFrontal(j,1)*20:framesPostFrontal(j,2)*20);
        frontal_trapezioPre50_ROI = TrapezioPreFrontal(framesPreFrontal(j,1)*20:framesPreFrontal(j,2)*20);
        frontal_trapezioPost50_ROI = TrapezioPostFrontal(framesPostFrontal(j,1)*20:framesPostFrontal(j,2)*20);

        sagital_serratoPre50_ROI = SerratoPreEscapular(framesPreEscapular(j,1)*20:framesPreEscapular(j,2)*20);
        sagital_serratoPost50_ROI = SerratoPostEscapular(framesPostEscapular(j,1)*20:framesPostEscapular(j,2)*20);
        sagital_trapezioPre50_ROI = TrapezioPreEscapular(framesPreEscapular(j,1)*20:framesPreEscapular(j,2)*20);
        sagital_trapezioPost50_ROI = TrapezioPostEscapular(framesPostEscapular(j,1)*20:framesPostEscapular(j,2)*20);

        frontalMovPre50 = [frontalMovPre50, data1Pre50]; % HumeroAbd Pre 50 (Frontal plane)
        frontalMovPost50 = [frontalMovPost50,  data2Post50]; % HumeroAbd Post 50 (Frontal plane)
        sagitalMovPre50 = [sagitalMovPre50, data3Pre50]; % HumeroAbd Pre 50 (Sagital plane)
        sagitalMovPost50 = [sagitalMovPost50, data4Post50]; % HumeroAbd Post 50 (Sagital plane)

        frontalMusclePre50 = [frontalMusclePre50, frontal_serratoPre50_ROI, frontal_trapezioPre50_ROI]; % Serrato - Trapezio Pre 50 (Frontal plane)
        frontalMusclePost50 = [frontalMusclePost50, frontal_serratoPost50_ROI, frontal_trapezioPost50_ROI]; % Serrato - Trapezio Post 50 (Frontal plane)
        sagitalMusclePre50 = [sagitalMusclePre50, sagital_serratoPre50_ROI, sagital_trapezioPre50_ROI]; % Serrato - Trapezio Pre 50 (Sagital plane)
        sagitalMusclePost50 = [sagitalMusclePost50, sagital_serratoPost50_ROI, sagital_trapezioPost50_ROI]; % Serrato - Trapezio Post 50 (Sagital plane)

    elseif Trials(j) == 100

        data1Pre100 = Frontal_Pre_HumeroFrontal(framesPreFrontal(j,1):framesPreFrontal(j,2));
        data2Post100 = Frontal_Post_HumeroFrontal(framesPostFrontal(j,1):framesPostFrontal(j,2));
        data3Pre100 = Escapular_Pre_HumeroScapular(framesPreEscapular(j,1):framesPreEscapular(j,2));
        data4Post100 = Escapular_Post_HumeroScapular(framesPostEscapular(j,1):framesPostEscapular(j,2));

        frontal_serratoPre100_ROI = SerratoPreFrontal(framesPreFrontal(j,1)*20:framesPreFrontal(j,2)*20);
        frontal_serratoPost100_ROI = SerratoPostFrontal(framesPostFrontal(j,1)*20:framesPostFrontal(j,2)*20);
        frontal_trapezioPre100_ROI = TrapezioPreFrontal(framesPreFrontal(j,1)*20:framesPreFrontal(j,2)*20);
        frontal_trapezioPost100_ROI = TrapezioPostFrontal(framesPostFrontal(j,1)*20:framesPostFrontal(j,2)*20);

        sagital_serratoPre100_ROI = SerratoPreEscapular(framesPreEscapular(j,1)*20:framesPreEscapular(j,2)*20);
        sagital_serratoPost100_ROI = SerratoPostEscapular(framesPostEscapular(j,1)*20:framesPostEscapular(j,2)*20);
        sagital_trapezioPre100_ROI = TrapezioPreEscapular(framesPreEscapular(j,1)*20:framesPreEscapular(j,2)*20);
        sagital_trapezioPost100_ROI = TrapezioPostEscapular(framesPostEscapular(j,1)*20:framesPostEscapular(j,2)*20);

        frontalMovPre100 = [frontalMovPre100, data1Pre100]; % ScapTilt - ScapUp - HumeroAbd Pre 100 (Frontal plane)
        frontalMovPost100 = [frontalMovPost100, data2Post100]; % ScapTilt - ScapUp - HumeroAbd Post 100 (Frontal plane)
        sagitalMovPre100 = [sagitalMovPre100, data3Pre100]; % HumeroAbd Pre 100 (Sagital plane)
        sagitalMovPost100 = [sagitalMovPost100, data4Post100]; % HumeroAbd Post 100 (Sagital plane)

        frontalMusclePre100 = [frontalMusclePre100, frontal_serratoPre100_ROI, frontal_trapezioPre100_ROI]; % Serrato - Trapezio Pre 100 (Frontal plane)
        frontalMusclePost100 = [frontalMusclePost100, frontal_serratoPost100_ROI, frontal_trapezioPost100_ROI]; % Serrato - Trapezio Post 100 (Frontal plane)
        sagitalMusclePre100 = [sagitalMusclePre100, sagital_serratoPre100_ROI, sagital_trapezioPre100_ROI]; % Serrato - Trapezio Pre 100 (Sagital plane)
        sagitalMusclePost100 = [sagitalMusclePost100, sagital_serratoPost100_ROI, sagital_trapezioPost100_ROI]; % Serrato - Trapezio Pre 100 (Sagital plane)

    end
end

%% Frontal
targetFrontalPre50 = [];
targetFrontalPre100 = [];
targetFrontalPost50 = [];
targetFrontalPost100 = [];

for i =1:5
    A = frontalMovPre50 {:,i};
    B = frontalMovPre100{:,i};
    C = frontalMovPost50{:,i};
    D = frontalMovPost100{:,i};

    A = abs(A);
    B = abs(B);
    C = abs(C);
    D = abs(D);

    %% Frontal Pre50
    [endMovPre50, endIndex50] = max(A);
    [startMovPre50, startIndex50] = min(A(1:endIndex50));
    temp1 = endMovPre50-startMovPre50;

    for j = 1:temp1
        c=startMovPre50+j;
        d = find(A(startIndex50:endIndex50)<c);
        targetFrontalPre50(i,j) = d(end);
    end

    %% Frontal Pre100
    [endMovPre100, endIndex100] = max(B);
    [startMovPre100, startIndex100] = min(B(1:endIndex100));
    temp2 = endMovPre100-startMovPre100;
    for j = 1:temp2
        c=startMovPre100+j;
        d = find(B(startIndex100:endIndex100)<c);
        targetFrontalPre100(i,j) = d(end);
    end

    %% Frontal Post50
    [endMovPost50, endIndexP50] = max(C);
    [startMovPost50, startIndexP50] = min(C(1:endIndexP50));
    temp3 = endMovPost50-startMovPost50;
    for j = 1:temp3
        c=startMovPost50+j;
        d = find(C(startIndexP50:endIndexP50)<c);
        targetFrontalPost50(i,j) = d(end);
    end

    %% Frontal Post100
    [endMovPost100, endIndexP100] = max(D);
    [startMovPost100, startIndexP100] = min(D(1:endIndexP100));
    temp4 = endMovPost100-startMovPost100;
    for j = 1:temp4
        c=startMovPost100+j;
        d = find(D(startIndexP100:endIndexP100)<c);
        targetFrontalPost100(i,j) = d(end);
    end

    %{
    subplot(2,2,1)
    plot(A)
    hold on
    plot(startIndex50, startMovPre50,'o')
    plot(endIndex50, endMovPre50, 'x')
    title('A')

    subplot(2,2,2)
    plot(B)
    hold on
    plot(startIndex100, startMovPre100,'o')
    plot(endIndex100, endMovPre100, 'x')
    title('B')

    subplot(2,2,3)
    plot(C)
    hold on
    plot(startIndexP50, startMovPost50,'o')
    plot(endIndexP50, endMovPost50, 'x')
    title('C')

    subplot(2,2,4)
    plot(endMovPost100, startMovPost100,'x')
    plot(D)
    hold on
    plot(startIndexP100, startMovPost100,'o')
    plot(endIndexP100, endMovPost100, 'x')
    title('D')
    %}
end

frontalSerratoPre50 = {};
frontalSerratoPre100 = {};
frontalSerratoPost50 = {};
frontalSerratoPost100 = {};

frontalTrapezioPre50 = {};
frontalTrapezioPre100 = {};
frontalTrapezioPost50 = {};
frontalTrapezioPost100 = {};

for k = 1:5
    for i= 1:2:10
        A1 = frontalMusclePre50{:,i};
        B1 = frontalMusclePre100{:,i};
        C1 = frontalMusclePost50{:,i};
        D1 = frontalMusclePost100{:,i};

        for j = 1:length(targetFrontalPre50(k,:))
            if j<nnz(targetFrontalPre50(k,:)) && targetFrontalPre50(k,j+1)*20 <length(A1)
                frontalSerratoPre50 = [frontalSerratoPre50,A1(targetFrontalPre50(k,j)*20:targetFrontalPre50(k,j+1)*20)];
            end
        end
        for j = 1:length(targetFrontalPre100(k,:))
            if  j<nnz(targetFrontalPre100(k,:)) && targetFrontalPre100(k,j+1)*20 <length(B1)
                frontalSerratoPre100 = [frontalSerratoPre100, B1(targetFrontalPre100(k,j)*20:targetFrontalPre100(k,j+1)*20)];
            end
        end
        for j = 1:length(targetFrontalPost50(k,:))-1
            if j<nnz(targetFrontalPost50(k,:)) && targetFrontalPost50(k,j+1)*20 <length(C1)
                frontalSerratoPost50 = [frontalSerratoPost50, C1(targetFrontalPost50(k,j)*20:targetFrontalPost50(k,j+1)*20)];
            end
        end
        for j = 1:length(targetFrontalPost100(k,:))-1
            if j<nnz(targetFrontalPost100(k,:)) && targetFrontalPost100(k,j+1)*20 <length(D1)
                frontalSerratoPost100 = [frontalSerratoPost100, D1(targetFrontalPost100(k,j)*20:targetFrontalPost100(k,j+1)*20)];
            end
        end
    end

    for i=2:2:10
        A1 = frontalMusclePre50{:,i};
        B1 = frontalMusclePre100{:,i};
        C1 = frontalMusclePost50{:,i};
        D1 = frontalMusclePost100{:,i};

        for j = 1:length(targetFrontalPre50(k,:))
            if j<nnz(targetFrontalPre50(k,:)) && targetFrontalPre50(k,j+1)*20 <length(A1)
                frontalTrapezioPre50 = [frontalTrapezioPre50,A1(targetFrontalPre50(k,j)*20:targetFrontalPre50(k,j+1)*20)];
            end
        end
        for j = 1:length(targetFrontalPre100(k,:))
            if j<nnz(targetFrontalPre100(k,:)) && targetFrontalPre100(k,j+1)*20 <length(B1)
                frontalTrapezioPre100 = [frontalTrapezioPre100, B1(targetFrontalPre100(k,j)*20:targetFrontalPre100(k,j+1)*20)];
            end
        end
        for j = 1:length(targetFrontalPost50(k,:))-1
            if j<nnz(targetFrontalPost50(k,:)) && targetFrontalPost50(k,j+1)*20 <length(C1)
                frontalTrapezioPost50 = [frontalTrapezioPost50, C1(targetFrontalPost50(k,j)*20:targetFrontalPost50(k,j+1)*20)];
            end
        end
        for j = 1:length(targetFrontalPost100(k,:))-1
            if j<nnz(targetFrontalPost100(k,:)) && targetFrontalPost100(k,j+1)*20 <length(D1)
                frontalTrapezioPost100 = [frontalTrapezioPost100, D1(targetFrontalPost100(k,j)*20:targetFrontalPost100(k,j+1)*20)];
            end
        end
    end

end

%% Sagital

targetSagitalPre50 = [];
targetSagitalPre100 = [];
targetSagitalPost50 = [];
targetSagitalPost100 = [];

for i =1:5
    A = sagitalMovPre50{:,i};
    B = sagitalMovPre100{:,i};
    C = sagitalMovPost50{:,i};
    D = sagitalMovPost100{:,i};

    A = abs(A);
    B = abs(B);
    C = abs(C);
    D = abs(D);

    %% Sagital Pre50
    [endMovPre50, endIndex50] = max(A);
    [startMovPre50, startIndex50] = min(A(1:endIndex50));
    temp1 = endMovPre50-startMovPre50;

    for j = 1:temp1
        c=startMovPre50+j;
        d = find(A(startIndex50:endIndex50)<c);
        targetSagitalPre50(i,j) = d(end);
    end

    %% Sagital Pre100
    [endMovPre100, endIndex100] = max(B);
    [startMovPre100, startIndex100] = min(B(1:endIndex100));
    temp2 = endMovPre100-startMovPre100;
    for j = 1:temp2
        c=startMovPre100+j;
        d = find(B(startIndex100:endIndex100)<c);
        targetSagitalPre100(i,j) = d(end);
    end

    %% Sagital Post50
    [endMovPost50, endIndexP50] = max(C);
    [startMovPost50, startIndexP50] = min(C(1:endIndexP50));
    temp3 = endMovPost50-startMovPost50;
    for j = 1:temp3
        c=startMovPost50+j;
        d = find(C(startIndexP50:endIndexP50)<c);
        targetSagitalPost50(i,j) = d(end);
    end

    %% Sagital Post100
    [endMovPost100, endIndexP100] = max(D);
    [startMovPost100, startIndexP100] = min(D(1:endIndexP100));
    temp4 = endMovPost100-startMovPost100;
    for j = 1:temp4
        c=startMovPost100+j;
        d = find(D(startIndexP100:endIndexP100)<c);
        targetSagitalPost100(i,j) = d(end);
    end

    %{
    subplot(2,2,1)
    plot(A)
    hold on
    plot(startIndex50, startMovPre50,'o')
    plot(endIndex50, endMovPre50, 'x')
    title('A')

    subplot(2,2,2)
    plot(B)
    hold on
    plot(startIndex100, startMovPre100,'o')
    plot(endIndex100, endMovPre100, 'x')
    title('B')

    subplot(2,2,3)
    plot(C)
    hold on
    plot(startIndexP50, startMovPost50,'o')
    plot(endIndexP50, endMovPost50, 'x')
    title('C')

    subplot(2,2,4)
    plot(endMovPost100, startMovPost100,'x')
    plot(D)
    hold on
    plot(startIndexP100, startMovPost100,'o')
    plot(endIndexP100, endMovPost100, 'x')
    title('D')
    %}
end

sagitalSerratoPre50 = {};
sagitalSerratoPre100 = {};
sagitalSerratoPost50 = {};
sagitalSerratoPost100 = {};

sagitalTrapezioPre50 = {};
sagitalTrapezioPre100 = {};
sagitalTrapezioPost50 = {};
sagitalTrapezioPost100 = {};

for k = 1:5
    for i= 1:2:10
        A1 = sagitalMusclePre50{:,i};
        B1 = sagitalMusclePre100{:,i};
        C1 = sagitalMusclePost50{:,i};
        D1 = sagitalMusclePost100{:,i};

        for j = 1:length(targetSagitalPre50(k,:))
            if j<nnz(targetSagitalPre50(k,:)) && targetSagitalPre50(k,j+1)*20 <length(A1)
                sagitalSerratoPre50 = [sagitalSerratoPre50,A1(targetSagitalPre50(k,j)*20:targetSagitalPre50(k,j+1)*20)];
            end
        end
        for j = 1:length(targetSagitalPre100(k,:))
            if j<nnz(targetSagitalPre100(k,:)) && targetSagitalPre100(k,j+1)*20 <length(B1)
                sagitalSerratoPre100 = [sagitalSerratoPre100, B1(targetSagitalPre100(k,j)*20:targetSagitalPre100(k,j+1)*20)];
            end
        end
        for j = 1:length(targetSagitalPost50(k,:))
            if j<nnz(targetSagitalPost50(k,:)) && targetSagitalPost50(k,j+1)*20 <length(C1)
                sagitalSerratoPost50 = [sagitalSerratoPost50, C1(targetSagitalPost50(k,j)*20:targetSagitalPost50(k,j+1)*20)];
            end
        end
        for j = 1:length(targetSagitalPost100(k,:))
            if j<nnz(targetSagitalPost100(k,:)) && targetSagitalPost100(k,j+1)*20 <length(D1)
                sagitalSerratoPost100 = [sagitalSerratoPost100, D1(targetSagitalPost100(k,j)*20:targetSagitalPost100(k,j+1)*20)];
            end
        end
    end


    for i=2:2:10
        A1 = sagitalMusclePre50{:,i};
        B1 = sagitalMusclePre100{:,i};
        C1 = sagitalMusclePost50{:,i};
        D1 = sagitalMusclePost100{:,i};

        for j = 1:length(targetSagitalPre50(k,:))
            if j<nnz(targetSagitalPre50(k,:)) && targetSagitalPre50(k,j+1)*20<length(A1)
                sagitalTrapezioPre50 = [sagitalTrapezioPre50,A1(targetSagitalPre50(k,j)*20:targetSagitalPre50(k,j+1)*20)];
            end
        end
        for j = 1:length(targetSagitalPre100(k,:))
            if j<nnz(targetSagitalPre100(k,:)) && targetSagitalPre100(k,j+1)*20 <length(B1)
                sagitalTrapezioPre100 = [sagitalTrapezioPre100, B1(targetSagitalPre100(k,j)*20:targetSagitalPre100(k,j+1)*20)];
            end
        end
        for j = 1:length(targetSagitalPost50(k,:))
            if j<nnz(targetSagitalPost50(k,:)) && targetSagitalPost50(k,j+1)*20 <length(C1)
                sagitalTrapezioPost50 = [sagitalTrapezioPost50, C1(targetSagitalPost50(k,j)*20:targetSagitalPost50(k,j+1)*20)];
            end
        end
        for j = 1:length(targetSagitalPost100(k,:))
            if j<nnz(targetSagitalPost100(k,:)) && targetSagitalPost100(k,j+1)*20 <length(D1)
                sagitalTrapezioPost100 = [sagitalTrapezioPost100, D1(targetSagitalPost100(k,j)*20:targetSagitalPost100(k,j+1)*20)];
            end
        end
    end

end

clearvars -except ...
    targetFrontalPre50 targetFrontalPre100 targetFrontalPost50 targetFrontalPost100 ...
    targetSagitalPre50 targetSagitalPre100 targetSagitalPost50 targetSagitalPost100...
    frontalSerratoPre50 frontalSerratoPre100 frontalSerratoPost50 frontalSerratoPost100 ...
    frontalTrapezioPre50 frontalTrapezioPre100 frontalTrapezioPost50 frontalTrapezioPost100 ...
    sagitalSerratoPre50 sagitalSerratoPre100 sagitalSerratoPost50 sagitalSerratoPost100 ...
    sagitalTrapezioPre50 sagitalTrapezioPre100 sagitalTrapezioPost50 sagitalTrapezioPost100 ...

B1 = [];
B2 = [];
B3 = [];
B4 = [];

for i=1:5
    for j = 1: length(targetFrontalPre50(i,:))
        A = targetFrontalPre50(i,j);
        if A == 0
            A = [];
        else
            B1(i) = j;
        end
    end
    for j = 1: length(targetFrontalPre100(i,:))
        A = targetFrontalPre100(i,j);
        if A == 0
            A = [];
        else
            B2(i) = j;
        end
    end
    for j = 1: length(targetFrontalPost50(i,:))
        A = targetFrontalPost50(i,j);
        if A == 0
            A = [];
        else
            B3(i) = j;
        end
    end
    for j = 1: length(targetFrontalPost100(i,:))
        A = targetFrontalPost100(i,j);
        if A == 0
            A = [];
        else
            B4(i) = j;
        end
    end
end


%% Frontal
frontalSerratoTrial1Pre50 = frontalSerratoPre50(1:(B1(1)-1)*5);
frontalSerratoTrial2Pre50 = frontalSerratoPre50(((B1(1)-1)*5)+1:(((((B1(1)-1)*5)+1)+(B1(2)-1)*5)-1));
frontalSerratoTrial3Pre50 = frontalSerratoPre50(((B1(2)-1)*5)+1:(((((B1(2)-1)*5)+1)+(B1(3)-1)*5)-1));
frontalSerratoTrial4Pre50 = frontalSerratoPre50(((B1(3)-1)*5)+1:(((((B1(3)-1)*5)+1)+(B1(4)-1)*5)-1));
frontalSerratoTrial5Pre50 = frontalSerratoPre50(((B1(4)-1)*5)+1:(((((B1(4)-1)*5)+1)+(B1(5)-1)*5)-1));

frontalSerratoTrial1Pre100 = frontalSerratoPre100(1:(B2(1)-1)*5);
frontalSerratoTrial2Pre100 = frontalSerratoPre100(((B2(1)-1)*5)+1:(((((B2(1)-1)*5)+1)+(B2(2)-1)*5)-1));
frontalSerratoTrial3Pre100 = frontalSerratoPre100(((B2(2)-1)*5)+1:(((((B2(2)-1)*5)+1)+(B2(3)-1)*5)-1));
frontalSerratoTrial4Pre100 = frontalSerratoPre100(((B2(3)-1)*5)+1:(((((B2(3)-1)*5)+1)+(B2(4)-1)*5)-1));
frontalSerratoTrial5Pre100 = frontalSerratoPre100(((B2(4)-1)*5)+1:(((((B2(4)-1)*5)+1)+(B2(5)-1)*5)-1));

frontalSerratoTrial1Post50 = frontalSerratoPost50(1:(B3(1)-1)*5);
frontalSerratoTrial2Post50 = frontalSerratoPost50(((B3(1)-1)*5)+1:(((((B3(1)-1)*5)+1)+(B3(2)-1)*5)-1));
frontalSerratoTrial3Post50 = frontalSerratoPost50(((B3(2)-1)*5)+1:(((((B3(2)-1)*5)+1)+(B3(3)-1)*5)-1));
frontalSerratoTrial4Post50 = frontalSerratoPost50(((B3(3)-1)*5)+1:(((((B3(3)-1)*5)+1)+(B3(4)-1)*5)-1));
frontalSerratoTrial5Post50 = frontalSerratoPost50(((B3(4)-1)*5)+1:(((((B3(4)-1)*5)+1)+(B3(5)-1)*5)-1));

frontalSerratoTrial1Post100 = frontalSerratoPost100(1:(B4(1)-1)*5);
frontalSerratoTrial2Post100 = frontalSerratoPost100(((B4(1)-1)*5)+1:(((((B4(1)-1)*5)+1)+(B4(2)-1)*5)-1));
frontalSerratoTrial3Post100 = frontalSerratoPost100(((B4(2)-1)*5)+1:(((((B4(2)-1)*5)+1)+(B4(3)-1)*5)-1));
frontalSerratoTrial4Post100 = frontalSerratoPost100(((B4(3)-1)*5)+1:(((((B4(3)-1)*5)+1)+(B4(4)-1)*5)-1));
frontalSerratoTrial5Post100 = frontalSerratoPost100(((B4(4)-1)*5)+1:(((((B4(4)-1)*5)+1)+(B4(5)-1)*5)-1));

frontalTrapezioTrial1Pre50 = frontalTrapezioPre50(1:(B1(1)-1)*5);
frontalTrapezioTrial2Pre50 = frontalTrapezioPre50(((B1(1)-1)*5)+1:(((((B1(1)-1)*5)+1)+(B1(2)-1)*5)-1));
frontalTrapezioTrial3Pre50 = frontalTrapezioPre50(((B1(2)-1)*5)+1:(((((B1(2)-1)*5)+1)+(B1(3)-1)*5)-1));
frontalTrapezioTrial4Pre50 = frontalTrapezioPre50(((B1(3)-1)*5)+1:(((((B1(3)-1)*5)+1)+(B1(4)-1)*5)-1));
frontalTrapezioTrial5Pre50 = frontalTrapezioPre50(((B1(4)-1)*5)+1:(((((B1(4)-1)*5)+1)+(B1(5)-1)*5)-1));

frontalTrapezioTrial1Pre100 = frontalTrapezioPre100(1:(B2(1)-1)*5);
frontalTrapezioTrial2Pre100 = frontalTrapezioPre100(((B2(1)-1)*5)+1:(((((B2(1)-1)*5)+1)+(B2(2)-1)*5)-1));
frontalTrapezioTrial3Pre100 = frontalTrapezioPre100(((B2(2)-1)*5)+1:(((((B2(2)-1)*5)+1)+(B2(3)-1)*5)-1));
frontalTrapezioTrial4Pre100 = frontalTrapezioPre100(((B2(3)-1)*5)+1:(((((B2(3)-1)*5)+1)+(B2(4)-1)*5)-1));
frontalTrapezioTrial5Pre100 = frontalTrapezioPre100(((B2(4)-1)*5)+1:(((((B2(4)-1)*5)+1)+(B2(5)-1)*5)-1));

frontalTrapezioTrial1Post50 = frontalTrapezioPost50(1:(B3(1)-1)*5);
frontalTrapezioTrial2Post50 = frontalTrapezioPost50(((B3(1)-1)*5)+1:(((((B3(1)-1)*5)+1)+(B3(2)-1)*5)-1));
frontalTrapezioTrial3Post50 = frontalTrapezioPost50(((B3(2)-1)*5)+1:(((((B3(2)-1)*5)+1)+(B3(3)-1)*5)-1));
frontalTrapezioTrial4Post50 = frontalTrapezioPost50(((B3(3)-1)*5)+1:(((((B3(3)-1)*5)+1)+(B3(4)-1)*5)-1));
frontalTrapezioTrial5Post50 = frontalTrapezioPost50(((B3(4)-1)*5)+1:(((((B3(4)-1)*5)+1)+(B3(5)-1)*5)-1));

frontalTrapezioTrial1Post100 = frontalTrapezioPost100(1:(B4(1)-1)*5);
frontalTrapezioTrial2Post100 = frontalTrapezioPost100(((B4(1)-1)*5)+1:(((((B4(1)-1)*5)+1)+(B4(2)-1)*5)-1));
frontalTrapezioTrial3Post100 = frontalTrapezioPost100(((B4(2)-1)*5)+1:(((((B4(2)-1)*5)+1)+(B4(3)-1)*5)-1));
frontalTrapezioTrial4Post100 = frontalTrapezioPost100(((B4(3)-1)*5)+1:(((((B4(3)-1)*5)+1)+(B4(4)-1)*5)-1));
frontalTrapezioTrial5Post100 = frontalTrapezioPost100(((B4(4)-1)*5)+1:(((((B4(4)-1)*5)+1)+(B4(5)-1)*5)-1));

%% Sagital

B1 = [];
B2 = [];
B3 = [];
B4 = [];

for i=1:5
    for j = 1: length(targetSagitalPre50(i,:))
        A = targetSagitalPre50(i,j);
        if A == 0
            A = [];
        else
            B1(i) = j;
        end
    end
    for j = 1: length(targetSagitalPre100(i,:))
        A = targetSagitalPre100(i,j);
        if A == 0
            A = [];
        else
            B2(i) = j;
        end
    end
    for j = 1: length(targetSagitalPost50(i,:))
        A = targetSagitalPost50(i,j);
        if A == 0
            A = [];
        else
            B3(i) = j;
        end
    end
    for j = 1: length(targetSagitalPost100(i,:))
        A = targetSagitalPost100(i,j);
        if A == 0
            A = [];
        else
            B4(i) = j;
        end
    end
end
sagitalSerratoTrial1Pre50 = frontalSerratoPre50(1:(B1(1)-1)*5);
sagitalSerratoTrial2Pre50 = frontalSerratoPre50(((B1(1)-1)*5)+1:(((((B1(1)-1)*5)+1)+(B1(2)-1)*5)-1));
sagitalSerratoTrial3Pre50 = frontalSerratoPre50(((B1(2)-1)*5)+1:(((((B1(2)-1)*5)+1)+(B1(3)-1)*5)-1));
sagitalSerratoTrial4Pre50 = frontalSerratoPre50(((B1(3)-1)*5)+1:(((((B1(3)-1)*5)+1)+(B1(4)-1)*5)-1));
sagitalSerratoTrial5Pre50 = frontalSerratoPre50(((B1(4)-1)*5)+1:(((((B1(4)-1)*5)+1)+(B1(5)-1)*5)-1));

sagitalSerratoTrial1Pre100 = frontalSerratoPre100(1:(B2(1)-1)*5);
sagitalSerratoTrial2Pre100 = frontalSerratoPre100(((B2(1)-1)*5)+1:(((((B2(1)-1)*5)+1)+(B2(2)-1)*5)-1));
sagitalSerratoTrial3Pre100 = frontalSerratoPre100(((B2(2)-1)*5)+1:(((((B2(2)-1)*5)+1)+(B2(3)-1)*5)-1));
sagitalSerratoTrial4Pre100 = frontalSerratoPre100(((B2(3)-1)*5)+1:(((((B2(3)-1)*5)+1)+(B2(4)-1)*5)-1));
sagitalSerratoTrial5Pre100 = frontalSerratoPre100(((B2(4)-1)*5)+1:(((((B2(4)-1)*5)+1)+(B2(5)-1)*5)-1));

sagitalSerratoTrial1Post50 = frontalSerratoPost50(1:(B3(1)-1)*5);
sagitalSerratoTrial2Post50 = frontalSerratoPost50(((B3(1)-1)*5)+1:(((((B3(1)-1)*5)+1)+(B3(2)-1)*5)-1));
sagitalSerratoTrial3Post50 = frontalSerratoPost50(((B3(2)-1)*5)+1:(((((B3(2)-1)*5)+1)+(B3(3)-1)*5)-1));
sagitalSerratoTrial4Post50 = frontalSerratoPost50(((B3(3)-1)*5)+1:(((((B3(3)-1)*5)+1)+(B3(4)-1)*5)-1));
sagitalSerratoTrial5Post50 = frontalSerratoPost50(((B3(4)-1)*5)+1:(((((B3(4)-1)*5)+1)+(B3(5)-1)*5)-1));

sagitalSerratoTrial1Post100 = frontalSerratoPost100(1:(B4(1)-1)*5);
sagitalSerratoTrial2Post100 = frontalSerratoPost100(((B4(1)-1)*5)+1:(((((B4(1)-1)*5)+1)+(B4(2)-1)*5)-1));
sagitalSerratoTrial3Post100 = frontalSerratoPost100(((B4(2)-1)*5)+1:(((((B4(2)-1)*5)+1)+(B4(3)-1)*5)-1));
sagitalSerratoTrial4Post100 = frontalSerratoPost100(((B4(3)-1)*5)+1:(((((B4(3)-1)*5)+1)+(B4(4)-1)*5)-1));
sagitalSerratoTrial5Post100 = frontalSerratoPost100(((B4(4)-1)*5)+1:(((((B4(4)-1)*5)+1)+(B4(5)-1)*5)-1));

sagitalTrapezioTrial1Pre50 = frontalTrapezioPre50(1:(B1(1)-1)*5);
sagitalTrapezioTrial2Pre50 = frontalTrapezioPre50(((B1(1)-1)*5)+1:(((((B1(1)-1)*5)+1)+(B1(2)-1)*5)-1));
sagitalTrapezioTrial3Pre50 = frontalTrapezioPre50(((B1(2)-1)*5)+1:(((((B1(2)-1)*5)+1)+(B1(3)-1)*5)-1));
sagitalTrapezioTrial4Pre50 = frontalTrapezioPre50(((B1(3)-1)*5)+1:(((((B1(3)-1)*5)+1)+(B1(4)-1)*5)-1));
sagitalTrapezioTrial5Pre50 = frontalTrapezioPre50(((B1(4)-1)*5)+1:(((((B1(4)-1)*5)+1)+(B1(5)-1)*5)-1));

sagitalTrapezioTrial1Pre100 = frontalTrapezioPre100(1:(B2(1)-1)*5);
sagitalTrapezioTrial2Pre100 = frontalTrapezioPre100(((B2(1)-1)*5)+1:(((((B2(1)-1)*5)+1)+(B2(2)-1)*5)-1));
sagitalTrapezioTrial3Pre100 = frontalTrapezioPre100(((B2(2)-1)*5)+1:(((((B2(2)-1)*5)+1)+(B2(3)-1)*5)-1));
sagitalTrapezioTrial4Pre100 = frontalTrapezioPre100(((B2(3)-1)*5)+1:(((((B2(3)-1)*5)+1)+(B2(4)-1)*5)-1));
sagitalTrapezioTrial5Pre100 = frontalTrapezioPre100(((B2(4)-1)*5)+1:(((((B2(4)-1)*5)+1)+(B2(5)-1)*5)-1));

sagitalTrapezioTrial1Post50 = frontalTrapezioPost50(1:(B3(1)-1)*5);
sagitalTrapezioTrial2Post50 = frontalTrapezioPost50(((B3(1)-1)*5)+1:(((((B3(1)-1)*5)+1)+(B3(2)-1)*5)-1));
sagitalTrapezioTrial3Post50 = frontalTrapezioPost50(((B3(2)-1)*5)+1:(((((B3(2)-1)*5)+1)+(B3(3)-1)*5)-1));
sagitalTrapezioTrial4Post50 = frontalTrapezioPost50(((B3(3)-1)*5)+1:(((((B3(3)-1)*5)+1)+(B3(4)-1)*5)-1));
sagitalTrapezioTrial5Post50 = frontalTrapezioPost50(((B3(4)-1)*5)+1:(((((B3(4)-1)*5)+1)+(B3(5)-1)*5)-1));

sagitalTrapezioTrial1Post100 = frontalTrapezioPost100(1:(B4(1)-1)*5);
sagitalTrapezioTrial2Post100 = frontalTrapezioPost100(((B4(1)-1)*5)+1:(((((B4(1)-1)*5)+1)+(B4(2)-1)*5)-1));
sagitalTrapezioTrial3Post100 = frontalTrapezioPost100(((B4(2)-1)*5)+1:(((((B4(2)-1)*5)+1)+(B4(3)-1)*5)-1));
sagitalTrapezioTrial4Post100 = frontalTrapezioPost100(((B4(3)-1)*5)+1:(((((B4(3)-1)*5)+1)+(B4(4)-1)*5)-1));
sagitalTrapezioTrial5Post100 = frontalTrapezioPost100(((B4(4)-1)*5)+1:(((((B4(4)-1)*5)+1)+(B4(5)-1)*5)-1));

clear A i j B1 B2 B3 B4