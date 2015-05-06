function [beta1_dist, beta2_dist, beta3_dist, err_dist] = MCMC(yactual,ind, niter, burnin)

load('y0.mat')
load('true_parameters.mat')
load('tSpan.mat')

%initialize Beta Parameters
beta1=1.5e-8;
beta2=1e-9;
beta3=1.25e-9;
beta_old=[beta1,beta2,beta3];

beta1_dist = zeros(1,niter-burnin);
beta2_dist = zeros(1,niter-burnin);
beta3_dist = zeros(1,niter-burnin);
err_dist = zeros(1,niter-burnin);

mu_data = sum(yactual)/length(yactual);
var = sum((yactual-mu_data).^2)/(length(yactual)-1);



%Initialize 
[t, yhat] = generate_data(alph, beta1, beta2, beta3, delta, gamma1, gamma2, p, rho1, rho2, omega, tSpan, y0);
err_old=sum((yactual-(yhat(ind,5) + yhat(ind,6))).^2);

for i=1:niter
    
    % Print step
    if mod(i,500)==0
        fprintf('On iteration: %d \n',i)
    end
    

    
    % Randomly Sample from Parameter Space
    beta_new = beta_old+ 5e-10.*randn(1,3);
    [t,yhat_new] = generate_data(alph, beta_new(1), beta_new(2), beta_new(3), delta, gamma1, gamma2, p, rho1, rho2, omega, tSpan, y0);
    
    %Calculate new error
    err_new = sum((yactual-(yhat_new(ind,5) + yhat_new(ind,6))).^2);
    
    %Calculate likelihood ratio of old error to new error
    ratio = exp((-err_new+err_old)/2*var);
    
    r = rand(1,1); % a random number ~ U(0,1)
    
    %Accept if the likelihood ratio  > random number ~ U(0,1)
    if r < ratio
        beta_old=beta_new;
        err_old=err_new;
    end
    
    %If past burn then save
    if i > burnin
        beta1_dist(i-burnin) = beta_new(1);
        beta2_dist(i-burnin) = beta_new(2);
        beta3_dist(i-burnin) = beta_new(3);
        err_dist(i-burnin) = err_new;
    end
    
end