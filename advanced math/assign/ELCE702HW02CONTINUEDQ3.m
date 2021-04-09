b=zeros(99,1);
b(1,1)= 0.5;

D=eye(99,99);

M=0.5*ones(98,1);
L=diag(M,-1); % to match the matrix size to be 99*99, as diagonal has been low downmove 1


U=diag(M,1);

Tj=D^(-1)*(L+U);
Cj=D^(-1)*b;

Tg=(D-L)^(-1)*U;
Cg=(D-L)^(-1)*b;

S=0;
n=0;
    
True=(0.99:-0.01:0.01)';

x=zeros(99,1);
y=zeros(99,1);

while (norm((x-True),inf)>1e-5)
    x=Tj*x+Cj;
    n=n+1;
end
n  %Jacobi approximation
%-------------------------

m=0;
while (norm((y-True),inf)>1e-5)
    y=Tg*y+Cg;
    m=m+1;
end
m % Gauss-Seidel approximation

