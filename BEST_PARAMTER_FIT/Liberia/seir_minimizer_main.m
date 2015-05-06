clear;clc;
tic
%LIBERIA

%Manner in which to order variables
%alpha, beta1, beta2, beta3, delta, gamma1, gamma2, psi, rho1, rho2, omega

beta1 = 1.0e-06;
beta2 = 2.0e-07; 
beta3 = 1.0e-8;
gamma2 = 1/20;
psi = 1/2;


IG = [beta1; beta2 ; beta3;gamma2;  psi];
options = optimset('MaxFunEvals', 400*length(IG), 'TolFun',1e-6,'TolX',1e-6);
%IG = [delta,gamma1,psi];
k_val=fminsearch(@seir_parameter_fit,IG,options);
%GraphIt(IG)
toc
%% 
figure
GraphIt(k_val)