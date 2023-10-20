
%perimeterEB
%perimeterEP
%perimeterET

load data\sujeto3.mat

data = perimeter.ET1;
plot(data)
findchangepts(data,MaxNumChanges=10,Statistic="rms")