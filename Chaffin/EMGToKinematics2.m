% Created by E.Silva 27/05/23

clear; clc;

t = ["001", "002", "003", "004", "005", "006", ...
    "007", "008", "009", "010", "011", "012", ...
    "013", "014", "015", "016", "017", "018", ...
    "019", "020"];




targetMuscles = ["deltAnt" "deltMed" "serrAnt" "trapInf" "trapMed" "trapSup"];
targetTask = ["T1" "T2" "T3" "T4" "T5" "T6"];
targetCondition = ["C01" "C02"];

for m=1:length(t)

    if exist("C:/Users/Usuario/", 'dir')
        destination = ["C:/Users/Usuario/","OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Escritorio\Data\DataEMG\", t(m),"\"];
    else
        destination = ["C:/Users/VICON/","OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Escritorio\Data\DataEMG\", t(m),"\"];
    end

    targetData = join([destination, t(m),".mat"],"");
    load(targetData);

    tableData = [];
    x = 0;
    for i= 1:length(targetCondition)
        for j= 1:length(targetTask)
            for k=1:length(targetMuscles)
                x= x+1;
                % k = muscle; j = tastk; i = condition;
                % meanEMGPercentage(k,j,i);
                % maxEMGPercentage(k,j,i);
                % minEMGPercentage(k,j,i);
                % meanEMG(k,j,i);
                % onEMGTime(k,j,i);
                % offEMGTime(k,j,i);

                tableData(x,:)= [meanEMGPercentage(k,j,i), maxEMGPercentage(k,j,i), ...
                    minEMGPercentage(k,j,i), meanEMG(k,j,i), ...
                    onEMGTime(k,j,i) ,offEMGTime(k,j,i)];

            end
        end
    end

    Rows = {
        'DeltoideAnterior_Write1';
        'DeltoideMedio_Write1';
        'TrapecioSuperior_Write1';
        'TrapecioMedio_Write1';
        'TrapecioInferior_Write1';
        'SerratoAnterior_Write1';
        'DeltoideAnterior_Read1';
        'DeltoideMedio_Read1';
        'TrapecioSuperior_Read1';
        'TrapecioMedio_Read1';
        'TrapecioInferior_Read1';
        'SerratoAnterior_Read1';
        'DeltoideAnterior_Type1';
        'DeltoideMedio_Type1';
        'TrapecioSuperior_Type1';
        'TrapecioMedio_Type1';
        'TrapecioInferior_Type1';
        'SerratoAnterior_Type1';
        'DeltoideAnterior_FittsPc1';
        'DeltoideMedio_FittsPc1';
        'TrapecioSuperior_FittsPc1';
        'TrapecioMedio_FittsPc1';
        'TrapecioInferior_FittsPc1';
        'SerratoAnterior_FittsPc1';
        'DeltoideAnterior_FittsTablet1';
        'DeltoideMedio_FittsTablet1';
        'TrapecioSuperior_FittsTablet1';
        'TrapecioMedio_FittsTablet1';
        'TrapecioInferior_FittsTablet1';
        'SerratoAnterior_FittsTablet1';
        'DeltoideAnterior_Manipulate1';
        'DeltoideMedio_Manipulate1';
        'TrapecioSuperior_Manipulate1';
        'TrapecioMedio_Manipulate1';
        'TrapecioInferior_Manipulate1';
        'SerratoAnterior_Manipulate1';
        'DeltoideAnterior_Write2';
        'DeltoideMedio_Write2';
        'TrapecioSuperior_Write2';
        'TrapecioMedio_Write2';
        'TrapecioInferior_Write2';
        'SerratoAnterior_Write2';
        'DeltoideAnterior_Read2';
        'DeltoideMedio_Read2';
        'TrapecioSuperior_Read2';
        'TrapecioMedio_Read2';
        'TrapecioInferior_Read2';
        'SerratoAnterior_Read2';
        'DeltoideAnterior_Type2';
        'DeltoideMedio_Type2';
        'TrapecioSuperior_Type2';
        'TrapecioMedio_Type2';
        'TrapecioInferior_Type2';
        'SerratoAnterior_Type2';
        'DeltoideAnterior_FittsPc2';
        'DeltoideMedio_FittsPc2';
        'TrapecioSuperior_FittsPc2';
        'TrapecioMedio_FittsPc2';
        'TrapecioInferior_FittsPc2';
        'SerratoAnterior_FittsPc2';
        'DeltoideAnterior_FittsTablet2';
        'DeltoideMedio_FittsTablet2';
        'TrapecioSuperior_FittsTablet2';
        'TrapecioMedio_FittsTablet2';
        'TrapecioInferior_FittsTablet2';
        'SerratoAnterior_FittsTablet2';
        'DeltoideAnterior_Manipulate2';
        'DeltoideMedio_Manipulate2';
        'TrapecioSuperior_Manipulate2';
        'TrapecioMedio_Manipulate2';
        'TrapecioInferior_Manipulate2';
        'SerratoAnterior_Manipulate2'
        };

    Columns = {'meanEMGPercentage'; 'maxEMGPercentage'; 'minEMGPercentage'; 'meanEMGActivity(mV)'; 'muscleOnTime(s)'; 'muscleOffTime(s)'};

    modelOutput = table(tableData(:,1),tableData(:,2),tableData(:,3), ...
        tableData(:,4),tableData(:,5),tableData(:,6),...
        'RowNames',Rows, 'VariableNames',Columns);

    % Save to .xlsx
    filename = join([pwd,"/dataEMG/",t(m),"/", t(m),".xlsx"],"");
    writetable(modelOutput,filename,"WriteRowNames",true)

end

disp('Done')

% Save to .mat
% save(targetData,'modelOutput','-append')
