function [x1,x2]=rk4(x10,x20,h,u)
k1=h*f(x10,x20,u);
k2=h*f(x10,x20+k1/2,u);
k3=h*f(x10,x20+k2/2,u);
k4=h*f(x10,x20+k3,u);
x2=x20+(k1+2*k2+2*k3+k4)/6;
%--------------------------------------------------------------------------
x1=x10+h*x2;
function ff=f(x1,x2,u)
ff=(9.8*sin(x1)+cos(x1)*((-u-0.25*x2*x2*sin(x1))/1.5))/(0.5*(4/3-cos(x1)*cos(x1)/3));