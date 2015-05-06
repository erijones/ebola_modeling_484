% Run ode15s 1000 times, 30 times with and without the Jacobian
% Compute the paired difference (D = No Jacobian - Jacobian) for each test (30 differences)
% Use these paired differences to test the null hypothesis:

% Ho: D <= 0 
% Ha: D > 0


clear; clc;


% Load All Necessary Data
load('tSpan.mat')
load('y0.mat')
load('true_parameters.mat')

%initialize 
withJ = zeros(1,30);
withoutJ = zeros(1,30);

odejac = @(t,u,up) jac(u, alph, beta1, beta2, beta3, delta, gamma1, gamma2, p, rho1, rho2, omega); 
odefun =@(t,u) SEIHRRR(t, u, alph, beta1, beta2, beta3, delta, gamma1, gamma2, p, rho1, rho2, omega);
opts = odeset('Jacobian', odejac);


for i=1:30
    % Run with Jacobian
    tic
    for j=1:1000
        [t,y] = ode15s(odefun, tSpan, y0, opts);
    end
    withJ(i) = toc/1000;
    
    % Run without Jacobian
    tic
    for j=1:1000
        [t,y] = ode15s(odefun, tSpan, y0);
    end
    withoutJ(i) = toc/1000;
end

%Is the data normal?
figure();hist(withJ, 5)
figure();hist(withoutJ, 5)

% Evaluate Hypothesis Test
[h p] = ttest(withoutJ,withJ, 'Tail','right');

% Plot Difference For Visual
figure('Color','white')
plot(withoutJ, withJ, 'bo', linspace(min(withoutJ),max(withoutJ),100),linspace(min(withoutJ),max(withoutJ),100),'k-')
title('Difference in ode15s Solve Time With Jacobian')
xlabel('Without Jacobian Time (s)')
ylabel('With Jacobian Time (s)')
