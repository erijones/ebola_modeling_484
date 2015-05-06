clear;clc;
tic
%LIBERIA

%Manner in which to order variables
%alpha, beta1, beta2, beta3, delta, gamma1, gamma2, psi, rho1, rho2, omega

beta1 = 1.0e-06;
beta2 = 2.0e-07; 
beta3 = 1.0e-8;
gamma2 = 1/15;
psi = 1/2;


IG = [beta1; beta2 ; beta3;gamma2;  psi];
%IG = [delta,gamma1,psi];
k_val=fminsearch(@seir_parameter_fit,IG);
%GraphIt(IG)
toc
%% 
figure
GraphIt(k_val)