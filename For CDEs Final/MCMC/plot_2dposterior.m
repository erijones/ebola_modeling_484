function plot_2dposterior()

%load example data
load('sd5n50.mat')

%%
z = [beta1_dist; beta2_dist];
f = figure('Color','w');
hist3(z', [50,50]);
title('$\beta_1$ vs $\beta_2$ Marginal Posterior Distribution', 'Fontsize',14, 'interpreter','latex');
zlabel('Frequency','Fontsize',12,'interpreter','latex');
ylabel('$\beta_2$','Fontsize',12,'interpreter','latex');
xlabel('$\beta_1$','Fontsize',12,'interpreter','latex');

%%
z = [beta2_dist; beta3_dist];
f = figure('Color','w');
hist3(z',[50,50]);
title('$\beta_2$ vs $\beta_3$ Marginal Posterior Distribution', 'Fontsize',14, 'interpreter','latex');
zlabel('Frequency','Fontsize',12,'interpreter','latex');
xlabel('$\beta_2$','Fontsize',12,'interpreter','latex');
ylabel('$\beta_3$','Fontsize',12,'interpreter','latex');

%% 
z = [beta1_dist; beta3_dist];
f = figure('Color','w');
hist3(z',[50,50]);
title('$\beta_1$ vs $\beta_3$ Marginal Posterior Distribution', 'Fontsize',14, 'interpreter','latex');
zlabel('Frequency','Fontsize',12,'interpreter','latex');
ylabel('$\beta_3$','Fontsize',12,'interpreter','latex');
xlabel('$\beta_1$','Fontsize',12,'interpreter','latex');
