function [mf1,mf2]=mfn_c(x1,x2)
x1e=-x1;
x2e=-x2;
mf1=zeros(1,7);
mf2=zeros(1,7);
if x1e<=-pi/3
   if x1e<=-pi/2
       mf1(1)=1;
   else
       mf1(1)=-6/pi*(x1e+pi/3);
   end
end
if x1e<=-pi/6 && x1e>=-pi/2
    if x1e<=-pi/3
        mf1(2)=6/pi*(x1e+pi/2);
    else
        mf1(2)=-6/pi*(x1e+pi/6);
    end
end
if x1e<=0 && x1e>=-pi/3
    if x1e<=-pi/6
        mf1(3)=6/pi*(x1e+pi/3);
    else
        mf1(3)=-6/pi*x1e;
    end
end
if x1e<=pi/6 && x1e>=-pi/6
    if x1e<=0
        mf1(4)=6/pi*(x1e+pi/6);
    else
        mf1(4)=-6/pi*(x1e-pi/6);
    end
end
if x1e<=pi/3 && x1e>=0
    if x1e<=pi/6
        mf1(5)=6/pi*(x1e);
    else
        mf1(5)=-6/pi*(x1e-pi/3);
    end
end
if x1e<=pi/2 && x1e>=pi/6
    if x1e<=pi/3
        mf1(6)=6/pi*(x1e-pi/6);
    else
        mf1(6)=-6/pi*(x1e-pi/2);
    end
end
if x1e>=pi/3
    if x1e>=pi/2
        mf1(7)=1;
    else
        mf1(7)=6/pi*(x1e-pi/3);
    end
end

%--------------------------------------------------------------------------

if x2e<=-pi/6
   if x2e<=-pi/4
       mf2(1)=1;
   else
       mf2(1)=-12/pi*(x2e+pi/6);
   end
end
if x2e<=-pi/12 && x2e>=-pi/4
    if x2e<=-pi/6
        mf2(2)=12/pi*(x2e+pi/4);
    else
        mf2(2)=-12/pi*(x2e+pi/12);
    end
end
if x2e<=0 && x2e>=-pi/6
    if x2e<=-pi/12
        mf2(3)=12/pi*(x2e+pi/6);
    else
        mf2(3)=-12/pi*x2e;
    end
end
if x2e<=pi/12 && x2e>=-pi/12
    if x2e<=0
        mf2(4)=12/pi*(x2e+pi/12);
    else
        mf2(4)=-12/pi*(x2e-pi/12);
    end
end
if x2e<=pi/6 && x2e>=0
    if x2e<=pi/12
        mf2(5)=12/pi*(x2e);
    else
        mf2(5)=-12/pi*(x2e-pi/6);
    end
end
if x2e<=pi/4 && x2e>=pi/12
    if x2e<=pi/6
        mf2(6)=12/pi*(x2e-pi/12);
    else
        mf2(6)=-12/pi*(x2e-pi/4);
    end
end
if x2e>=pi/6
    if x2e>=pi/4
        mf2(7)=1;
    else
        mf2(7)=12/pi*(x2e-pi/6);
    end
end
    