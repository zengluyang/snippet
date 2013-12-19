% ��1��	���������źţ�FSK�źţ�����Ķ����ƴ����ź�Ϊ����źţ���ԪƵ��Ϊ500Hz��
% ������Ƶ�ֱ�Ϊ2kHz��4kHz������Ƶ��Ϊ20kHz����������MATLAB��̲������źţ�������
% ʱ���Ƶ���ͼ��
% ��2��	����MATLAB������һ�����ֵ�ͨ�˲�����ָ��Ҫ�����£�
% ͨ����ֹƵ��: ;�����ֹƵ��: ;����Ƶ�� ��ͨ����ֵ����� ����С���˥���� ��
% ��3��	�ֱ���MATLAB�е�IIR��FIR�����������˲�����ƣ��ó���Ҫ���˲���ϵ����
% ��4��	����չҪ����MATLAB�˲��������������������˲����������,�����õ����˲�
% ��ϵ���������źŽ����˲����۲��˲�ʵ�֡�
% ��5��	���õ����˲���ϵ����MATLAB�б�̽���ʵ�֣�ѡ��ֱ����ʵ�ֽ������ʵ�֣���
% �ԣ�1���е������źŽ����˲����ֱ���FIR��IIR�˲������У����۲��˲����������ʱ��
% ��Ƶ��ͼ��
% ��6��	����չҪ���޸���Ҫ��Ƶ��˲�����ָ��Ҫ�󣬱��磺��ͨ����ֹƵ���޸�
% Ϊ2kHz,���߽���С���˥����Ϊ ����ʱ���ظ���3���ͣ�5���Ĳ��裬�۲����õ����˲���
% Ч����������һ������н��͡�
% ��7��	����չҪ�����ṩ��DSPʵ����ϱ�̶��˲����˲����̽���ʵ�֣��۲�ʵ�ʵ���
% ��������������۽���Աȡ�
clear all;
clc;clf;

%% ��������FSK�źŵĳ���
N = 16;                                 %bit��λ��
bit_stream = round(rand(1,N))           %�������bit��
f0 = 2000;                              %'0'�ز�Ƶ��
f1 = 4000;                              %'1'�ز�Ƶ��
Rb = 500;                               %��ԪƵ��
ts = 1/Rb;                              %���ּ��
fs = 20000;                             %����Ƶ��
A = 1;                                  %�����źŷ���
t = 0: 1/fs : ts;                       %������Ԫʱ��
time = [];                              %�����źŵ�ʱ�� 
low = zeros(1,length(t));               %�͵�ƽ
high = ones(1,length(t));               %�ߵ�ƽ
digital_signal = [];                    %���ֻ����ź�
FSK_signal = [];                        %FSK�����ź�

for ii = 1 : length(bit_stream)         %����PSK�����ź�
    if bit_stream(ii)==0
        digital_signal = [digital_signal low];
        FSK_signal = [FSK_signal A*cos(2*pi*f0*t)];
    end
     
    if bit_stream(ii)==1
        digital_signal = [digital_signal high];
        FSK_signal = [FSK_signal A*cos(2*pi*f1*t)];
    end
    time = [time t];
    t=t+ts;
end

N_fft = 1024;                           %FFT����
FSK_freq_mag = abs(fftshift(fft(FSK_signal,N_fft)));
freq = -fs/2:fs/N_fft:fs/2-1/2*fs/N_fft;

subplot(3,1,1);
plot(time,digital_signal);
axis([time(1) time(end) -0.2 1.2]);
xlabel('ʱ��');
ylabel('����/s');
title('�����ź�');

subplot(3,1,2);
plot(time,FSK_signal);
axis([time(1) time(end) -1.2*A 1.2*A]);
xlabel('ʱ��/s');
ylabel('����');
title('FSK�����ź�');

subplot(3,1,3);
plot(freq,FSK_freq_mag);
axis tight;
xlabel('Ƶ��/Hz');
ylabel('����');
title('FSK�����ź�Ƶ�����');

%% FIR�˲�����Ƴ���

fcuts = [2200 3500];
mags = [1 0];
devs = [1-10^(-1/20) 10^(-40/20)];
[N_FIR,Wn_FIR,beta,ftype] = kaiserord(fcuts,mags,devs,fs);
b_FIR = fir1(N_FIR,Wn_FIR,kaiser(N_FIR+1,beta));
figure(2);freqz(b_FIR);title('FIR�˲���Ƶ����Ӧ');
%% IIR�˲�����Ƴ���
Wp = 2200/(fs/2);
Ws = 3500/(fs/2);
Rp = 1;
Rs = 40;
[N_IIR, Wn_IIR] = buttord(Wp, Ws, Rp, Rs);
[b_IIR,a_IIR] = butter(N_IIR,Wn_IIR);
figure(3);freqz(b_IIR,a_IIR);title('IIR�˲���Ƶ����Ӧ');
%% FIR�˲���ʵ�ֳ������˲���ϵ���������źŽ����˲���
y_FIR = filter(b_FIR,1,FSK_signal);
y_FIR_freq_mag = abs(fftshift(fft(y_FIR,N_fft)));
freq_FIR = -fs/2:fs/N_fft:fs/2-1/2*fs/N_fft;
figure(4);
subplot(4,1,1);
plot(time,y_FIR);
axis tight;
xlabel('ʱ��/s');
ylabel('����');
title('FSK�����ź�ͨ��FIR LPFʱ����');

subplot(4,1,2);
plot(freq_FIR,y_FIR_freq_mag);
axis tight;
xlabel('Ƶ��/Hz');
ylabel('����');
title('FSK�����ź�ͨ��FIR LPFƵ�����');

% IIR�˲���ʵ�ֳ������˲���ϵ���������źŽ����˲���
y_IIR = filter(b_IIR,a_IIR,FSK_signal);
y_IIR_freq_mag = abs(fftshift(fft(y_IIR,N_fft)));
freq_IIR = -fs/2:fs/N_fft:fs/2-1/2*fs/N_fft;

subplot(4,1,3);
plot(time,y_IIR);
axis tight;
xlabel('ʱ��/s');
ylabel('����');
title('FSK�����ź�ͨ��IIR LPFʱ����');

subplot(4,1,4);
plot(freq_IIR,y_IIR_freq_mag);
axis tight;
xlabel('Ƶ��/Hz');
ylabel('����');
title('FSK�����ź�ͨ��IIR LPFƵ�����');