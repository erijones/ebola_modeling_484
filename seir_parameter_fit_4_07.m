function err = seir_parameter_fit_4_07(IG)

% March 29th 
% Initial Standard SEIR with parameter fitting

%clear;

% import .csv value
filename= '/Users/redpatrioteq2/Dropbox/PIC_Math_group/ebola_data/matlab_data.csv';
%%%%%%%%%%%%%%% MODIFY FILE PATH TO DATA DESIRED ABOVE
%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%
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
tSpan = lib_data(:,1);


% parameter initialization
alpha = 0.025/365;% population growth constant (known empircally) 
%alpha = 0.025;
%g1 = .1; % removal rate (1 over the average duration of infection i.e. 10 days  )
%IG = 5e-8;      %Transmission rate (NOT KNOWN JUST A GUESS!!!!!)
%b1 = 7.96e-09;
%b2 = 4.10e-08;
delta = 1/12;  % 1/incubation period for Ebola Virus
rho1 = 0.7;
rho2 = 0.6;
omega = 1;  %population death constant 
g1 = 1/13;
%g11 = 0.7*g1;
%g12 = 0.3*g1;
% using initial condition from Liberia on 7/2/14
%y0 = [4.294e6, 115, 115, 75]; % here: I used dead=removed; we should probably
                        % deltaltiply the dead by something to compensate for those
                        % who didn't die
                        % also, I used E0=I0; this is probably incorrect
y0 = [11.75e6, 0, lib_data(1,2), 0, lib_data(1,3), 0, 0 ];


%f = @(t,y) [ (alpha*y(1) -k*y(1)*y(3)) ;  (k*y(1)*y(3)-delta*y(2))  ;  ...
%     (delta*y(2)-g1*y(3)); (g1*y(3) -beta*y(4))  ] ;
%Ignoring the constant death rate incorporating the population death rate
%into the population growth constant.
f = @(t,y,b1,b2,b3,psi,g2) [ (alpha*y(1) -b1*y(1)*y(3) -b2*y(1)*y(5) -b3*y(1)*y(4)) ;  (b1*y(1)*y(3)-delta*y(2) + b2*y(1)*y(5) +b3*y(1)*y(4))  ;  ...
             (delta*y(2)-g1*y(3) -psi*y(3) ); psi*y(3)-g2*y(4) ;  rho1*g1*y(3) - omega*y(5) ; omega*y(5)+rho2*g2*y(4) ; (1-rho1)*g1*y(3) + (1-rho2)*g2*y(4) ] ;

[t,y] = ode15s(f, tSpan, y0, [],IG(1),IG(2),IG(3),IG(4),IG(5));

clf;
%plot(t,y(:,1),'o')
%hold on
plot(t,y(:,2),'y-',t,y(:,3),'r-.',t,y(:,5)+y(:,6),'k-',t,y(:,7),'b-',lib_data(:,1), ...
lib_data(:,2),'r*',lib_data(:,1), lib_data(:,3), 'k.','MarkerSize',10)
%legend('S','E','I','R')
legend('E','I','R_I + R_B','R_R','Number of cases data','Deaths data')
axis([0 max(tSpan) 0 max(lib_data(:,2))*1.5])
title(sprintf('5-parameter Guinea Cases & Death Fit \n b1 = %0.3g , b2 = %0.3g , b3 = %0.3g , psi = %0.3g , g2 = %0.3g',IG(1),IG(2), IG(3),IG(4), IG(5)))
xlabel('Days')
ylabel('Population')
% save the image in the given directory (needed cause my matlab is broken!)
%print('-painters', '-depsc', '/home/eric/ebola/seir_model_param_fit.eps')

%err = sum( (lib_data(:,3) - (y(:,4)+y(:,5)) ).^2 );
%err = sum( (lib_data(:,2) - y(:,3)).^2 );
err = sum(sqrt( (lib_data(:,3) - (y(:,5)+y(:,6)) ).^2 +  (lib_data(:,2) - y(:,3)).^2));


