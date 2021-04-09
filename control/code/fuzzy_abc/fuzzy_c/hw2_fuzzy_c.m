% ELCE 707 Advanced control 
% main function of the fuzzy control


center=[-20 -20*2/3 -20/3 0 20/3 20*2/3 20];

rb=[  7 7 7 7 6 5 4
      7 7 7 6 5 4 3
      7 7 6 5 4 3 2
      7 6 5 4 3 2 1
      6 5 4 3 2 1 1
      5 4 3 2 1 1 1
      4 3 2 1 1 1 1];   % rule base matrix
x1=0.1;                 % initial angle position
x2=0;                   % initial angle speed
step=0.001;                % step
t=0:step:3;                % simulation time
uf=zeros(1,length(t));  % force to the chart
uff=0;                  % inital filter force
theta(1)=x1;            % angle to the reference
theta_speed(1)=x2;      % angle speed
g0=1;                   % error gain
g1=5;                   % error of speed gain
h=1;                    % output gain
for k=1:length(t)
    x1=g0*x1;
    x2=g1*x2;
    [mf1,mf2]=mfn_c(x1,x2);   
    for i=1:7
        for j=1:7
            premise(i,j)=min(mf1(i),mf2(j));
        end
    end
    %imps=10-(1-premise)*10.*(1-premise); % Find the area under the membership functions
    imps=20/3-(1-premise)*20/3.*(1-premise);
    u=ucr_c(imps,rb,center);
    u=h*u;
    uf(k)=u;
    [x1,x2]=rk4(theta(k),theta_speed(k),step,uff);
    uff=u*(1-exp(-100*t(k)));
    if k<length(t);
        theta(k+1)=x1;
        theta_speed(k+1)=x2;
    end
end

% plot results
 subplot(2,1,1)
 plot(t,theta)
 ylabel('Angular position(rad)')
 subplot(2,1,2)
 plot(t,uf)
 xlabel('Time(sec)')
 ylabel('Input Force (N)')
 
 
 