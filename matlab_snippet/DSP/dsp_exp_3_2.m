clc;clf;
f1 = 1000;                                   %sin wave frequency 1kHz
f2 = 1100;
f3 = 1200;
%fs_var = input('Input the sampling frequency:');
fs_var=1200;                
t_var = 0:1/fs_var:0.04;
sig_sa = sin(2*pi*f1*t_var)+ sin(2*pi*f2*t_var)+ sin(2*pi*f3*t_var);
subplot(2,1,1);
stem(t_var,sig_sa);
N_fft=1024;
subplot(2,1,2);
w=-fs_var/2:fs_var/N_fft:fs_var/2-1/2*fs_var/N_fft;
plot(w,abs(fftshift(fft(sig_sa,N_fft))));