% G - S iteration method solving problems five-point difference method
% Kmax for the maximum number of iterations
% M, n for x, y direction of the grid number, for example (1-(-1)) / 0.01 = 200
% e for error, p for exact solutions
syms temp;
u=zeros(n+1,m+1);
x=-1+(0:m)*h;
y=-1+(0:n)*h;
for i=1:n+1
    u(i,1)=exp(-2)*cos(2*pi*y(i));
    u(i,m+1)=exp(2)*cos(2*pi*y(i));
end
for j=1:m+1
    u(1,j)=exp(2*x(j));
    u(n+1,j)=exp(2*x(j));
end
for i=1:n
    for j=1:m
        f(i,j)=-4*exp(2*x(j))*cos(2*pi*y(i))+4*pi*pi*exp(2*x(j))*cos(2*pi*y(i));
    end
end
t=zeros(n-1,m-1);
for k=1:kmax
    for i=2:n
        for j=2:m 
            temp=h*h*f(i,j)/4+(u(i,j+1)+u(i,j-1)+u(i+1,j)+u(i-1,j))/4;
            t(i,j)=(temp-u(i,j))*(temp-u(i,j));
            u(i,j)=temp;
        end
    end
    t(i,j)=sqrt(t(i,j));
    if(k>kmax)
        break;
    end
    if(max(max(t))<ep)
        break;      
    end
end
for i=1:n+1
    for j=1:m+1
        p(i,j)=exp(2*x(j))*cos(2*pi*y(i));
        e(i,j)=abs(u(i,j)-p(i,j));
    end
end
