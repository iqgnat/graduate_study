clear
x=-pi:0.01:pi;
for i=1:length(x)
    [mf1,mf2]=mfn(-x(i),-x(i)/2);
    mfx1(i,:)=mf1;
    mfx2(i,:)=mf2;
end
color=[255 0 0
       255 128 0
       255 255 0
       0 255 0
       0 255 255]/255;
   
for i=1:5
    plot(x,mfx1(:,i),'color',color(i,:))
    hold on
end
xlabel('e(t), (rad)')
title('membership function of error')
axis([-2,2,0,1])
grid

figure
for i=1:5
    plot(x/2,mfx2(:,i),'color',color(i,:))
    hold on
end
xlabel('de(t)/dt, (rad/sec)')
title('membership function of change in error')
axis([-1,1,0,1])
grid

  