clear;
tic;
for i = 1:2000
    x(i) = adcinp(608,1,1,1)/204.8-10;
    angle(i) = adcinp(608,3,1,1)/204.8-10;
    y(i) = adcinp(608,0,1,1)/204.8-10;
    r(i) = adcinp(608,2,1,1)/204.8-10;
    time(i) = toc;
end