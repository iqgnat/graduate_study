clear
x=-pi:0.01:pi;
for i=1:length(x)
    [mf1,mf2]=mfn_c(-x(i),-x(i)/2);
    mfx1(i,:)=mf1;
    mfx2(i,:)=mf2;
end
color=[255 0 0
       0 255 0
       0 0 255
       227 244 12
       139 19 246
       19 237 232
       150 90 60]/255;
for i=1:7
    plot(x,mfx1(:,i),'color',color(i,:))
    hold on
end
xlabel('e(t), (rad)')
axis([-2,2,0,1])
figure
for i=1:7
    plot(x/2,mfx2(:,i),'color',color(i,:))
    hold on
end
xlabel('de(t)/dt, (rad/sec)')
axis([-1,1,0,1])
grid
