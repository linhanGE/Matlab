jl = 0.14387303;
jg = 0.013565171;
g = 9.81;
rho_b = 1.205;
rho_l = 1000;
miu_l = 0.001;
miu_g = 0.00001846;
d = 0.0009535;
syms epsilon_g
Ar_v=d^3*g*rho_l*abs(rho_b-rho_l)/miu_l^2;
miu_m = miu_l*(1-epsilon_g)^(-5*(miu_g+0.4*miu_l)/(2*(miu_g+miu_l)))
f = sqrt((1-epsilon_g))*(miu_l/miu_m);
rb_ = d/2*(g*rho_l^2/miu_l^2)^(1/3);
h = 0.55*((1+0.08*(rb_^3))^(4/7)-1)^(3/4);
g_ = f*sqrt(1-epsilon_g)*(1+h)/(1+h*f^(6/7));
Vt = (g*miu_l*abs(rho_b-rho_l)/rho_l^2)^(1/3)*((18/Ar_v^(2/3))^0.824+(0.321/Ar_v^(1/3))^0.412)^(-1.214);
jg_= jg*(1-epsilon_g)-jl*epsilon_g;
eq = jg_- epsilon_g*(1-epsilon_g)*Vt*g
db = solve(eq,'epsilon_g');



