clearvars -except S2DinamicoPostEscapular  S2DinamicoPreEscapular

%load('PostEscapularS2.mat')

time = table2array(S2DinamicoPostEscapular(:,1));
dataPre = table2array(S2DinamicoPreEscapular(:,84));
dataPost = table2array(S2DinamicoPostEscapular(:,11));


trials = 10;

data_sizePre = round(length(dataPre)/10);
data_sizePost = round(length(dataPost)/10);

my_dataPre = reshape(dataPre,data_sizePre,[]);
my_dataPost = reshape(dataPost,data_sizePost,[]);

angle_endPre = min(my_dataPre(:,:));
angle_startPre = max(my_dataPre(:,:));
angle_differencePre = angle_endPre-angle_startPre


angle_endPost = min(my_dataPost(:,:));
angle_startPost = max(my_dataPost(:,:));
angle_differencePost = angle_endPost-angle_startPost

% sort(angle_differencePre)
% sort(angle_differencePost)

