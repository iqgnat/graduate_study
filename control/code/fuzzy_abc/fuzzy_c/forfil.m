function force=forfil(prefor,u,h)
k1=h*100*(u-prefor);
k2=h*100*(u-(prefor+k1/2));
k3=h*100*(u-(prefor+k2/2));
k4=h*100*(u-(prefor+k3));
force=prefor+(k1+2*k2+2*k3+k4)/6;