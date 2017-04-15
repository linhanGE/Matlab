clear;
clc;
uB = 0.00001:0.0000001:0.2; %bubble velocity range
uP = 0.0001:0.0000001:0.35; %particle velocity
mu = 0.001;
rhoL = 1000;
rhoB = 1.2;
rhoP = 2300;
g = 9.81;
dB = 0.001;
dP = 0.003;
V_B = 1/6*pi*dB^3;
V_P = 1/6*pi*dP^3;
m_B = rhoB * V_B;
m_P = rhoP * V_P;
Re_B = rhoL*uB*dB/mu;
Re_P = rhoL*uP*dP/mu;
C_DB = min(24./Re_B.*(1+0.15*Re_B.^0.687),72./Re_B); % single bubble drag coefficient, Tomiyama et al.
C_DP = 24./Re_P.*(1+0.15*Re_P.^0.687); % single particle drag coefficient, Schiller and Naumann 
nB = 1:1:length(uB);
nP = 1:1:length(uP);
bubble = rhoL*g*V_B - m_B*g-1/8*C_DB.*rhoL*pi*dB^2.*uB(nB).^2; %force balance of bubble
particle = rhoL*g*V_P + 1/8*C_DP.*rhoL*pi*dP^2.*uP(nP).^2 - m_P*g; %force balance of particle
[a,b] = min(abs(bubble));
[m,n] = min(abs(particle));
uP(n) % particle terminal velocity
uB(b) % bubble terminal velocity




