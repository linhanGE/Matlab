bubbleposition =  'position_restart_1.txt';
bubblevelocity =  'velocity_restart_1.txt';
delimiterIn = ' ';
% headerlinesIn = 4;
V_bubble = importdata(bubblevelocity,delimiterIn);
P_bubble = importdata(bubbleposition,delimiterIn);
t = 1;
x = 2;
y = 3;
z = 4;
ts = (0.6-0.23)/0.000001+1;
te = (1.2-0.23)/0.000001+1;
figure(1);
plot(V_bubble.data(:,t),V_bubble.data(:,z));
figure(2);
plot(P_bubble.data(:,t),P_bubble.data(:,z));
figure(3);
plot(P_bubble.data(:,y),P_bubble.data(:,z));
mean(V_bubble.data(ts:te,z))
mean(max(P_bubble.data(:,z))-min(P_bubble.data(:,z)))/(max(P_bubble.data(:,t))-min(P_bubble.data(:,t)))
