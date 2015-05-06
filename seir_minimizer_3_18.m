clear;clc;
k0=[2e-8; 2e-8]
k_val=fminsearch(@seir_parameter_fit_3_19,k0)
seir_parameter_fit_3_19(k_val)
