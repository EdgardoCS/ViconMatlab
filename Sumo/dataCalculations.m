clc; clear;

path = 'C:/Users/Usuario/';

trial1 = join([path, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Diseño_Matias\","Nl170-1.csv"],"");
trial2 = join([path, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Diseño_Matias\","Nl170-2.csv"],"");
trial3 = join([path, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Diseño_Matias\","Nl170-3.csv"],"");
trial4 = join([path, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Diseño_Matias\","Nl170-4.csv"],"");
trial5 = join([path, "OneDrive - uv.cl\LabErgonomía\ProyectosTesis\Pregrado_Diseño_Matias\","Nl170-5.csv"],"");

trials = [trial1, trial2, trial3];

ftOn = [18.47, 14.21, 24.64]*100;
ftOff = [23.37, 19.83, 30.22]*100;


data = readmatrix(trials(1));

time = data(4:end,1);

ft1 = [time,data(4:end,5)];
ft2 = [time,data(4:end,8)];
ft6 = [time,data(4:end,20)];
ft5 = [time,data(4:end,17)];
ft4 = [time,data(4:end,14)];
ft3 = [time,data(4:end,11)];

sole1 = [time,data(4:end,23)];
sole2 = [time,data(4:end,26)];
sole6 = [time,data(4:end,38)];
sole5 = [time,data(4:end,35)];
sole4 = [time,data(4:end,32)];
sole3 = [time,data(4:end,29)];

for a = 1:3
    for b = 1:length(ft1(:,1))
        if ft1(b,1) == ftOn(a)
            fstart = ft1(b,2)
        end
        if ft1(b,1) == ftOff(a)
            fend = ft1(b,2)
        end
    end
end

% subplot(3,1,1)
% plot(time1, ft1(:,2), 'b')
% hold on
% plot(time1, sole1(:,2), 'r')
% plot(time1, dif1, 'k')
% xline(ftOn, '-')
% xline(ftOff, '--')
% lgd = legend('Foot1','Shoe1', 'Difference');
%
% subplot(3,1,2)
% plot(time1, ft2(:,2), 'b')
% hold on
% plot(time1, sole2(:,2), 'r')
% plot(time1, dif2, 'k')
% xline(ftOn, '--')
% xline(ftOff, '--')
% lgd = legend('Foot2','Shoe2', 'Difference');
%
% subplot(3,1,3)
% plot(time1, ft3(:,2), 'b')
% hold on
% plot(time1, sole3(:,2), 'r')
% plot(time1, dif3, 'k')
% xline(ftOn, '--')
% xline(ftOff, '--')
% lgd = legend('Foot3','Shoe3', 'Difference');

