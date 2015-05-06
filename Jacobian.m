function dF=Jacobian(u,alpha, B1, B2, B3, delta, g1, g2, psi, rho1, rho2, omega)
S = u(1); E=u(2); I=u(3); H=u(4); RI=u(5); RB=u(6); RR = u(7);
dF = [alpha-B1*I-B2*RI-B3*H, 0, -B1*S, -B3*S, -B2*S, 0, 0;
      B1*I+B2*RI+B3*H, -delta, B1*S, B3*S, B2*S, 0 , 0;
      0, delta, -g1-psi, 0, 0, 0, 0;
      0, 0, psi, -g2, 0, 0 , 0;
      0, 0, rho1*g1, 0, -omega, 0, 0;
      0, 0, 0, rho2*g2, omega, 0, 0;
      0, 0, 1-rho1*g1, 1-rho2*g2, 0, 0 , 0];