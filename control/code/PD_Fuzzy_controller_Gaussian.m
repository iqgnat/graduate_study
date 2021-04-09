clear;
dacout(608,0,2047);
%% Fuzzification: Convert the numerical input to degree of membership
ue = zeros(1,5);
ude = zeros(1,5);
e = zeros(1,2001);
de = zeros(1,2000);
force = zeros(1,2000);
x = zeros(1,2000);

sig1=sqrt(-(2.5)^2/(2*log(0.5)));
% MFs for error
fe{1} = [inf,-10,sig1,-10];
fe{2} = [sig1,-5];
fe{3} = [sig1,0];
fe{4} = [sig1,5];
fe{5} = [sig1,10,inf,10];

sig2=sqrt(-(1.25)^2/(2*log(0.5)));
% MFs for change in error
fde{1} = [inf,-5,sig2,-5];
fde{2} = [sig2,-2.5];
fde{3} = [sig2,0];
fde{4} = [sig2,2.5];
fde{5} = [sig2,5,sig2,inf];

Rule = [...
    15 15 15 7.5 0
    15 15 7.5 0 -7.5
    15 7.5 0 -7.5 -15
    7.5 0 -7.5 -15 -15
    0 -7.5 -15 -15 -15];

%% Gain: Fuzzy PD control
g0 = 1; % proportional gain
g1 = 5; % derivative gain
h = 1; % output gain
r = -1.1*ones(1,2000);

pause;
%% Manaually hold the pendulum bob to angle~0 and press any key to start the control
tic;timeref = cputime;
for i = 1:2000
    x(i) = adcinp(608,1,1,1)/204.8-10;
    angle(i) = adcinp(608,3,1,1)/204.8-10;
    y(i) = adcinp(608,0,1,1)/204.8-10;
    e(i+1) = g0*(r(i)-y(i));
    de(i) = g1*(e(i+1) - e(i));
for j = 1:5
    switch j
        case {1,5}
    ue(j) = bMFg(e(i+1),fe{j});
    ude(j) = bMFg(de(i),fde{j});
        case {2,3,4}
    ue(j) = cMFg(e(i+1),fe{j});
    ude(j) = cMFg(de(i),fde{j});
    end
end
w = ue'*ude; % use prod as AND operation
% ¡§center-average¡¨ defuzzification method
force(i) = h*(sum(sum(w.*Rule))/sum(sum(w))+10)*204.8;
dacout(608,0,force(i));
% while cputime<(timeref+(i*0.055))
% end
time(i) = toc;
% r(i+1) = 0.25*sin(2*pi*1*time(i))-0.7;
end


