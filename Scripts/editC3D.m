
absPath = 'D:\Vicon Database\Tesis_Escritorio\Piloto\Piloto0405\';
target = 'NicolasC2Lectura.c3d';


c3d = ezc3dRead('D:\Vicon Database\Tesis_Escritorio\Piloto\Piloto0405\NicolasC2Lectura.c3d');
disp(c3d.parameters.POINT.USED.DATA);