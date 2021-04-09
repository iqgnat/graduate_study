function [mf1,mf2]=mfn_b(x1,x2)
x1e=-x1;
x2e=-x2;
s1=0.33353;
s2=s1/2;
mf1=zeros(1,5);
if x1e<=-pi/2
    mf1(1)=1;
else
    mf1(1)=exp(-(x1e+pi/2).^2./(2*s1.^2));
end
mf1(2)=exp(-(x1e+pi/4).^2./(2*s1.^2));
mf1(3)=exp(-(x1e).^2./(2*s1.^2));
mf1(4)=exp(-(x1e-pi/4).^2./(2*s1.^2));
if x1e>=pi/2
    mf1(5)=1;
else
    mf1(5)=exp(-(x1e-pi/2).^2./(2*s1.^2));
end
%--------------------------------------------------------------------------
mf2=zeros(1,5);
if x2e<=-pi/4
    mf2(1)=1;
else
    mf2(1)=exp(-(x2e+pi/4).^2./(2*s2.^2));
end
mf2(2)=exp(-(x2e+pi/8).^2./(2*s2.^2));
mf2(3)=exp(-(x2e).^2./(2*s2.^2));
mf2(4)=exp(-(x2e-pi/8).^2./(2*s2.^2));
if x2e>=pi/4
    mf2(5)=1;
else
    mf2(5)=exp(-(x2e-pi/4).^2./(2*s2.^2));
end