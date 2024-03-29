% Program 8_3
% Parallel Realizations of an IIR Transfer Function
%
% 因此，从有限字长效应看，直接型（Ⅰ、Ⅱ型）结构最差，运算误差最大，高阶时避免采用。
% 级联型结构较好。并联型结构最好，运算误差最小。

clear;clc;clf;
format compact

fs = 35000;
f_sqr = 1000;                   %square wave signal with frequency 1kHz
t = 0:1/fs:0.01;
sqr = square(2*pi*f_sqr*t);
sqr_qtz = round(sqr*100)/100;   %quantized square wave,preserve two digits
Wp = 1100/(fs/2);               %passband frequency
Ws = 1800/(fs/2);               %stopband frequency
Rp = 2;                         %passband ripple(dB)
Rs = 60;                        %stopband ripple(dB)
[N,Wn] = buttord(Wp,Ws,Rp,Rs)
[num,den] = butter(N,Wn);
% num = [0.44 0.362 0.02];
% den =  [1 0.4 .18 -.2];
[r,p,k] = residue(num,den);
disp('Parallel Form II')
disp('Residues are');disp(r);
disp('Poles are at');disp(p);
disp('Constant value');disp(k);
num_para=[];
den_para=[];
for ii = 1:length(r)
    num_para=[num_para;0 r(ii)];
    den_para=[den_para;1 -p(ii)];
end
num_para_qtz = round(num_para*10^2)/10^2;
den_para_qtz = round(den_para*10^2)/10^2;
y_para_II = filter(num_para_qtz(1,:),den_para_qtz(1,:),sqr_qtz);
for ii =2:length(num_para)
    y_para_II = y_para_II + filter(num_para_qtz(ii,:),den_para_qtz(ii,:),sqr_qtz);
end
y_para_II = y_para_II + k*sqr_qtz;
%y_para_II = real(y_para_II);
y_para_II = y_para_II/max(y_para_II)
y_para_II_qtz = round(y_para_II*100)/100;
plot(t,y_para_II_qtz);