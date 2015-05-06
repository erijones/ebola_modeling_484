clear;clc;
tic
%GUINEA

beta1 = 1.0e-06;
beta2 = 2.0e-07; 
beta3 = 1.0e-08;
gamma2 = 1/30;
psi = 1/2;


IG = [beta1; beta2 ; beta3; gamma2;  psi];

k_val=fminsearch(@seir_parameter_fit,IG);

toc
%% 
figure
GraphIt(k_val)