
clc; clear;
disp('clearing variables')

subjects = "Subject03";

disp(['target subject:', subjects])

targetSubject = subjects;

% Working directory between workstations
if exist("C:/Users/Usuario/", 'dir')
    destination = "C:/Users/Usuario/";
else
    destination = "C:/Users/VICON/";
end

target1 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_EPOC\",targetSubject,"/EB1.csv"],"");
target2 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_EPOC\",targetSubject,"/EB2.csv"],"");
target3 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_EPOC\",targetSubject,"/EB3.csv"],"");

target4 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_EPOC\",targetSubject,"/EP1.csv"],"");
target5 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_EPOC\",targetSubject,"/EP2.csv"],"");
target6 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_EPOC\",targetSubject,"/EP3.csv"],"");

target7 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_EPOC\",targetSubject,"/ET1.csv"],"");
target8 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_EPOC\",targetSubject,"/ET2.csv"],"");
target9 = join([destination, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Kine_EPOC\",targetSubject,"/ET3.csv"],"");

% store data into variables 
trialsEB = [target1, target2, target3];
trialsEP = [target4, target5, target6];
trialsET = [target7, target8, target9];

disp('begin calculations')
%since data has different size, avoid cells and use struct instead

perimeter.EB1 = calculatePerimeter(trialsEB(1));
perimeter.EB2 = calculatePerimeter(trialsEB(2));
perimeter.EB3 = calculatePerimeter(trialsEB(3));

perimeter.EP1 = calculatePerimeter(trialsEP(1));
perimeter.EP2 = calculatePerimeter(trialsEP(2));
perimeter.EP3 = calculatePerimeter(trialsEP(3));

perimeter.ET1 = calculatePerimeter(trialsET(1));
perimeter.ET2 = calculatePerimeter(trialsET(2));
perimeter.ET3 = calculatePerimeter(trialsET(3));


emg.EB1 = extractEmg(trialsEB(1));
emg.EB2 = extractEmg(trialsEB(2));
emg.EB3 = extractEmg(trialsEB(3));

emg.EP1 = extractEmg(trialsEP(1));
emg.EP2 = extractEmg(trialsEP(2));
emg.EP3 = extractEmg(trialsEP(3));

emg.ET1 = extractEmg(trialsET(1));
emg.ET2 = extractEmg(trialsET(2));
emg.ET3 = extractEmg(trialsET(3));


clearvars -except perimeter emg

disp('done')


function perimeter = calculatePerimeter(y)

data = readmatrix(y);

idx_end = data(end,1);
idx_start = data(4,1);

if idx_start ~= 0
    idx_end = data(end,1) - idx_start+1;
    idx_start = 1;
end

modelstart = (((idx_end+1))*20)-8;
modelend = modelstart+ (idx_end-idx_start);

CPostero(:,1) = data(modelstart-3:modelend-3,3);
CPostero(:,2) = data(modelstart-3:modelend-3,4);
CPostero(:,3) = data(modelstart-3:modelend-3,5);
LPostero(:,1) = data(modelstart-3:modelend-3,6);
LPostero(:,2) = data(modelstart-3:modelend-3,7);
LPostero(:,3) = data(modelstart-3:modelend-3,8);
RPostero(:,1) = data(modelstart-3:modelend-3,9);
RPostero(:,2) = data(modelstart-3:modelend-3,10);
RPostero(:,3) = data(modelstart-3:modelend-3,11);
CAntero(:,1) = data(modelstart-3:modelend-3,12);
CAntero(:,2) = data(modelstart-3:modelend-3,13);
CAntero(:,3) = data(modelstart-3:modelend-3,14);
LAntero(:,1) = data(modelstart-3:modelend-3,15);
LAntero(:,2) = data(modelstart-3:modelend-3,16);
LAntero(:,3) = data(modelstart-3:modelend-3,17);
RAntero(:,1) = data(modelstart-3:modelend-3,18);
RAntero(:,2) = data(modelstart-3:modelend-3,19);
RAntero(:,3) = data(modelstart-3:modelend-3,20);
RDorsal1(:,1) = data(modelstart-3:modelend-3,21);
RDorsal1(:,2) = data(modelstart-3:modelend-3,22);
RDorsal1(:,3) = data(modelstart-3:modelend-3,23);
RDorsal2(:,1) = data(modelstart-3:modelend-3,24);
RDorsal2(:,2) = data(modelstart-3:modelend-3,25);
RDorsal2(:,3) = data(modelstart-3:modelend-3,26);
LDorsal1(:,1) = data(modelstart-3:modelend-3,27);
LDorsal1(:,2) = data(modelstart-3:modelend-3,28);
LDorsal1(:,3) = data(modelstart-3:modelend-3,29);
LDorsal2(:,1) = data(modelstart-3:modelend-3,30);
LDorsal2(:,2) = data(modelstart-3:modelend-3,31);
LDorsal2(:,3) = data(modelstart-3:modelend-3,32);

l = modelend-modelstart;

perimeter = zeros(l,1);
distance = zeros(10,1);
% data is in mm

for i=1:l
    point = [CPostero(i,:); LPostero(i,:); LDorsal2(i,:); LDorsal1(i,:); LAntero(i,:); CAntero(i,:); RAntero(i,:); RDorsal1(i,:); RDorsal2(i,:); RPostero(i,:); CPostero(i,:)];
    pointxy = [point(:,1), point(:,2)];
    pointxz = [point(:,1), point(:,3)];
    pointyz = [point(:,2), point(:,3)];

    %plot3(point(:,1), point(:,2), point(:,3))
    %hold on

    for j = 1:10
        point1 = [point(j,1),point(j,2)];
        point2 = [point(j+1,1),point(j+1,2)];
        %distance(:,j) = pdist2(point1, point2, 'euclidean');

        % lets calculate the distance between three-dimensional points
        % (x2-x1)^2 + (y2-y1)^2 + (z2-z1)^2 === norm
        % store the values in distance for further calculations
        distance(j,:) = norm(point1-point2);
    end
    %calculate perimeter by sum of distances between points, then, transform
    %to cm
    perimeter(i,:) = sum(distance)/10;
end

end

function outputChannels = extractEmg(y)
data = readmatrix(y);

idx_end = data(end,1);
idx_start = data(4,1);

if idx_start ~= 0
    idx_end = data(end,1) - idx_start+1;
    idx_start = 1;
end

modelstart = idx_start;
modelend = (idx_end*20)+3;

EMG7 = data(4:modelend,9);
EMG8 = data(4:modelend,10);
EMG9 = data(4:modelend,11);
EMG10 = data(4:modelend,12);
EMG11 = data(4:modelend,13);
EMG12 = data(4:modelend,14);

outputChannels = [EMG7, EMG8, EMG9, EMG10, EMG11, EMG12];

end
