%====================================%
% calculate bed height
%====================================%
close all;
clear;
clc;
tstep = 80000;
t = (tstep-40000)*0.00001;
ustart = 0.06;
uend = 0.1;
tstart = 3;
tend = 18;

u = t/(tend-tstart)*(uend-ustart)+ustart;
fid = fopen('dump451000.liggghts_run');
formatSpec = [repmat('%f',[1,10])];
data = textscan(fid,formatSpec,'HeaderLines',9,'delimiter',' ','MultipleDelimsAsOne',1, 'CollectOutput',1);
fclose(fid);
posZ = data{1,1}(:,5);
[a,b] = size(posZ);
sortarray =reshape(posZ , 1 ,a*b);
sortposZ = sort(sortarray);
max40 = find(posZ > sortposZ(a-1));
mean(posZ(max40,1))

