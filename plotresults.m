clear;
clc;
particle1position = 'position_particle_1.txt ';
particle2position = 'position_particle_2.txt ';
delimiterIn = ' ';
t = 1;
x = 2;
y = 3;
z = 4;
headerlinesIn = 1;
P_particle_1 = importdata(particle1position,delimiterIn,headerlinesIn);
P_particle_2 = importdata(particle2position,delimiterIn,headerlinesIn);
figure(1);
plot(P_particle_1.data(:,x),P_particle_1.data(:,z));
plot(P_particle_2.data(:,x),P_particle_2.data(:,z));
max(V_bubble.data(:,z))
figure(2);
plot(P_bubble.data(:,z),V_bubble.data(:,z));