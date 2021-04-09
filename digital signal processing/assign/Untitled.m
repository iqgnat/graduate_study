%%
% load the guitar1.wav
[y,Fs]=wavread(( 'guitar1.wav'));
% sample
y_rec= y.*rectwin(length(y));
figure
subplot(3,1,1)
plot(0:length(y)-1,y);
% rectangular window 
subplot(3,1,2)
plot(0:length(y)-1,y_rec);
grid on
xlabel('length');
ylabel('amplitude');
title('Rectangular Window');
% hamming window
y_ham=y.*hamming(length(y));
subplot(3,1,3)
plot(0:length(y)-1,y_ham);
grid on
xlabel('length');
ylabel('A mplitude'); 
title('Hamming Window');
%-------------------------------------choose rectangular window
 Y_REC=fft(y_rec,8192);
 figure
 subplot(2,1,1);
 plot(0:8191,20.*log10(abs(Y_REC)));
 grid on
 ylabel('dB');
 title('DFT after Rectangular Window Truncation');
 %___________________________________DFT after rectangular window, in dB
 subplot(2,1,2);
 plot((0:8191)/8192*2,abs(Y_REC));
 grid on
 xlabel('w/pi');
 %----------------------------------significant portion
 sound(y,Fs);
 %----------------------------------sound command
  
 %%
[y,Fs]=wavread('guitar1.wav');
n=0:length(y)-1;
figure
subplot(4,1,1)
plot(n,y);
title('original signal');

 y_10=sin(2*pi*10000*n./Fs);% angular frequency = 2* pi * f
 subplot(4,1,2);
 plot(n,y_10);
%  set(gca,'xlim',[0 0.0001*length(y)],'ylimmode','auto'); 
 title ('noise of 10KHz');
 %--------------------10K Hz sin interference of same length & rate
 
 y_tot=y_10.'+y;
 subplot(4,1,3);
 plot(n,y_tot);
 title('complex signal');
 %--------------------complex signal in time domain

 Y_tot=fft(y_tot,8192);
 subplot(4,1,4);
 plot((0:8191)/8192*2,20.*log10((abs(Y_tot))));
 title('DFT of sample add noise, in dB');
 grid on;
 ylabel('dB');
 %--------------------complex signal in freqency domain
 sound(y_tot,Fs);
 %% Butterworth filter 
Fs=44100;
wp=7000/(Fs/2);% nyquist,1/2 of sampling frequency
ws=9000/(Fs/2);
rp=1;
rs=40;
format long 
[n,Wn]=buttord(wp,ws,rp,rs) 
[b,a]=butter(n,Wn)
fvtool(b,a);
%% Cheby1
Fs=44100;
wp=7000/(Fs/2);
ws=9000/(Fs/2);
rp=1;
rs=40;
format long 
[n,Wn]=cheb1ord(wp,ws,rp,rs) 
[b,a]=cheby1(n,1,Wn)
fvtool(b,a);
%%  Elliptic
Fs=44100;
wp=7000/(Fs/2);
ws=9000/(Fs/2);
rp=1;
rs=40;
format long 
[n,Wn]=ellipord(wp,ws,rp,rs) 
[b,a]=ellip(n,wp,ws,Wn,'low')
fvtool(b,a);
%% comparison before and after filtering
 % Butterworth filter 
[y,Fs]=wavread('guitar1.wav');
n=0:length(y)-1;
y_10=sin(2*pi*10000*n./Fs);
y_tot=y_10.'+y;
Fs=44100;
wp=7000/(Fs/2);
ws=9000/(Fs/2);
rp=1;
rs=40;
[n,Wn]=buttord(wp,ws,rp,rs) 
[b,a]=butter(n,Wn)
[Hz,w]=freqz((10^(35.25/20))*b,a,1024);% DC gain of transfer function in numerator
 Y_tot=fft(y_tot,8192);
 subplot(2,1,1);
 plot((0:8191)/8192*2,20.*log10((abs(Y_tot))));
 grid;
 ylabel('dB');
 title('complex signal');
 %-------------before filtered
 y_fil=filter((10^(35.25/20)).*b,a,y_tot);
 fil_Y=fft(y_fil,8192);
 subplot(2,1,2);
 plot((0:8191)/8192*2,20.*log10(abs(fil_Y)));
 grid;
 ylabel('dB');
 title('filtered signal');
 sound(y_fil,Fs)
