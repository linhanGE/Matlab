% clear;
% clc;
u = 0.1:0.01:0.22;
el = (u/0.74).^(1/2.39);
plot(u,el,'k-','Linewidth',1.2);
hold on;
plot(ul_e,el_e,'b-','Linewidth',1.2);
set(gca, 'fontsize', 14);
% set(gca,'xtick',0:1:15);
set(gca, 'XMinorTick', 'on');
set(gca, 'YMinorTick', 'on');
set(gca, 'LineWidth', 1);
xlabel('Superfacial liquid velocity, u_L, m/s', 'fontsize', 14);
ylabel('Liquid voidage, \epsilon_L', 'fontsize', 14);
% legend('simulation','analytical(Ergun)');
% axis([0.0,t_sim(end),0,8000])
print(gcf, '-dpng', '-r280', 'pressuredrop');