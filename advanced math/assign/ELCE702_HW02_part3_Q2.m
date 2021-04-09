a=0.25;b=0.5;c=0.75;
a1=1.5;a2=2;a3=2.5;
m=a1; % or a2, a3
n=-a; % or -b, -c
v=[m m m m m m m m m m];w=[n n n n n n n n n];
X=diag(v);Y=diag(w,-1);Z=diag(w,+1);
A=X+Y+Z;
invA= inv(A);

SR=max(abs(eig(invA))) % find the spectrum density "rou", for three A's
p=ones(10,1);
q=p;
step=0;

% do approximation for spectral density
while abs(max(q)-SR)>(10^-10)
    q=invA*p;
    p=q/max(q);
    step=step+1;
end

step

format long 
max(q)
