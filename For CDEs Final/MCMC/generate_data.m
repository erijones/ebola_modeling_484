function [t,y]= generate_data(alph, beta1, beta2, beta3, delta, gamma1, gamma2, psi, rho1, rho2, omega, tSpan, y0)

odejac = @(t,u,up) jac(u, alph, beta1, beta2, beta3, delta, gamma1, gamma2, psi, rho1, rho2, omega); 
odefun =@(t,u) SEIHRRR(t, u, alph, beta1, beta2, beta3, delta, gamma1, gamma2, psi, rho1, rho2, omega);
opts = odeset('Jacobian', odejac);
[t,y] = ode15s(odefun, tSpan, y0, opts);

end