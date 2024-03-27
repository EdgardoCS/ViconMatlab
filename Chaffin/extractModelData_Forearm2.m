% Created by E.Silva 26/03/24
% Last modification: 26/03/24

% Calculate time of resting arm on desktop from model output marker
% Forearm2 (z axis)

clc; clear;

subjects = [
    "Subject01","Subject02","Subject03","Subject04","Subject05","Subject06",...
    "Subject07","Subject08","Subject09","Subject10","Subject11","Subject12",...
    "Subject13", "Subject14","Subject15","Subject16","Subject17","Subject18",...
    "Subject19","Subject20", "Subject21","Subject22","Subject23","Subject24",...
    "Subject25","Subject26","Subject27", "Subject28","Subject29","Subject30",...
    "Subject31","Subject32","Subject33","Subject34",...
    ];

for i=1:length(subjects)
    targetSubject = subjects(i);

    clearvars -except subjects targetSubject;
    % Working directory between workstations
    if exist("C:/Users/Usuario/", 'dir')
        destination = "C:/Users/Usuario/";
    else
        destination = "C:/Users/VICON/";
    end

    target1 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_Escritorio\Data\Experiment\",targetSubject,"/Escritura01.csv"],"");
    target2 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_Escritorio\Data\Experiment\",targetSubject,"/Escritura02.csv"],"");
    target3 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_Escritorio\Data\Experiment\",targetSubject,"/Lectura01.csv"],"");
    target4 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_Escritorio\Data\Experiment\",targetSubject,"/Lectura02.csv"],"");
    target5 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_Escritorio\Data\Experiment\",targetSubject,"/Digitacion01.csv"],"");
    target6 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_Escritorio\Data\Experiment\",targetSubject,"/Digitacion02.csv"],"");
    % target7 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_Escritorio\Data\Experiment\",targetSubject,"/FittsPc01.csv"],"");
    % target8 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_Escritorio\Data\Experiment\",targetSubject,"/FittsPc02.csv"],"");
    % target9 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_Escritorio\Data\Experiment\",targetSubject,"/FittsTablet01.csv"],"");
    % target10 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_Escritorio\Data\Experiment\",targetSubject,"/FittsTablet02.csv"],"");
    target11 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_Escritorio\Data\Experiment\",targetSubject,"/Manipulacion01.csv"],"");
    target12 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_Escritorio\Data\Experiment\",targetSubject,"/Manipulacion02.csv"],"");

    %%
    data = readmatrix(target1);
    idx_start = data(4,1);
    idx_end = data(end,1);

    modelstart = (((idx_end-idx_start)+2)*20)-2;
    modelend = modelstart+idx_end-idx_start;

    C01_T1_Forearm(:,1) = data(modelstart-9:modelend-9,39); %x Column 39 (AM)
    C01_T1_Forearm(:,2) = data(modelstart-9:modelend-9,40); %y Column 40 (AN)
    C01_T1_Forearm(:,3) = data(modelstart-9:modelend-9,41); %z Column 41 (AO)

    %%
    data = readmatrix(target2);
    idx_start = data(4,1);
    idx_end = data(end,1);

    modelstart = (((idx_end-idx_start)+2)*20)-2;
    modelend = modelstart+idx_end-idx_start;

    C02_T1_Forearm(:,1) = data(modelstart-9:modelend-9,39); %x Column 39 (AM)
    C02_T1_Forearm(:,2) = data(modelstart-9:modelend-9,40); %y Column 40 (AN)
    C02_T1_Forearm(:,3) = data(modelstart-9:modelend-9,41); %z Column 41 (AO)

    %%
    data = readmatrix(target3);
    idx_start = data(4,1);
    idx_end = data(end,1);

    modelstart = (((idx_end-idx_start)+2)*20)-2;
    modelend = modelstart+idx_end-idx_start;

    C01_T2_Forearm(:,1) = data(modelstart-9:modelend-9,39);
    C01_T2_Forearm(:,2) = data(modelstart-9:modelend-9,40);
    C01_T2_Forearm(:,3) = data(modelstart-9:modelend-9,41);

    %%
    data = readmatrix(target4);
    idx_start = data(4,1);
    idx_end = data(end,1);

    modelstart = (((idx_end-idx_start)+2)*20)-2;
    modelend = modelstart+idx_end-idx_start;

    C02_T2_Forearm(:,1) = data(modelstart-9:modelend-9,39);
    C02_T2_Forearm(:,2) = data(modelstart-9:modelend-9,40);
    C02_T2_Forearm(:,3) = data(modelstart-9:modelend-9,41);

    %%
    data = readmatrix(target5);
    idx_start = data(4,1);
    idx_end = data(end,1);

    modelstart = (((idx_end-idx_start)+2)*20)-2;
    modelend = modelstart+idx_end-idx_start;

    C01_T3_Forearm(:,1) = data(modelstart-9:modelend-9,39);
    C01_T3_Forearm(:,2) = data(modelstart-9:modelend-9,40);
    C01_T3_Forearm(:,3) = data(modelstart-9:modelend-9,41);

    %%
    data = readmatrix(target6);
    idx_start = data(4,1);
    idx_end = data(end,1);

    modelstart = (((idx_end-idx_start)+2)*20)-2;
    modelend = modelstart+idx_end-idx_start;

    C02_T3_Forearm(:,1) = data(modelstart-9:modelend-9,39);
    C02_T3_Forearm(:,2) = data(modelstart-9:modelend-9,40);
    C02_T3_Forearm(:,3) = data(modelstart-9:modelend-9,41);

    %%
    data = readmatrix(target11);
    idx_start = data(4,1);
    idx_end = data(end,1);

    modelstart = (((idx_end-idx_start)+2)*20)-2;
    modelend = modelstart+idx_end-idx_start;

    C01_T6_Forearm(:,1) = data(modelstart-9:modelend-9,39);
    C01_T6_Forearm(:,2) = data(modelstart-9:modelend-9,40);
    C01_T6_Forearm(:,3) = data(modelstart-9:modelend-9,41);

    %%
    data = readmatrix(target12);
    idx_start = data(4,1);
    idx_end = data(end,1);

    modelstart = (((idx_end-idx_start)+2)*20)-2;
    modelend = modelstart+idx_end-idx_start;

    C02_T6_Forearm(:,1) = data(modelstart-9:modelend-9,39);
    C02_T6_Forearm(:,2) = data(modelstart-9:modelend-9,40);
    C02_T6_Forearm(:,3) = data(modelstart-9:modelend-9,41);

    %%
                                                                                                                           
    C = strsplit(targetSubject,'t');
    targetFile = join(["FS",C(2),".mat"],"");

    disp(join(['saving data...',targetFile],""))

    save(targetFile, ...
        "C01_T1_Forearm", ...
        "C01_T2_Forearm", ...
        "C01_T3_Forearm", ...
        "C01_T6_Forearm", ...
        "C02_T1_Forearm", ...
        "C02_T2_Forearm", ...
        "C02_T3_Forearm", ...
        "C02_T6_Forearm"...
        )

end

disp ('All Done')
