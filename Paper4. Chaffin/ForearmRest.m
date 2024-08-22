clear; clc;

f = [
    "FS01", "FS02", "FS03", "FS04", "FS05",...
    "FS06", "FS07", "FS08", "FS09", "FS10", ...
    "FS11", "FS12", "FS13", "FS14", "FS15",...
    "FS16", "FS17", "FS18", "FS19", "FS20", ...
    "FS21", "FS22", "FS23", "FS24", "FS25",...
    "FS26", "FS27", "FS28", "FS29", "FS30", ...
    "FS31", "FS32", "FS33", "FS34"...
    ];

for i =1:length(f)
    target = f(i);
    destination = join([pwd, "/Analysis/Model/",target,".mat"],"");
    load(destination)

    C01_Ref = mean(Reference_01);
    C02_Ref = mean(Reference_02);

    %Task 1
    counter_t1_c01 = 0;
    t = C01_T1_Forearm(:,3); % z axis;
    for a = 1:length(t)
        if t(a) < C01_Ref
            counter_t1_c01 = counter_t1_c01 + 1;
        end
    end
    %Task 2
    counter_t2_c01 = 0;
    t = C01_T2_Forearm(:,3); % z axis;
    for a = 1:length(t)
        if t(a) < C01_Ref
            counter_t2_c01 = counter_t2_c01 + 1;
        end
    end
    %Task 3
    counter_t3_c01 = 0;
    t = C01_T3_Forearm(:,3); % z axis;
    for a = 1:length(t)
        if t(a) < C01_Ref
            counter_t3_c01 = counter_t3_c01 + 1;
        end
    end
    %Task 4
    counter_t4_c01 = 0;
    t = C01_T4_Forearm(:,3); % z axis;
    for a = 1:length(t)
        if t(a) < C01_Ref
            counter_t4_c01 = counter_t4_c01 + 1;
        end
    end
    %Task 5
    counter_t5_c01 = 0;
    t = C01_T5_Forearm(:,3); % z axis;
    for a = 1:length(t)
        if t(a) < C01_Ref
            counter_t5_c01 = counter_t5_c01 + 1;
        end
    end
    %Task 6
    counter_t6_c01 = 0;
    t = C01_T6_Forearm(:,3); % z axis;
    for a = 1:length(t)
        if t(a) < C01_Ref
            counter_t6_c01 = counter_t6_c01 + 1;
        end
    end
    %%
    %Task 1
    counter_t1_c02 = 0;
    t = C02_T1_Forearm(:,3); % z axis;
    for a = 1:length(t)
        if t(a) < C02_Ref
            counter_t1_c02 = counter_t1_c02 + 1;
        end
    end
    %Task 2
    counter_t2_c02 = 0;
    t = C02_T2_Forearm(:,3); % z axis;
    for a = 1:length(t)
        if t(a) < C02_Ref
            counter_t2_c02 = counter_t2_c02 + 1;
        end
    end
    %Task 3
    counter_t3_c02 = 0;
    t = C02_T3_Forearm(:,3); % z axis;
    for a = 1:length(t)
        if t(a) < C02_Ref
            counter_t3_c02 = counter_t3_c02 + 1;
        end
    end
    %Task 4
    counter_t4_c02 = 0;
    t = C02_T4_Forearm(:,3); % z axis;
    for a = 1:length(t)
        if t(a) < C02_Ref
            counter_t4_c02 = counter_t4_c02 + 1;
        end
    end
    %Task 5
    counter_t5_c02 = 0;
    t = C02_T5_Forearm(:,3); % z axis;
    for a = 1:length(t)
        if t(a) < C02_Ref
            counter_t5_c02 = counter_t5_c02 + 1;
        end
    end

    %Task 6
    counter_t6_c02 = 0;
    t = C02_T6_Forearm(:,3); % z axis;
    for a = 1:length(t)
        if t(a) < C02_Ref
            counter_t6_c02 = counter_t6_c02 + 1;
        end
    end
    %%
    Task1(i,1) = counter_t1_c01/100; %frames to seconds
    Task1(i,2) = (length(C01_T1_Forearm)-counter_t1_c01)/100;
    Task1(i,3) = length(C01_T1_Forearm)/100;
    Task1(i,4) = counter_t1_c02/100; %frames to seconds
    Task1(i,5) = (length(C02_T1_Forearm)-counter_t1_c02)/100;
    Task1(i,6) = length(C02_T1_Forearm)/100;

    Task2(i,1) = counter_t2_c01/100; %frames to seconds
    Task2(i,2) = (length(C01_T2_Forearm)-counter_t2_c01)/100;
    Task2(i,3) = length(C01_T2_Forearm)/100;
    Task2(i,4) = counter_t2_c02/100; %frames to seconds
    Task2(i,5) = (length(C02_T2_Forearm)-counter_t2_c02)/100;
    Task2(i,6) = length(C02_T2_Forearm)/100;

    Task3(i,1) = counter_t3_c01/100; %frames to seconds
    Task3(i,2) = (length(C01_T3_Forearm)-counter_t3_c01)/100;
    Task3(i,3) = length(C01_T3_Forearm)/100;
    Task3(i,4) = counter_t3_c02/100; %frames to seconds
    Task3(i,5) = (length(C02_T3_Forearm)-counter_t3_c02)/100;
    Task3(i,6) = length(C02_T3_Forearm)/100;

    Task4(i,1) = counter_t4_c01/100; %frames to seconds
    Task4(i,2) = (length(C01_T4_Forearm)-counter_t4_c01)/100;
    Task4(i,3) = length(C01_T4_Forearm)/100;
    Task4(i,4) = counter_t4_c02/100; %frames to seconds
    Task4(i,5) = (length(C02_T4_Forearm)-counter_t4_c02)/100;
    Task4(i,6) = length(C02_T4_Forearm)/100;

    Task5(i,1) = counter_t5_c01/100; %frames to seconds
    Task5(i,2) = (length(C01_T5_Forearm)-counter_t5_c01)/100;
    Task5(i,3) = length(C01_T5_Forearm)/100;
    Task5(i,4) = counter_t5_c02/100; %frames to seconds
    Task5(i,5) = (length(C02_T5_Forearm)-counter_t5_c02)/100;
    Task5(i,6) = length(C02_T5_Forearm)/100;

    Task6(i,1) = counter_t6_c01/100; %frames to seconds
    Task6(i,2) = (length(C01_T6_Forearm)-counter_t6_c01)/100;
    Task6(i,3) = length(C01_T6_Forearm)/100;
    Task6(i,4) = counter_t6_c02/100; %frames to seconds
    Task6(i,5) = (length(C02_T6_Forearm)-counter_t6_c02)/100;
    Task6(i,6) = length(C02_T6_Forearm)/100;


