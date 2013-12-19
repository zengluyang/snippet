clear;clc;
load touch;
n=0:999;
L=1000;
N=2048;
fs=8192;
d0=sin(0.7217.*n)+sin(1.0247.*n);
X1=x1(1:L);
X=fft(d0,2048);
absX2=abs(X).^2;
w=linspace(-pi,pi,2048);
f=(0:N/2-1)/N*fs;
plot(abs(X).^2);hold on;
plot(round(1.0247/pi*1024),0,'r*');
plot(round(0.7217/pi*1024),0,'r*');hold off;
X(round(1.0247/pi*1024))
