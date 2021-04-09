clear;
dacout(608,0,2047);
r=0;
e = zeros(1,2001);
e_total = zeros(1,2001);
kp=1;
ki=0;
kd=0.05;
n=2000;
T = 0.055;
pause;
timeref = cputime;

tic;
for k=1:n
    x(k)=(adcinp(608,1,1,1)/204.8-10)/40;
    angle(k)=(adcinp(608,3,1,1)/204.8-10)*22.5;
    y = (adcinp(608,0,1,1)/204.8)-10;
    e(k+1) = y;
    e_total(k+1)=e_total(k)+e(k);
    force(k)=kp*e(k+1)+ki*e_total(k+1)*T+kd*(e(k+1)-e(k));
    dacout(608,0,force(k));
    while cputime<(timeref+(k*0.055))
    end
    time(k) = toc;
end