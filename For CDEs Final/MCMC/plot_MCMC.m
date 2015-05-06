function plot_MCMC(beta1_dist, beta2_dist, beta3_dist, err_dist,beta1,beta2,beta3,beta1_hat,beta2_hat,beta3_hat)

figure('Color','w')
subplot(2,4,1)
hist(beta1_dist,500);
h=hist(beta1_dist,500);
line([beta1_hat beta1_hat],[min(h),max(h)],'Color','r');
line([beta1 beta1],[min(h),max(h)],'Color','k');
title('$\beta_1$ Distribution','interpreter','latex')
subplot(2,4,5)
plot(beta1_dist)
title('$\beta_1$ Trace','interpreter','latex')

subplot(2,4,2)
hist(beta2_dist,500)
h=hist(beta2_dist,500);
line([beta2_hat beta2_hat],[min(h),max(h)],'Color','r');
line([beta2 beta2],[min(h),max(h)],'Color','k');
title('$\beta_2$ Distribution','interpreter','latex')
subplot(2,4,6)
plot(beta2_dist)
title('$\beta_2$ Trace','interpreter','latex')

subplot(2,4,3)
hist(beta3_dist,500)
title('$\beta_3$ Distribution','interpreter','latex')
h=hist(beta3_dist,500);
line([beta3_hat beta3_hat],[min(h),max(h)],'Color','r');
line([beta3 beta3],[min(h),max(h)],'Color','k');
subplot(2,4,7)
plot(beta3_dist)
title('$\beta_3$ Trace','interpreter','latex')

subplot(2,4,4)
hist(err_dist,500)
title('Error Distribution','interpreter','latex')
subplot(2,4,8)
plot(err_dist)
title('Error Trace','interpreter','latex')