%---------------------------------------------------------------
% Cheby1
[y,Fs]=wavread('guitar1.wav');
n=0:length(y)-1;
y_10=sin(2*pi*10000*n./Fs);
y_tot=y_10.'+y;
Fs=44100;
wp=7000/(Fs/2);
ws=9000/(Fs/2);
rp=1;
rs=40;
[n,Wn]=cheb1ord(wp,ws,rp,rs) 
[b,a]=cheby1(n,1,Wn)
[Hz,w]=freqz((10^(35.25/20))*b,a,1024);% DC gain of transfer function in numerator
 Y_tot=fft(y_tot,8192);
 subplot(2,1,1);
 plot((0:8191)/8192*2,20.*log10((abs(Y_tot))));
 grid;
 ylabel('dB');
 title('complex signal');
 %-------------before filtered
 y_fil=filter((10^(35.25/20)).*b,a,y_tot);
 fil_Y=fft(y_fil,8192);
 subplot(2,1,2);
 plot((0:8191)/8192*2,20.*log10(abs(fil_Y)));
 ylabel('dB');
 title('filtered signal');
 sound(y_fil,Fs)
 %--------------------------------------------------------------------
 %  Elliptic
[y,Fs]=wavread('guitar1.wav');
n=0:length(y)-1;
y_10=sin(2*pi*10000*n./Fs);
y_tot=y_10.'+y;
Fs=44100;
wp=7000/(Fs/2);
ws=9000/(Fs/2);
rp=1;
rs=40;
[n,Wn]=ellipord(wp,ws,rp,rs) 
[b,a]=ellip(n,wp,ws,Wn,'low')
[Hz,w]=freqz((10^(35.25/20))*b,a,1024); % DC gain of transfer function in numerator
 Y_tot=fft(y_tot,8192);
 subplot(2,1,1);
 plot((0:8191)/8192*2,20.*log10((abs(Y_tot))));
 ylabel('dB');
 title('complex signal');
 %-------------before filtered
 y_fil=filter((10^(35.25/20)).*b,a,y_tot);
 fil_Y=fft(y_fil,8192);
 subplot(2,1,2);
 plot((0:8191)/8192*2,20.*log10(abs(fil_Y)));
 ylabel('dB');
 title('filtered signal');
 sound(y_fil,Fs)
 
 %% FIR filter
 %Hanning
