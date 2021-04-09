clear

center=[-20 -10 0 10 20];
rb=[5 5 5 4 3;5 5 4 3 2;5 4 3 2 1;4 3 2 1 1;3 2 1 1 1];  
                        % rule base matrix
x1=0.1;                 % initial angle position
x2=0;                   % initial angle speed
step=0.001;             % step
t=0:step:3;             % simulation time
uf=zeros(1,length(t));  % force to the chart
uff=0;                  % inital filter force
theta(1)=x1;            % angle to the reference
theta_speed(1)=x2;      % angle speed
g0=4;                  % gain of error input
g1=0.8;                 % error of speed gain
h=6;   
colorct=1;
color=[255 0 0
       0 255 0
       0 0 255
       227 244 12
       139 19 246
       19 237 232
       150 90 60]/255;
   
for h=6:10:66
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

%  subplot(2,1,1)
    plot(t,theta,'color',color(colorct,:))
    colorct=colorct+1;

    ylabel('Angular position(rad)')
    hold on;
    grid on;
    legend('6','16','26','36','46','56','66');
end
% 
%  subplot(2,1,2)
%  plot(t,uf)
%  ylabel('Input force(N)')
%  xlabel('Time(sec)')
%  grid on;
 
 