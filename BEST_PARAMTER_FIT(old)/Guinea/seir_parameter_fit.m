function err = seir_parameter_fit(IG)
%GUINEA

% import .csv value
filename= '/u/af/ci/csandrid/CAPSTONE/PROJECT/ebola_data/matlab_data.csv';
%%%%%%%%%%%%%%% MODIFY FILE PATH TO DATA DESIRED ABOVE %%%%%%%%%%%%%%% 
fid = fopen(filename);
raw_data=textscan(fid, '%s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f','delimiter',',');
fclose(fid);

% data of the form [day of outbreak, cases (i.e. infected) on this day, deaths
% (i.e. removed) by this day]
lib_data2 = [raw_data{2}, raw_data{3}, raw_data{11}];
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
A = lib_data(2:72,:);
B=lib_data(74:end,:);
lib_data=[A;B];
tSpan = lib_data(:,1);

% parameter initialization
alpha  = 0.025/365; % population growth constant (known empircally) 
beta1  = IG(1);
beta2  = IG(2);
beta3  = IG(3);
delta  = 1/21;%1/incubation period for Ebola Virus
gamma1 = 1/10;
gamma2 = IG(4);
psi    = IG(5);
rho2   = 0.59;
rho1   = 1.1*rho2;
omega  = 1;  %population death constant 

% using initial condition from Liberia on 7/2/14
y0 = [11.76e6, lib_data(1,2), lib_data(1,2), 0, lib_data(1,3), 0, 0 ];


odejac = @(t,u,up) jac(u, alpha, beta1, beta2, beta3, delta, gamma1, gamma2, psi, rho1, rho2, omega); 
odefun =@(t,u) SEIHRRR(t, u, alpha, beta1, beta2, beta3, delta, gamma1, gamma2, psi, rho1, rho2, omega);
opts = odeset('Jacobian', odejac);
[t,y] = ode15s(odefun, tSpan, y0, opts);

 if beta1 < 0 || beta2 < 0 || beta3 < 0 || gamma2 < 0 || psi < 0 || rho1 < 0.2 || rho2 < 0.4 || gamma1 < 0 || delta < 0
    err = inf;
 else
    err = sum(sqrt( (lib_data(:,3) - (y(:,5)+y(:,6)) ).^2 +  (lib_data(:,2) - (y(:,3) + y(:,4))).^2));
 end