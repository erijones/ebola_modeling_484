% March 5th 
% Initial Standard SEIR 


alpha = .024; % population growth constant (known empirially) 
gamma = 0.1; % removal rate (1 over the average duration of infection i.e. 10 days  )
k = .001;      %Transmission rate (NOT KNOWN JUST A GUESS!!!!!)
mu = 1/21;  % 1/incubation period for Ebola Virus
%beta = 0.01;  %population death constant 
tSpan = [0; 50];


y0 = [1000, 1 , 0 , 0];


%f = @(t,y) [ (alpha*y(1) -k*y(1)*y(3)) ;  (k*y(1)*y(3)-mu*y(2))  ;  ...
%     (mu*y(2)-gamma*y(3)); (gamma*y(3) -beta*y(4))  ] ;
%Ignoring the constant death rate incorporating the population death rate
%into the population growth constant.
f = @(t,y) [ (alpha*y(1) -k*y(1)*y(3)) ;  (k*y(1)*y(3)-mu*y(2))  ;  ...
             (mu*y(2)-gamma*y(3)); gamma*y(3)  ] ;

[t,y] = ode45(f, [0,100], y0);




plot(t,y(:,1),'o')
hold on
plot(t,y(:,2),'-')
hold on
plot(t,y(:,3),'+')
hold on
plot(t,y(:,4),'x')
legend('S','E','I','R')
% save the image in the given directory (needed cause my matlab is broken!)
print('/home/eric/ebola/sir_model.pdf','-dpdf')
