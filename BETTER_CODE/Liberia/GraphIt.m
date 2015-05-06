function   GraphIt(IG)

% import .csv value
filename= '/Users/redpatrioteq2/Dropbox/PIC_Math_group/ebola_data/matlab_data.csv';
%%%%%%%%%%%%%%% MODIFY FILE PATH TO DATA DESIRED ABOVE %%%%%%%%%%%%%%% 
fid = fopen(filename);
raw_data=textscan(fid, '%s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter',',');
fclose(fid);

% data of the form [day of outbreak, cases (i.e. infected) on this day, deaths
% (i.e. removed) by this day]
lib_data2 = [raw_data{2}, raw_data{4}, raw_data{12}];
temp_matrix = zeros(size(lib_data2));

count=1;
for i=1:length(lib_data2)
    lib_data2(i,1) = lib_data2(i,1); %- 102; % shift the data to start on this
                                           % (arbitrary!) date
    if (~isnan(lib_data2(i,2)) & ~isnan(lib_data2(i,3)))
        if (lib_data2(i,1) >= 0)
            temp_matrix(count,:) = lib_data2(i,:);
            count=count+1;
        end
    end
    
end
lib_data=flipud(temp_matrix(find(temp_matrix(:,1),1,'first'):find(temp_matrix(:,1),1,'last')+1,:));
%Adjusting from cumulative case counts to current
lib_data(:,2) = lib_data(:,2) - lib_data(:,3);
lib_data = lib_data(25:62,:);
tSpan = lib_data(:,1);

% parameter initialization
alpha  = 0.024/365; % population growth constant (known empircally) 
beta1  = IG(1);
beta2  = IG(2);
beta3  = IG(3);
delta  = 1/21;%1/incubation period for Ebola Virus
gamma1 = 1/10;
gamma2 = IG(4);
psi    = IG(5);
rho1   = 0.7;
rho2   = 0.6;
omega  = 1;  %population death constant 

% using initial condition from Liberia on 7/2/14
y0 = [4.294e6, lib_data(1,2), lib_data(1,2), 0, lib_data(1,3), 0, 0 ];


odejac = @(t,u,up) jac(u, alpha, beta1, beta2, beta3, delta, gamma1, gamma2, psi, rho1, rho2, omega); 
odefun =@(t,u) SEIHRRR(t, u, alpha, beta1, beta2, beta3, delta, gamma1, gamma2, psi, rho1, rho2, omega);
opts = odeset('Jacobian', odejac);
[t,y] = ode15s(odefun, tSpan, y0, opts);

clf;

%hold on
plot(t,y(:,2),'y-',t,y(:,3)+y(:,4),'r-.',t,y(:,5)+y(:,6),'k-',t,y(:,7),'b-',lib_data(:,1), ...
lib_data(:,2),'r*',lib_data(:,1), lib_data(:,3), 'k.','MarkerSize',10)
%legend('S','E','I','R')
legend('E','I+H','R_I + R_B','R_R','Number of cases data','Deaths data')
axis([tSpan(1) max(tSpan) 0 max(lib_data(:,2))*1.5])
title(sprintf('5-parameter Liberia Cases & Death Fit \n b1 = %0.3g, b2 = %0.3g, b3 = %0.3g,gamma2 = %0.3g, psi = %0.3g',IG(1),IG(2),IG(3),IG(4),IG(5)))
xlabel('Days')
ylabel('Population')
end
