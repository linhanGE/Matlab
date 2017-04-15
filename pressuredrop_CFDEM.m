
fid = fopen('p');
formatSpec = [repmat('%f',[1,22])];
data = textscan(fid,formatSpec,'CommentStyle','#','delimiter',' ','MultipleDelimsAsOne',1, 'CollectOutput',1);
fclose(fid);
%====================================%
% import pressure data
%====================================%
rhoG = 10;		% density in kg/m3
[x,y]=size(data{1,1});
dp_sim = (data{1,1}(:,2)-data{1,1}(:,y))*rhoG*100; %conversion to Pa!
t_sim = data{1,1}(:,1);
%====================================%
% analytical calculation
%====================================%
%===================
% Ergun Equation
%===================
fprintf('\ncalc Ergun eqn:\n')
dp = 0.001;			% particle diameter
phip = 1;			% sphericity
epsilon = 0.435805976;  % voidfraction
Ustart = 0.002;
Uend = 0.02;
timeStepSize = 0.0005;            % time interval of pressure data{1,1}
Tstart = 0;
Tend = t_sim(length(t_sim));
% tendstep = length(t_sim);
deltaU=(Uend-Ustart)/((Tend-Tstart)/timeStepSize);
U = Ustart+deltaU:deltaU:Uend; % velocity over time
Ua = U / epsilon;		% physical velocity
L = 0.0154;			% length of bed
nuG = 1.5*10^-4;			% kinemat Visk in m2/s
muG = nuG*rhoG;			% dynam visc in Pa s

dpErgun= L * (150*((1-epsilon)^2/epsilon^3)*((muG.*U)/(phip*dp)^2)+1.75*((1-epsilon)/epsilon^3)*((rhoG.*U.^2)/(phip*dp)))*100;

fprintf('NOTE: this pressure is divided by density (according to CFD solver)\n')
fprintf('so the result does not depend on density\n')

%==================================
% min fluidization velocity in m/s
%==================================
rhoP = 2000;                     % particle density in kg/m3
g = 9.81;                        % gravity m/s2
Umf = dp^2*(rhoP-rhoG)*g/(150*muG)*(epsilon^3*phip^2)/(1-epsilon);
ReMF = Umf*dp*rhoG/muG;
if(ReMF<20)
    fprintf('applying eqn1 for Umf.\n')
elseif(ReMF>20 && ReMF<1000)
    fprintf('applying eqn1 for Umf.\n')
elseif (ReMF>=1000)
    fprintf('applying eqn2 for Umf.\n')
    Umf = sqrt(dp*(rhoP-rhoG)*g/(1.75*rhoG)*epsilon^3*phip);
    ReMF = Umf*dp*rhoG/muG;
end

dpUmf= L * (150*((1-epsilon)^2/epsilon^3)*((muG.*Umf)/(phip*dp)^2)+1.75*((1-epsilon)/epsilon^3)*((rhoG.*Umf.^2)/(phip*dp)));
%====================================%
% plot data
%====================================%
% plot(U,dp_sim,'k-','Linewidth',1);
% plot(U,dpErgun,U,dp_sim,[Umf,Uend],dpUmf*ones(1,2))
% hold on;
figure(2)
plot(U,dp_sim)
title('Ergun pressure drop vs. simulation')
a=strcat('analytical (Ergun), Umf=',num2str(Umf),', dpUmf=',num2str(dpUmf));
legend(a,'simulation')
xlabel('velocity in [m/s]')
ylabel('pressure drop [Pa]')
axis([0,Uend,0,dpErgun(length(dpErgun))])

figure(1)
plot(U,dpErgun,U,dp_sim,[Umf,Uend],dpUmf*ones(1,2))
title('Ergun pressure drop vs. simulation')
a=strcat('analytical (Ergun), Umf=',num2str(Umf),', dpUmf=',num2str(dpUmf));
legend(a,'simulation','analyt. deltaP at Umf','location','northwest')
xlabel('velocity in [m/s]')
ylabel('pressure drop [Pa]')
axis([0,Uend,0,dpErgun(length(dpErgun))])
print(gcf, '-dpng', '-r280', 'pressuredrop');