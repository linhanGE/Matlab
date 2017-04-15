clc;
clear;
rhoL = 1000;		% density in kg/m3
dp = 0.008;			% particle diameter
phip = 1;			% sphericity
epsilon = 0.4       % voidfraction
nuL = 1e-6;			% kinemat Visk in m2/s
muL = nuL*rhoL;		% dynam visc in Pa s
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