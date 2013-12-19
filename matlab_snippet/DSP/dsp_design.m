%****************************dsp_design.m**********************************
%**************************************************************************
% Name:                                     ��·��
% Number:                                   2010013060009
% Date:                                     2012-12-18
% Course:                                   Digital Signal Processing 
% Curriculum Design:                        Finite Word Length Effect 
%**************************************************************************
% ---------------------specificaion and description------------------------
% Design a lowpass IIR filter to process a square wave signal with frequency
% being 1kHz, to get a pure sin signal of 1kHz. And suppose the sampling 
% frequency to be 30kHz.
% 
% Use direct II realization, second-order cascade realization and parallel 
% realization structure to process the filtering.
% 
% When filtering, suppose input, filter coefficients and calculation results 
% all are quantized(Preserve two digits after the decimal point). 

% Plot the frequency responose of the IIR filter before quantization.
% plot the frequency responose of the IIR filter after quantization. 
% Compare the outputs of the IIR filter based on three different 
% realization structures. (plot three outputs in one figure)
% -------------------------------------------------------------------------

clear;clc;clf;
prv_digit = 2;                   
%                                               %preserve two digits after
%                                               %the decimal point
%%
%-------------------------signal generation--------------------------------
fs = 30000;                                     %sampling frequency 30kHz
f_sqr = 1000;                                   %square wave frequency 1kHz
t = 0:1/fs:0.01;
sqr = square(2*pi*f_sqr*t);
sqr_qtz = round(sqr*10^prv_digit)/10^prv_digit;	%quantized square wave
%--------------------------------------------------------------------------

%-------------------------IIR filter design--------------------------------
Wp = 1100/(fs/2);                               %passband frequency
Ws = 1800/(fs/2);                               %stopband frequency
Rp = 2;                                         %passband ripple (dB)
Rs = 60;                                        %stopband ripple (dB)
[N,Wn] = buttord(Wp,Ws,Rp,Rs)                   %using Butterworth filter
[num,den] = butter(N,Wn);
%--------------------------------------------------------------------------


%%
%------------------IIR filter implementation: directe II-------------------
num_ = num*10^8.19;
den_ = den*10^8.19;
num_qtz = round(num_*10^(prv_digit))/10^(prv_digit);
den_qtz = round(den_*10^(prv_digit))/10^(prv_digit); 
%                                               %quantilize coeff of filter

y_dir_II = filter_direct2(num_qtz,den_qtz,sqr_qtz);
%                                               %see filter_direct2.m
%--------------------------------------------------------------------------

%%
%-------------IIR filter implementation: second-order cascade--------------
[sos,g] =tf2sos(num,den);
num_cas = [];
den_cas = [];
size_sos=size(sos);
for ii = 1:size_sos(1)
    row = sos(ii,:);
    num_cas = [num_cas;row(1:3)];
    den_cas = [den_cas;row(4:6)];
end
num_cas_qtz = round(num_cas*10^prv_digit)/10^prv_digit;
den_cas_qtz = round(den_cas*10^prv_digit)/10^prv_digit;
%                                               %quantilize coeff of filter
y_2nd_cas = filter_direct2(num_cas_qtz(1,:),den_cas_qtz(1,:),sqr_qtz);
for ii = 2:length(num_cas_qtz)
    y_2nd_cas = filter_direct2(num_cas_qtz(ii,:),den_cas_qtz(ii,:),y_2nd_cas);
end
y_2nd_cas = y_2nd_cas*g;
%                                               %cascading direct II
%                                               %realiztion.


%--------------------------------------------------------------------------
%%
%-----------------IIR filter implementation: parallel II-------------------
% [r,p,k] = residuez(num,den);
% num_para=[];
% den_para=[];
% for ii = 1:length(r)                            %generate num and den for 
%     num_para=[num_para;r(ii)];                  %each part of paralle form
%     den_para=[den_para;1 -p(ii)];
% end
[k, num_para, den_para] = dir2par(num,den);
num_para=num_para*1e10;
den_para=den_para*1e10;
num_para_qtz = round(num_para*10^prv_digit)/10^prv_digit;
den_para_qtz = round(den_para*10^prv_digit)/10^prv_digit;
%                                               %quantilize coeff of filter
y_para_II = filter(num_para_qtz(1,:),den_para_qtz(1,:),sqr_qtz);
for ii =2:length(num_para_qtz)
    y_para_II = y_para_II + filter(num_para_qtz(ii,:),den_para_qtz(ii,:),sqr_qtz);
end
y_para_II = y_para_II + k*sqr_qtz;
%                                               %paralleing direct II
%                                               %transpoed reliztion,
%                                               %as MATLAB function
%                                               %filter uses direct II 
%                                               %transpoed reliztion.
%--------------------------------------------------------------------------

%%
%---------------------------quantized output wave--------------------------
y_dir_II_qtz = round(y_dir_II*10^prv_digit)/10^prv_digit;
y_2nd_cas_qtz = round(y_2nd_cas*10^prv_digit)/10^prv_digit;
y_para_II_qtz = round(y_para_II*10^prv_digit)/10^prv_digit;
%--------------------------------------------------------------------------

%%
y = filter_direct2(num,den,sqr);
err_dir_II_qtz = mean((y_dir_II_qtz-y).^2);
err_2nd_cas_qtz = mean((y_2nd_cas_qtz-y).^2);
err_para_II_qtz = mean((y_para_II_qtz-y).^2);
disp('quantization error:');
fprintf('\tusing direct II relization:\t\t\t\t%d\n',err_dir_II_qtz);
fprintf('\tusing second-order cascade relization:\t%d\n',err_2nd_cas_qtz);
fprintf('\tusing parallel II relization:\t\t\t%d\n',err_para_II_qtz);

%%
%-------------------------------plotting-----------------------------------
figure(1);
subplot(2,1,1);
plot(t,sqr);
title('1kHz�����ź�ʱ����(����ǰ)');
xlabel('ʱ��');
ylabel('����');
axis([t(1) t(length(t)) -1.5 1.5]);

subplot(2,1,2);
plot(t,sqr_qtz);
title('1kHz�����ź�ʱ����(������)');
xlabel('ʱ��');
ylabel('����');
axis([t(1) t(length(t)) -1.5 1.5]);

figure(2);
subplot(3,1,1);
plot(t,y_dir_II_qtz);
title('ֱ��II��ʵ���˲�������źţ�1KHz���Ҳ���(������)');
xlabel('ʱ��');
ylabel('����');
axis([t(1) t(length(t)) -1.5 1.5]);

figure(2);
subplot(3,1,2);
plot(t,y_2nd_cas_qtz);
title('2�׼�����ʵ���˲�������źţ�1KHz���Ҳ���ʱ����(������)');
xlabel('ʱ��');
ylabel('����');
axis([t(1) t(length(t)) -1.5 1.5]);

subplot(3,1,3);
plot(t,y_para_II_qtz);
title('����II��ʵ���˲�������źţ�1KHz���Ҳ���ʱ����(������)');
xlabel('ʱ��');
ylabel('����');

figure(3);
y_dir_II_no_qtz = filter_direct2(num,den,sqr_qtz);
plot(t,y_dir_II_no_qtz);
title('ֱ��II��ʵ���˲�������ź�ʱ����(��������źţ��˲���������������)');
xlabel('ʱ��');
ylabel('����');

figure(4);freqz(num,den,1024,fs);
title('IIR �˲�������ǰƵ����Ӧ');

figure(5);freqz(num_qtz,den_qtz,1024,fs);
title('IIR �˲���������Ƶ����Ӧ');
%--------------------------------------------------------------------------