end
Columns = {'Brazo Apoyado_C01'; 'Brazo NO Apoyado_C01';'Duración Total1'; 'Brazo Apoyado_C02'; 'Brazo NO Apoyado_C02'; 'Duración Total2'};
T1 = table(Task1(:,1),Task1(:,2),Task1(:,3),Task1(:,4) ,Task1(:,5) ,Task1(:,6) , 'VariableNames',Columns);
T2 = table(Task2(:,1),Task2(:,2),Task2(:,3),Task2(:,4) ,Task2(:,5) ,Task2(:,6) , 'VariableNames',Columns);
T3 = table(Task3(:,1),Task3(:,2),Task3(:,3),Task3(:,4) ,Task3(:,5) ,Task3(:,6) , 'VariableNames',Columns);
T4 = table(Task4(:,1),Task4(:,2),Task4(:,3),Task4(:,4) ,Task4(:,5) ,Task4(:,6) , 'VariableNames',Columns);
T5 = table(Task5(:,1),Task5(:,2),Task5(:,3),Task5(:,4) ,Task5(:,5) ,Task5(:,6) , 'VariableNames',Columns);
T6 = table(Task6(:,1),Task6(:,2),Task6(:,3),Task6(:,4) ,Task6(:,5) ,Task6(:,6) , 'VariableNames',Columns);

writetable(T1,'Tarea1.xlsx');
writetable(T2,'Tarea2.xlsx');
writetable(T3,'Tarea3.xlsx');
writetable(T4,'Tarea4.xlsx');
writetable(T5,'Tarea5.xlsx');
writetable(T6,'Tarea6.xlsx');
