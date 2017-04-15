% clc;
% clear;
% fid = fopen('p');
% formatSpec = [repmat('%f',[1,11])];
% data = textscan(fid,formatSpec,'CommentStyle','#','delimiter',' ','MultipleDelimsAsOne',1, 'CollectOutput',1);
% fclose(fid);
%====================================%
% import pressure data
%====================================%
rhoL = 1000;		% density in kg/m3
% [x,y]=size(data{1,1});
% dp_sim = (data{1,1}(:,4)-data{1,1}(:,5))*rhoL; %conversion to Pa!
% t_sim = data{1,1}(:,1);
%====================================%
% analytical calculation
%====================================%
%===================
% Ergun Equation
%===================
fprintf('\ncalc Ergun eqn:\n')
dp = 0.008;			% particle diameter
phip = 1;			% sphericity
epsilon = 0.4% voidfraction
% Ustart = 0.06;
% Uend = 0.06;
% timeStepSize = 0.00001;            % time interval of pressure data{1,1}
% Tstart = 0;
% Tend = t_sim(length(t_sim));
% tendstep = length(t_sim);
% deltaU=(Uend-Ustart)/((Tend-Tstart)/timeStepSize);
% U = Ustart*ones(length(t_sim),1);  % velocity over time
% Ua = U / epsilon;		% physical velocity
% L = 0.06;			% length of bed
nuL = 1e-6;			% kinemat Visk in m2/s
muL = nuL*rhoL;			% dynam visc in Pa s

% dpAna= 4890*(7800-1000)*9.81*1/6*pi*0.003^3*ones(length(t_sim),1)/(1/4*pi*0.05^2);
% 
% 
% fprintf('NOTE: this pressure is divided by density (according to CFD solver)\n')
% fprintf('so the result does not depend on density\n')

%==================================
% min fluidization velocity in m/s
%==================================
rhoP = 2230;                     % particle density in kg/m3
g = 9.81;                        % gravity m/s2
Umf = sqrt(dp*(rhoP-rhoL)*g/(1.75*rhoL)*epsilon^3*phip)
ReMF = Umf*dp*rhoL/muL;
if(ReMF<20)
    fprintf('applying eqn1 for Umf.\n')
elseif(ReMF>20 && ReMF<1000)
    fprintf('applying eqn1 for Umf.\n')
elseif (ReMF>=1000)
    fprintf('applying eqn2 for Umf.\n')
    Umf = sqrt(dp*(rhoP-rhoL)*g/(1.75*rhoL)*epsilon^3*phip);
    ReMF = Umf*dp*rhoL/muL;
end

% dpUmf= L * (150*((1-epsilon)^2/epsilon^3)*((muL.*Umf)/(phip*dp)^2)+1.75*((1-epsilon)/epsilon^3)*((rhoL.*Umf.^2)/(phip*dp)));
% %====================================%
% % plot data
% %====================================%
% % plot(U,dp_sim,'k-','Linewidth',1);
% % plot(U,dpErgun,U,dp_sim,[Umf,Uend],dpUmf*ones(1,2))
% % hold on;
% plot(t_sim,dp_sim,'k-','Linewidth',1.2);
% hold on;
% plot(t_sim,dpAna,'r-','Linewidth',1.2)
% set(gca, 'fontsize', 14);
% % set(gca,'xtick',0:1:15);
% set(gca, 'XMinorTick', 'on');
% set(gca, 'YMinorTick', 'on');
% set(gca, 'LineWidth', 1);
% xlabel('Time, s', 'fontsize', 14);
% ylabel('Pressure drop, Pa', 'fontsize', 14);
% legend('simulation','Eq.*');
% axis([0,t_sim(end),1000,3500])
% print(gcf, '-dpng', '-r280', 'pressuredrop');