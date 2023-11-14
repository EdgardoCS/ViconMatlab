
%perimeterEB
%perimeterEP
%perimeterET

load data\sujeto5.mat

data = perimeter.EB1;
plot(data)
findchangepts(data,MaxNumChanges=10,Statistic="rms")