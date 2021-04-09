function [mf1,mf2]=mfn(x1,x2)
x1e=-x1;
x2e=-x2;
mf1=zeros(1,5);
if x1e<=-pi/4
   if x1e<=-pi/2
       mf1(1)=1;
   else
       mf1(1)=-4/pi*(x1e+pi/4);
   end
end
if x1e<=0 && x1e>=-pi/2
    if x1e<=-pi/4
        mf1(2)=4/pi*(x1e+pi/2);
    else
        mf1(2)=-4/pi*x1e;
    end
end
if x1e<=pi/4 && x1e>=-pi/4
    if x1e<=0
        mf1(3)=4/pi*(x1e+pi/4);
    else
        mf1(3)=-4/pi*(x1e-pi/4);
    end
end
if x1e<=pi/2 && x1e>=0
    if x1e<=pi/4
        mf1(4)=4/pi*x1e;
    else
        mf1(4)=-4/pi*(x1e-pi/2);
    end
end
if x1e>=pi/4
    if x1e>=pi/2
        mf1(5)=1;
    else
        mf1(5)=4/pi*(x1e-pi/4);
    end
end
%--------------------------------------------------------------------------
mf2=zeros(1,5);
if x2e<=-pi/8
   if x2e<=-pi/4
       mf2(1)=1;
   else
       mf2(1)=-8/pi*(x2e+pi/8);
   end
end
if x2e<=0 && x2e>=-pi/4
    if x2e<=-pi/8
        mf2(2)=8/pi*(x2e+pi/4);
    else
        mf2(2)=-8/pi*x2e;
    end
end
if x2e<=pi/8 && x2e>=-pi/8
    if x2e<=0
        mf2(3)=8/pi*(x2e+pi/8);
    else
        mf2(3)=-8/pi*(x2e-pi/8);
    end
end
if x2e<=pi/4 && x2e>=0
    if x2e<=pi/8
        mf2(4)=8/pi*x2e;
    else
        mf2(4)=-8/pi*(x2e-pi/4);
    end
end
if x2e>=pi/8
    if x2e>=pi/4
        mf2(5)=1;
    else
        mf2(5)=8/pi*(x2e-pi/8);
    end
end        
    