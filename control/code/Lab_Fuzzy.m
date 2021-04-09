clear;
dacout(608,0,2047);
%% Fuzzification: Convert the numerical input to degree of membership
% data = 4000*rand(1000,1)/204.8-10;
ue = zeros(1,5);
ude = zeros(1,5);
e = zeros(1,2001);
de = zeros(1,2000);
force = zeros(1,2000);
x = zeros(1,2000);
angle = zeros(1,2000);
% % MFs for error
% fe{1} = @(x)bMF(x,[-inf,-20,-10,-5]);
% fe{2} = @(x)cMF(x,[-10,-5,0]);
% fe{3} = @(x)cMF(x,[-5,0,5]);
% fe{4} = @(x)cMF(x,[0,5,10]);
% fe{5} = @(x)bMF(x,[5,10,20,inf]);
% % MFs for change in error
% fde{1} = @(x)bMF(x,[-inf,-20,-5,-2.5]);
% fde{2} = @(x)cMF(x,[-5,-2.5,0]);
% fde{3} = @(x)cMF(x,[-5,0,5]);
% fde{4} = @(x)cMF(x,[0,2.5,5]);
% fde{5} = @(x)bMF(x,[2.5,5,20,inf]);

% MFs for error
fe{1} = [-inf,-20,-10,-5];
fe{2} = [-10,-5,0];
fe{3} = [-5,0,5];
fe{4} = [0,5,10];
fe{5} = [5,10,20,inf];
% MFs for change in error
fde{1} = [-inf,-20,-5,-2.5];
fde{2} = [-5,-2.5,0];
fde{3} = [-2.5,0,2.5];
% fde{3} = [-5,0,5];
fde{4} = [0,2.5,5];
fde{5} = [2.5,5,20,inf];

% Rule = [...
%     -15 -15 -7.5 -7.5 0
%     -15 -7.5 -7.5 0 7.5
%     -7.5 -7.5 0 7.5 7.5
%     -7.5 0 7.5 7.5 15
%     0 7.5 7.5 15 15];

Rule = [...
    -15 -15 -15 -7.5 0
    -15 -15 -7.5 0 7.5
    -15 -7.5 0 7.5 15
    -7.5 0 7.5 15 15
    0 7.5 15 15 15];


g0 = 1;
g1 = 3;
h = 1;
r = -0.75;
pause;

tic;
for i = 1:2000
    x(i) = adcinp(608,1,1,1)/204.8-10;
    angle(i) = adcinp(608,3,1,1)/204.8-10;
y = adcinp(608,0,1,1)/204.8-10;
% y = data(i);
e(i+1) = g0*(y - r);
de(i) = g1*(e(i+1) - e(i));
for j = 1:5
    switch j
        case {1,5}
    ue(j) = bMF(e(i+1),fe{j});
    ude(j) = bMF(de(i),fde{j});
        case {2,3,4}
    ue(j) = cMF(e(i+1),fe{j});
    ude(j) = cMF(de(i),fde{j});
    end
end
w = ue'*ude; % use prod as AND operation
force(i) = h*(sum(sum(w.*Rule))/sum(sum(w))+10)*204.8;
dacout(608,0,force(i));
time(i) = toc;
end