[y,Fs]=wavread('guitar1.wav');
 n=0:length(y)-1;
 y_10=sin(2*pi*10000*n./Fs);% angular frequency = 2* pi * f
 y_tot=y_10.'+y;
 Y_tot=fft(y_tot,8192);
 wp=7000/(Fs/2);
 ws=9000/(Fs/2);
 n=ceil(8/(ws-wp)); 
 b=fir1(n,(wp+ws)/2,hanning(n+1)); % call the funcation b = fir1(n,Wn,ftype)
 [Hz,w]=freqz(b,1,1024,Fs); 
 figure
 subplot(2,1,1),plot(w,20*log10(abs(Hz)));
 xlabel('frequency');ylabel('amplitude');grid
 subplot(2,1,2),plot(w,180/pi*unwrap(angle(Hz)));% use unwrap to prevent vibration
 xlabel('frequency');ylabel('phase');grid
 %Hammming 
 [y,Fs]=wavread('guitar1.wav');
 n=0:length(y)-1;
 y_10=sin(2*pi*10000*n./Fs);% angular frequency = 2* pi * f
 y_tot=y_10.'+y;
 Y_tot=fft(y_tot,8192);
 wp=7000/(Fs/2);
 ws=9000/(Fs/2);
 n=floor(8/(ws-wp)); 
 b=fir1(n,(wp+ws)/2,hamming(n+1)); % call the funcation b = fir1(n,Wn,ftype)
 [Hz,w]=freqz(b,1,1024,Fs); 
 figure
 subplot(2,1,1),plot(w,20*log10(abs(Hz)));
 xlabel('frequency');ylabel('amplitude');grid
 subplot(2,1,2),plot(w,180/pi*unwrap(angle(Hz)));% use unwrap to prevent vibration
 xlabel('frequency');ylabel('phase');grid
 %% designed filter with two windows 
 [y,Fs]=wavread('guitar1.wav');
 n=0:length(y)-1;
 y_10=sin(2*pi*10000*n./Fs);% angular frequency = 2* pi * f
 y_tot=y_10.'+y;
 Y_tot=fft(y_tot,8192);
 wp=7000/(Fs/2);
 ws=9000/(Fs/2);
 n=floor(8/(ws-wp)); 
 b=fir1(n,(wp+ws)/2,hanning(n+1)); % call the funcation b = fir1(n,Wn,ftype)
 [Hz,w]=freqz(b,1,1024,Fs); 
 y=fftfilt(b,y_tot);
 subplot(2,1,1);
 Y_hanfil=fft(y,8192);
 figure
 subplot(2,1,1)
 plot((0:8191),20*log10((abs(Y_hanfil))));
 ylabel('dB');
 subplot(2,1,2);
 plot((0:8191)/8192*2,(abs(Y_hanfil)));
 ylabel('amplitude');
 sound(y,Fs)
 %-----------------hamming filtering
  [y,Fs]=wavread('guitar1.wav');
 n=0:length(y)-1;
 y_10=sin(2*pi*10000*n./Fs);% angular frequency = 2* pi * f
 y_tot=y_10.'+y;
 Y_tot=fft(y_tot,8192);
 wp=7000/(Fs/2);
 ws=9000/(Fs/2);
 n=floor(8/(ws-wp)); 
 b=fir1(n,(wp+ws)/2,hamming(n+1)); % call the funcation b = fir1(n,Wn,ftype)
 [Hz,w]=freqz(b,1,1024,Fs); 
 y=fftfilt(b,y_tot);
 subplot(2,1,1);
 Y_hanfil=fft(y,8192);
 figure
 subplot(2,1,1)
 plot((0:8191),20*log10((abs(Y_hanfil))));
 ylabel('dB');
 subplot(2,1,2);
 plot((0:8191)/8192*2,(abs(Y_hanfil)));
 ylabel('amplitude');
 sound(y,Fs)
 
 %% ------------------------------PART II   DECODE DTMF
 % signal characteristics
 [y,Fs]=audioread('2015_final.wav');
 % Plot original signal
 figure('Name','Original Signal')
 subplot(2,1,1)
 plot((0:length(y)-1)./Fs,y);
 grid on
 %set(gca,'Fontsize',fontsize);
 xlabel('Time (s)');
 subplot(2,1,2)
 plot((0:100-1)./Fs,y(1:100));
 grid on
 xlim([0 100-1]./Fs)
 ylim([min(y(1:100)) max(y)])
 %set(gca,'Fontsize',fontsize);
 xlabel('Time (s)');
 % plot freqeuncy response of original signal
 L=length(y);
 NFFT=2^nextpow2(L);
 fft_result_temp=fft(y,NFFT)/L;
 frequency=Fs/2*linspace(0,1,NFFT/2+1);
 fft_result=fft_result_temp(1:NFFT/2+1);
 figure('Name','Frequency Response of Original Signal')
 subplot(2,1,1);
 plot(frequency,20*log10(abs(fft_result)));
 
