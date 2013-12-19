%dsp_exp_3_1.m
%1在MATLAB中设计完成可变采样率采样（抽取）程序
f0 = 500;                                    %sin wave frequency 0.5kHz
f1 = 1000;                                   %sin wave frequency 1.0kHz
%fs_var = input('Input the sampling frequency:');
fs_var = 2200;                
t_var = 0:1/fs_var:0.01;
sig_sa = sin(2*pi*f0*t_var)+sin(2*pi*f1*t_var);
subplot(2,1,1);
stem(t_var,sig_sa);
N_fft=1024;
subplot(2,1,2);
w=-fs_var/2:fs_var/N_fft:fs_var/2-1/2*fs_var/N_fft;
plot(w,abs(fftshift(fft(sig_sa,N_fft))));