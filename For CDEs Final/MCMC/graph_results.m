function graph_results(t,y)
f=figure('Color','w');
grid on
load('tSpan.mat');
t=tSpan;
plot(t,y(:,2),'y-',t,y(:,3),'r-.',t,y(:,5)+y(:,6),'k-',t,y(:,7),'b-')
legend('E','I','R_I + R_B','R_R', 'Location','Northwest')
xlim([0,75])
title('Data From True Parameter Values', 'Fontsize',12)
xlabel('Days','Fontsize',10)
ylabel('Population','Fontsize',10)

