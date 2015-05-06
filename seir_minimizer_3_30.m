clear;clc;
tic
%To run the parameter fit execute this block of code, but first you must
%change the filename in the seir_parameter_fit_3_30.m 
%This returns fitted parameter values for everything in our model
%The output very much so depends on the initial k0, I have chosen the
%fitted k1,k2 values and then our theoretical values for 
%gamma, mu, beta, alpha, and Rho
k0 = [ 0.0794e-07;  0.4124e-07 ;0.1; 1/21 ; 1 ; 0.025/365 ; 0.7]
%k0=[ 0.1 ; 1/21 ]
k_val=fminsearch(@seir_parameter_fit_3_30,k0)
seir_parameter_fit_3_30(k_val)
toc
%% 
seir_parameter_fit_3_30(k_val)