%% Kaiser FIR filter 1
[y,Fs]=audioread('2015_final.wav');
Fs
 f_min1=697;
 f_max1=941;
 
 A=60;
 Delta_w=300/Fs*2*pi;
 M=ceil((A-8)/(2.285*Delta_w)+1);
 if mod(M,2)==0
    M=M+1;
 end
 beta=0.1102*(A-8.7);
 wn=kaiser(M,beta);
 cut_off_w=([f_min1 f_max1]+[f_min1-300 f_max1+300])./2./Fs.*2.*pi;
 n=0:M-1;
 hn=max(cut_off_w)./pi.*sinc(max(cut_off_w)./pi.*(n-(M-1)/2))-min(cut_off_w)./pi.*sinc(min(cut_off_w)./pi.*(n-(M-1)/2));
 hn_Kai=hn.*wn';
 % Kaiser window in time domain
 figure
 subplot(2,1,1)
 stem(n,wn);
 grid on
 xlabel('Sample')
 ylabel('w[n]')
% impulse response of Kaiser
 subplot(2,1,2)
 stem(n,hn_Kai);
 grid on
 xlabel('Sample')
 ylabel('hn_Kai[n]')
 
 % Frequency response
 [H,f]=freqz(hn_Kai,1,length(y),'half',Fs);
 figure('Name','Frequency response')
 subplot(2,1,1)
 plot(f,20*log10(abs(H)));
 grid on
 xlabel('Frequency (Hz)')
 ylabel('Amplitude (dB)')
 
 subplot(2,1,2)
 plot(f,abs(H));
 grid on
 xlabel('Frequency (Hz)')
 ylabel('Amplitude')
 
 figure('Name','group delay')
 subplot(2,1,1)
 plot(f,angle(H));
 grid on
 xlabel('Frequency (Hz)')
 ylabel('Phase (radians)')
 
 subplot(2,1,2)
 [gd,f]=grpdelay(hn_Kai,1,length(y),'half',Fs);
 plot(f,gd);
 grid on
 xlabel('Frequency (Hz)')
 ylabel('Grop delay')
 
 figure('Name','zero-pole plot')
 [z,p,k]=zplane(hn_Kai,1);
 grid on
 xlabel('Real part')
 ylabel('Imaginary part')
 % filtered signal by using FIR bandpass filter
 filtered_signal_FIR=conv(y',hn_Kai);
 filtered_signal_FIR=filtered_signal_FIR(1:length(y))';
 
 %% Kaiser FIR filter 2
 [y,Fs]=audioread('2015_final.wav');
Fs
 f_min1=1209;
 f_max1=1633;
 
 A=60;
 Delta_w=300/Fs*2*pi;
 M=ceil((A-8)/(2.285*Delta_w)+1);
 if mod(M,2)==0
    M=M+1;
 end
 beta=0.1102*(A-8.7);
 wn=kaiser(M,beta);
 cut_off_w=([f_min1 f_max1]+[f_min1-300 f_max1+300])./2./Fs.*2.*pi;
 n=0:M-1;
 hn=max(cut_off_w)./pi.*sinc(max(cut_off_w)./pi.*(n-(M-1)/2))-min(cut_off_w)./pi.*sinc(min(cut_off_w)./pi.*(n-(M-1)/2));
 hn_Kai=hn.*wn';
 % Kaiser window in time domain
 figure
 subplot(2,1,1)
 stem(n,wn);
 grid on
 xlabel('Sample')
 ylabel('w[n]')
% impulse response of Kaiser
 subplot(2,1,2)
 stem(n,hn_Kai);
 grid on
 xlabel('Sample')
 ylabel('hn_Kai[n]')
 
 % Frequency response
 [H,f]=freqz(hn_Kai,1,length(y),'half',Fs);
 figure('Name','Frequency response')
 subplot(2,1,1)
 plot(f,20*log10(abs(H)));
 grid on
 xlabel('Frequency (Hz)')
 ylabel('Amplitude (dB)')
 
 subplot(2,1,2)
 plot(f,abs(H));
 grid on
 xlabel('Frequency (Hz)')
 ylabel('Amplitude')
 
 figure('Name','group delay')
 subplot(2,1,1)
 plot(f,angle(H));
 grid on
 xlabel('Frequency (Hz)')
 ylabel('Phase (radians)')
 
 subplot(2,1,2)
 [gd,f]=grpdelay(hn_Kai,1,length(y),'half',Fs);
 plot(f,gd);
 grid on
 xlabel('Frequency (Hz)')
 ylabel('Grop delay')
 
 figure('Name','zero-pole plot')
 [z,p,k]=zplane(hn_Kai,1);
 grid on
 xlabel('Real part')
 ylabel('Imaginary part')
 % filtered signal by using FIR bandpass filter
 filtered_signal_FIR=conv(y',hn_Kai);
 filtered_signal_FIR=filtered_signal_FIR(1:length(y))';
 
 %% IIR filter 
 % butterworth bandpass filter 1
 [y,Fs]=audioread('2015_final.wav');
 f_min1=697;
 f_max1=941;
 wp=[f_min1 f_max1]./(Fs/2);
 ws=[f_min1-300 f_max1+300]./(Fs/2);
 rp=3;
 rs=60;
 
 [n,wn]=buttord(wp,ws,rp,rs)
 [b,a]=butter(n,wn)

 
 [H,f]=freqz(b,a,length(y),'half',Fs);
 
 figure('Name','Frequency response of Butterworth bandpass filter')
 subplot(3,1,1)
 plot(f,20*log10(abs(H)));
 grid on
 xlabel('Frequency/Hz')
 ylabel('Amplitude/dB')
 
 subplot(3,1,2)
 plot(f,abs(H));
 grid on
 xlabel('Frequency/Hz')
 ylabel('Amplitude')
 
 subplot(3,1,3)
 plot(f,angle(H));
 grid on
 xlabel('Frequency/Hz')
 ylabel('Phase/radians')
 
 [gd,f]=grpdelay(b,a,length(y),'half',Fs);
 figure
 plot(f,gd);
 grid on
 xlabel('Frequency/Hz')
 ylabel('Group delay')
 
 figure('Name','zero-pole plot of Butterworth bandpass filter')
 [z,p,k]=zplane(b,a);
 grid on
 xlabel('Real part')
 ylabel('Imaginary part')
 
 %%  
 % butterworth bandpass filter 2
 [y,Fs]=audioread('2015_final.wav');
 f_min1=1209;
 f_max1=1633;
 wp=[f_min1 f_max1]./(Fs/2);
 ws=[f_min1-300 f_max1+300]./(Fs/2);
 rp=3;
 rs=60;
 
 [n,wn]=buttord(wp,ws,rp,rs)
 [b,a]=butter(n,wn)
 %filtered Y=filter(b,a,Y);
 
 [H,f]=freqz(b,a,length(y),'half',Fs);
 
 figure('Name','Frequency response of Butterworth bandpass filter')
 subplot(3,1,1)
 plot(f,20*log10(abs(H)));
 grid on
 xlabel('Frequency/Hz')
 ylabel('Amplitude/dB')
 
 subplot(3,1,2)
 plot(f,abs(H));
 grid on
 xlabel('Frequency/Hz')
 ylabel('Amplitude')
 
 subplot(3,1,3)
 plot(f,angle(H));
 grid on
 xlabel('Frequency/Hz')
 ylabel('Phase/radians')
 
 [gd,f]=grpdelay(b,a,length(y),'half',Fs);
 figure
 plot(f,gd);
 grid on
 xlabel('Frequency/Hz')
 ylabel('Group delay')
 
 figure('Name','zero-pole plot of Butterworth bandpass filter')
 [z,p,k]=zplane(b,a);
 grid on
 xlabel('Real part')
 ylabel('Imaginary part')
 
 %% Butterworth bandpass filter 1 detailed scale
 [y,Fs]=audioread('2015_final.wav');
 f_min1=697;
 f_max1=941;
%  f_min=1209;
%  f_max=1633;
 wp=[f_min1 f_max1]./(Fs/2);
 ws=[f_min1-300 f_max1+300]./(Fs/2);
 rp=3;
 rs=60;
 
 [n,wn]=buttord(wp,ws,rp,rs);
 [b,a]=butter(n,wn);
 %filtered Y=filter(b,a,Y);
 
 [H,f]=freqz(b,a,length(y),'half',Fs);
 figure
 plot(f,abs(H));
 grid on
 xlabel('Frequency/Hz')
 ylabel('Amplitude')
 
%% filtering the original sample using two butherworth bandpass filter
[y,Fs]=audioread('2015_final.wav');
 f_min1=697;
 f_max1=941;
 wp1=[f_min1 f_max1]./(Fs/2);
 ws1=[f_min1-300 f_max1+300]./(Fs/2);
 rp=3;
 rs=60;
 [n1,wn1]=buttord(wp1,ws1,rp,rs);
 [b1,a1]=butter(n1,wn1);
 filtered_y1=filter(b1,a1,y);
 
 f_min2=1209;
 f_max2=1633;
 wp2=[f_min2 f_max2]./(Fs/2);
 ws2=[f_min2-300 f_max2+300]./(Fs/2);
 [n2,wn2]=buttord(wp2,ws2,rp,rs)
 [b2,a2]=butter(n2,wn2)
 filtered_y2=filter(b2,a2,y);

 fil_y= filtered_y1+ filtered_y2;
 sound(fil_y,Fs)
 
%% decoding key presses
% total signal in time domain

 high_fil_y=find( fil_y >=0.5* max(fil_y));
 diff_high_fil_y=diff(high_fil_y);
 large_diff_high_fil_y=find(diff_high_fil_y>=400); %400 samples > 0.05s
 L_focus=zeros(12,1); %store length
 focus=zeros(12,800); % Assume that 1 part contains 800
 %samples (400*12+800*12=14400)
 for k=1:12
     if k==1
          focus_temp=fil_y(high_fil_y(1):high_fil_y(large_diff_high_fil_y(k)));
     elseif k==12
          focus_temp=fil_y(high_fil_y(large_diff_high_fil_y(k-1)+1):high_fil_y(end));
     else
         focus_temp=fil_y(high_fil_y(large_diff_high_fil_y(k-1)+1):high_fil_y(large_diff_high_fil_y(k)));
     end
     L_focus(k)=length(focus_temp);
     focus(k,1:length(focus_temp))=focus_temp;
 end
 
 figure('Name','Different parts')
  for k=1:12
     subplot(3,4,k)
     plot(0:L_focus(k)-1,focus(k,1:L_focus(k)));
     grid on
     xlabel(['Samples (part ' num2str(k) ')'])
     %ylabel(['Part ' num2str(k)],'Fontsize',fontsize)
 end
 
 %%
 f_focus=zeros(10,2^nextpow2(800)/2+1); %store frequency
 mag_focus=zeros(10,2^nextpow2(800)/2+1); %store magnitude (linear unit)
 for k=1:12
 signal=focus(k,1:L_focus(k));
 L=length(signal);
 NFFT=2^nextpow2(L);
 fft_result_temp=fft(signal,NFFT)/L;
 frequency=Fs/2*linspace(0,1,NFFT/2+1);
 fft_result=fft_result_temp(1:NFFT/2+1);
 f_focus(k,1:length(frequency))=frequency;
 mag_focus(k,1:length(fft_result))=abs(fft_result);
 end
 % Display frequency responses of different parts
 figure('Name','Frequency reponses of different parts')
 
 
 