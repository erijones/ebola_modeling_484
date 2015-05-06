function A = SensitivityAnalysis(u,alpha, B1, B2, B3, delta, g1, g2, psi, rho1, rho2, omega)
S = u(1); E=u(2); I=u(3); H=u(4); RI=u(5); RB=u(6); RR = u(7);
A = [ S, -S*I, -S*RI, -S*H,  0,  0,          0,          0, 0,      0,    0;
      0,  S*I,  S*RI,  S*H, -E,  0,          0,          0, 0,      0,    0;
	  0,  0,    0,     0,    E, -I,          0,         -I, 0,      0,    0;
	  0,  0,    0,     0,    0,  0,         -H,          I, 0,      0,    0;
	  0,  0,    0,     0,    0,  rho1*I,     0,          0, g1*I,   0,   -RI;
	  0,  0,    0,     0,    0,  0,          rho2*H,     0, 0,      g2*H, RI;
	  0,  0,    0,     0,    0,  (1-rho1)*I, (1-rho2)*H, 0, -g1*I, -g2*H, 0];