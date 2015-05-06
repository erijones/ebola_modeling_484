clear;clc;
tic
%GUINEA

beta1 = 1.0e-06;
beta2 = 2.0e-07; 
beta3 = 1.0e-08;
gamma2 = 1/30;
psi = 1/2;


IG = [beta1; beta2 ; beta3; gamma2;  psi];
options = optimset('MaxFunEvals', 400*length(IG), 'TolFun',1e-6,'TolX',1e-6);
k_val=fminsearch(@seir_parameter_fit,IG,options);

toc
%% 
figure
GraphIt(k_val)