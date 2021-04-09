[y,Fs]=wavread(('guitar1.wav'));
N=length(y);
n=0:N-1;
W1=rectwin(N);
yn1= (y).*W1;
subplot(3,1,1)
plot(n,yn1);
grid;
ylabel('amplitude');
xlabel('n');
title('rectangular window');
 n=0:8192;
 Yz1=fft(yn1,8192);
 subplot(3,1,2)
 plot(n,mag2db(abs(Yz1)));
 n=0:8191;
 Yz1=fft(yn1,8192);
 plot(n,mag2db(abs(Yz1)));
 grid;
 ylabel('dB');
 xlabel('k');
 title('rectangular Window');
 subplot(3,1,3)
 plot(n/8192*2,abs(Yz1));
 grid;
ylabel('amplitude');
 xlabel('w/pi');
title('rectangular Window');