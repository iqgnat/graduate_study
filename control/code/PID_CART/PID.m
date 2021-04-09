% transfer function for IP angle 
num=[0.7329 0 0];
den=[1 0.0976 -20.1557 -1.8323 0];

% tranfer function of PID controller
Kd=20;
Kp=100;
Ki=1;

numPID=[Kd Kp Ki];
denPID=[1 0];
numc=conv(num,denPID);
denc=polyadd(conv(denPID,den),conv(numPID,num));

% impulse response of PID controller
t=0:0.005:5
impulse(numc,denc,t);
axis([0 5 -0.2 0.2]);
