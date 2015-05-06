clear;clc;
%To run the parameter fit execute this block of code, but first you must
%change the filename in the seir_parameter_fit_3_27.m 
%This returns a fitted value for the parameters K_1 = K_2, and Beta
%For the 5 variable model
%The output very much so depends on the initial k0 = [ k , beta]
k0=[2e-8 ;.05]
k_val=fminsearch(@seir_parameter_fit_3_27,k0)
seir_parameter_fit_3_27(k_val)
%% 
seir_parameter_fit_3_27(k_val)