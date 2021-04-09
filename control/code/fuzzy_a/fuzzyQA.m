% Fuzzy control of IP, Question A
rb=[5 5 5 4 3
    5 5 4 3 2
    5 4 3 2 1
    4 3 2 1 1
    3 2 1 1 1];
x1=0.1;                 % initial angle position
x2=0;                   % initial angle speed
interval=0.001;             % step
t=0:interval:3;             % simulation time
uf=zeros(1,length(t));  % force to the chart
uff=0;                  % inital filter force
theta(1)=x1;            % angle to the reference
theta_speed(1)=x2;      % angle speed
g0=1;                   % error gain
g1=0.1;                   % error of speed gain
h=1;                    % output gain

center=[-20 -10 0 10 20];

for k=1:length(t)
    x1=g0*x1;
    x2=g1*x2;
    [mf1,mf2]=mfn(x1,x2);   
    for i=1:5
        for j=1:5
            premise(i,j)=min(mf1(i),mf2(j));
        end
    end
    imps=10-(1-premise)*10.*(1-premise); % Find the area under the membership functions
    u=ucr(imps,rb,center);
    u=h*u;
    uf(k)=u;
    [x1,x2]=rk4(theta(k),theta_speed(k),interval,uff);
    uff=u*(1-exp(-100*t(k)));
    if k<length(t);
        theta(k+1)=x1;
        theta_speed(k+1)=x2;
    end
end

 subplot(2,1,1)
 plot(t,theta)
 ylabel('Angular position(rad)')
 grid on;
 
 subplot(2,1,2)
 plot(t,uf)
 ylabel('Input force(N)')
 xlabel('Time(sec)')
 grid on;
 
 
 