function graph_sample(ind, y, yhat, n, sd)
f=figure('Color','w');
grid on
load('tSpan.mat');
t=tSpan;
plot(t,y(:,5)+y(:,6),'k-',t(ind),yhat,'bo')
legend('Dead - True', 'Dead - Sampled', 'Location','Northeast')
%xlim([0,75])
ylim([0,max(yhat)*1.05])
title(['Sampled Data vs True',sprintf('\n'),'Sample Size: ', sprintf('%d',n), '   Standard Deviation of Noise: ',sprintf('%0.1f',sd)], 'Fontsize',12)
xlabel('Days','Fontsize',10)
ylabel('Population','Fontsize',10)
