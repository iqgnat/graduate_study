center=[-30 -20 -10 0 10 20 30];
rb=[7,7,7,7,6,5,4;7,7,7,6,5,4,3;7,7,6,5,4,3,2;...
            7,6,5,4,3,2,1;6,5,4,3,2,1,1;5,4,3,2,1,1,1;4,3,2,1,1,1,1]; 
                        % rule base matrix
x1=0.3;                 % initial angle position
x2=0.1;                   % initial angle speed
step=0.001;             % step
t=0:step:3;             % simulation time
uf=zeros(1,length(t));  % force to the chart
uff=0;                  % inital filter force
theta(1)=x1;            % angle to the reference
theta_speed(1)=x2;      % angle speed
g0=5;                  % gain of error input
g1=0.3;                 % error of speed gain
h=2;   

   
for k=1:length(t)
    x1=g0*x1;
    x2=g1*x2;
    [mf1,mf2]=mfn_b(x1,x2);    % Gaussian membership function
    for i=1:5
        for j=1:5
        premise(i,j)=mf1(i)*mf2(j); % Product premise for Gaussian membership function
        end
    end
    imps=10*premise;      % Product area of Gaussian membership function
    u=ucr_b(imps,rb,center);
    uf(k)=u;
    u=h*u;
    [x1,x2]=rk4(theta(k),theta_speed(k),step,uff);
    if k<length(t);
        theta(k+1)=x1;
        theta_speed(k+1)=x2;
    end
end
figure
 subplot(2,1,1)
    plot(t,theta)
    ylabel('Angular position(rad)')
    hold on;
    grid on;

 subplot(2,1,2)
 plot(t,uf)
 ylabel('Input force(N)')
 xlabel('Time(sec)')
 grid on;
 hold on
 
 