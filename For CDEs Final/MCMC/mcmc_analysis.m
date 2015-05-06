clear; clc;

% Test Parameters
sd=10; % standard deviation of noise
n = 50; %sample size
niter = 20000; %number of MCMC iterations
burnin = 10000; %number of MCMC iterations to discard


% Load All Necessary Data
load('tSpan.mat')
load('y0.mat')
load('true_parameters.mat')

ploton=1;

% Use True Parameters to Generate Data
[t, initial_data] = generate_data(alph, beta1, beta2, beta3, delta, gamma1, gamma2, p, rho1, rho2, omega, tSpan, y0);

%Graph Data
if ploton
graph_results(t,initial_data)
end

%Grab n data points (we will focus on modeling Rr + Rb)
[l,s]=size(initial_data);
ind=round(linspace(1,l,n));
data = initial_data(ind ,:);

%Add noise to sample size
dataD=data(:,5)+data(:,6) + sd*randn(n,1);

%Plot Sampled Data vs True
if ploton
graph_sample(ind,initial_data,dataD, n, sd);
end


% Run MCMC algorithm
[beta1_dist, beta2_dist, beta3_dist, err_dist] = MCMC(dataD,ind,niter, burnin);

%Estimate Parameters from MCMC Posterior Distribution
beta1_hat=mean(beta1_dist);
beta2_hat=mean(beta2_dist);
beta3_hat=mean(beta3_dist);
beta1_hat_sigma = var(beta1_dist);
beta2_hat_sigma = var(beta2_dist);
beta3_hat_sigma = var(beta3_dist);

%Plot Posterior Distributions
plot_MCMC(beta1_dist, beta2_dist, beta3_dist, err_dist, beta1,beta2,beta3,beta1_hat,beta2_hat,beta3_hat);

%Save Results
fname=strcat('sd',sprintf('%d',sd),'n',sprintf('%d',n),'.mat');
save(fname, 'beta1_hat','beta2_hat','beta3_hat','beta1_hat_sigma','beta2_hat_sigma','beta3_hat_sigma','beta1_dist','beta2_dist','beta3_dist','err_dist','sd','n');



