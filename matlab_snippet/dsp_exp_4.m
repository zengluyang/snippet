% （1）	给定输入信号：FSK信号（输入的二进制待调信号为随机信号，码元频率为500Hz，
% 两个载频分别为2kHz和4kHz，采样频率为20kHz，）。利用MATLAB编程产生本信号，画出其
% 时域和频域的图像。
% （2）	利用MATLAB编程设计一个数字低通滤波器，指标要求如下：
% 通带截止频率: ;阻带截止频率: ;采样频率 ；通带峰值起伏： ；最小阻带衰减： 。
% （3）	分别用MATLAB中的IIR和FIR设计命令进行滤波器设计，得出需要的滤波器系数。
% （4）	（拓展要求）用MATLAB滤波器辅助设计软件对上述滤波器进行设计,并将得到的滤波
% 器系数对输入信号进行滤波，观察滤波实现。
% （5）	将得到的滤波器系数在MATLAB中编程进行实现（选择直接型实现结果进行实现），
% 对（1）中的输入信号进行滤波（分别用FIR和IIR滤波器进行），观察滤波结果，画出时域
% 和频域图像。
% （6）	（拓展要求）修改需要设计的滤波器的指标要求，比如：将通带截止频率修改
% 为2kHz,或者将最小阻带衰减改为 ，这时再重复（3）和（5）的步骤，观察所得到的滤波器
% 效果，并对这一结果进行解释。
% （7）	（拓展要求）在提供的DSP实验板上编程对滤波器滤波过程进行实现，观察实际的滤
% 波结果，并与理论结果对比。
clear all;
clc;clf;

%% 产生输入FSK信号的程序
N = 16;                                 %bit流位数
bit_stream = round(rand(1,N))           %产生随机bit流
f0 = 2000;                              %'0'载波频率
f1 = 4000;                              %'1'载波频率
Rb = 500;                               %码元频率
ts = 1/Rb;                              %码字间隔
fs = 20000;                             %采样频率
A = 1;                                  %调制信号幅度
t = 0: 1/fs : ts;                       %单个码元时间
time = [];                              %整个信号的时间 
low = zeros(1,length(t));               %低电平
high = ones(1,length(t));               %高电平
digital_signal = [];                    %数字基带信号
FSK_signal = [];                        %FSK调制信号

for ii = 1 : length(bit_stream)         %产生PSK调制信号
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

N_fft = 1024;                           %FFT点数
FSK_freq_mag = abs(fftshift(fft(FSK_signal,N_fft)));
freq = -fs/2:fs/N_fft:fs/2-1/2*fs/N_fft;

subplot(3,1,1);
plot(time,digital_signal);
axis([time(1) time(end) -0.2 1.2]);
xlabel('时间');
ylabel('幅度/s');
title('基带信号');

subplot(3,1,2);
plot(time,FSK_signal);
axis([time(1) time(end) -1.2*A 1.2*A]);
xlabel('时间/s');
ylabel('幅度');
title('FSK调制信号');

subplot(3,1,3);
plot(freq,FSK_freq_mag);
axis tight;
xlabel('频率/Hz');
ylabel('幅度');
title('FSK调制信号频域幅度');

%% FIR滤波器设计程序

fcuts = [2200 3500];
mags = [1 0];
devs = [1-10^(-1/20) 10^(-40/20)];
[N_FIR,Wn_FIR,beta,ftype] = kaiserord(fcuts,mags,devs,fs);
b_FIR = fir1(N_FIR,Wn_FIR,kaiser(N_FIR+1,beta));
figure(2);freqz(b_FIR);title('FIR滤波器频率响应');
%% IIR滤波器设计程序
Wp = 2200/(fs/2);
Ws = 3500/(fs/2);
Rp = 1;
Rs = 40;
[N_IIR, Wn_IIR] = buttord(Wp, Ws, Rp, Rs);
[b_IIR,a_IIR] = butter(N_IIR,Wn_IIR);
figure(3);freqz(b_IIR,a_IIR);title('IIR滤波器频率响应');
%% FIR滤波器实现程序（用滤波器系数对输入信号进行滤波）
y_FIR = filter(b_FIR,1,FSK_signal);
y_FIR_freq_mag = abs(fftshift(fft(y_FIR,N_fft)));
freq_FIR = -fs/2:fs/N_fft:fs/2-1/2*fs/N_fft;
figure(4);
subplot(4,1,1);
plot(time,y_FIR);
axis tight;
xlabel('时间/s');
ylabel('幅度');
title('FSK调制信号通过FIR LPF时域波形');

subplot(4,1,2);
plot(freq_FIR,y_FIR_freq_mag);
axis tight;
xlabel('频率/Hz');
ylabel('幅度');
title('FSK调制信号通过FIR LPF频域幅度');

% IIR滤波器实现程序（用滤波器系数对输入信号进行滤波）
y_IIR = filter(b_IIR,a_IIR,FSK_signal);
y_IIR_freq_mag = abs(fftshift(fft(y_IIR,N_fft)));
freq_IIR = -fs/2:fs/N_fft:fs/2-1/2*fs/N_fft;

subplot(4,1,3);
plot(time,y_IIR);
axis tight;
xlabel('时间/s');
ylabel('幅度');
title('FSK调制信号通过IIR LPF时域波形');

subplot(4,1,4);
plot(freq_IIR,y_IIR_freq_mag);
axis tight;
xlabel('频率/Hz');
ylabel('幅度');
title('FSK调制信号通过IIR LPF频域幅度');