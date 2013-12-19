%2-DPSK mod and demod
%Zeng Luyang
%2010013060009
%设计任务：
%	用MatLab仿真一个DPSK通信系统，基本参数：
%1）fc=1800Hz；
%2）Rb=1200bps；
%3）AWGN信道，Eb/N0=20dB
%4）自定义一小段信息序列

clear all;
clc;
%-------------------------------产生消息码字--------------------------------

N = 25;
bit_stream = round(rand(1,N))					%产生随机bit流
% h_ = dec2binvec(104,8);
% e_ = dec2binvec(101,8);
% l_ = dec2binvec(108,8);
% l_ = dec2binvec(108,8);
% o_ = dec2binvec(111,8);
% bit_stream = [h_ e_ l_ l_ o_]; 				%自定义信息序列 
														%'hello'的ascii码 
%--------------------------------------------------------------------------

%-----------------------------------参数设置--------------------------------

p1 = 0; 											%初始相位

fc = 1800;											%载波频率
Rb = 1200;
ts = 1/Rb;											%码字间隔
fs = 50*Rb;										%采样频率
A = 1;												%调制信号幅度
%--------------------------------------------------------------------------

t = 0: 1/fs : ts;									%单个码元时间

%=================================发送端===================================
%==========================================================================
time = [];
diff_bit_stream = [];								%相对码
DPSK_signal = [];									%DPSK调制信号
digital_signal = [];								%单极性NRZ基带信号（绝对码）
diff_signal = [];									%双极性NRZ基带信号（相对码）
carrier_signal=[];								%载波信号

low = -1*ones(1,length(t)); 						%低电平
zero = zeros(1,length(t)); 						%零电平
high = ones(1,length(t));						%高电平

%---------------------产生相对码和 相对码的双极性NRZ基带信号---------------------
for ii = 1 : length(bit_stream)					
    if bit_stream(ii)==0
        digital_signal = [digital_signal zero];
    end
     
    if bit_stream(ii)==1
        digital_signal = [digital_signal high];
    end
    
    if(ii==1)
        prev_diff_bit = 1;
    else 
        prev_diff_bit = diff_bit_stream(ii-1);
    end
    diff_bit_stream = [diff_bit_stream xor(prev_diff_bit,bit_stream(ii))];
    if diff_bit_stream(ii)==0
        diff_signal = [diff_signal low];
    end
     
    if diff_bit_stream(ii)==1
        diff_signal = [diff_signal high];
    end
   
    time = [time t];
    t=t+ts;
end
%--------------------------------------------------------------------------

diff_bit_stream
carrier_signal = sin(2*pi*fc*time);				%产生载波信号
DPSK_signal = carrier_signal.*diff_signal;		%产生调制信号


carrier_signal = A*carrier_signal;				%调制幅度处理
DPSK_signal = A*DPSK_signal;						%调制幅度处理
 
%-------------------------------产生噪声信号--------------------------------
Eb = 0.5*A^2;
N0 = Eb/10^2;%SNR=20dB
sigma = sqrt(N0/2);
noise_signal = normrnd(0,sigma,[1,length(time)]);
%--------------------------------------------------------------------------

DPSK_recv_signal = DPSK_signal+noise_signal;	%信号通过AWGN信道

%-------------------------------绘制发送端波形------------------------------

figure(1);											%绘制绝对码单极性NRZ基带信号
subplot(5,1,1);
plot(time,digital_signal);
xlabel('时间');
ylabel('幅度');
title('绝对码');
axis([0 time(end) -0.1 1.2*A]);
grid on;

subplot(5,1,2);									%绘制相对对码双极性NRZ基带信号
plot(time,diff_signal);
xlabel('时间');
ylabel('幅度');
title('相对码(经过了电平转换)');
axis([0 time(end) -1.2*A 1.2*A]);
grid on;

subplot(5,1,3);									%绘制载波信号
plot(time,carrier_signal);
xlabel('时间');
ylabel('幅度');
title('载波');
axis([0 time(end) -1.2*A 1.2*A]);
grid  on;  
 
subplot(5,1,4);									%绘制DPSK 调制信号信号
plot(time, DPSK_signal);
xlabel('时间');
ylabel('幅度');
title('DPSK 调制信号');
axis([0 time(end) -1.2*A 1.2*A]);
grid  on;

subplot(5,1,5);									%绘制DPSK 接收信号（通过AWGN信道）
plot(time, DPSK_recv_signal);
xlabel('时间');
ylabel('幅度');
title('DPSK 接收信号（通过AWGN信道）');
axis([0 time(end) -1.2*A 1.2*A]);
grid  on;
%--------------------------------------------------------------------------
%==========================================================================
%==========================================================================

%=================================接收端===================================
%==========================================================================

%---------------------------------通过带通滤波器----------------------------
BPF_order = 20;									%带通滤波器阶数
b_BPF = fir1(BPF_order,[(fc-Rb-500)/(fs/2),(fc+Rb+500)/(fs/2)]);
DPSK_recv_signal_BPF = filter(b_BPF,1,DPSK_recv_signal);
carrier_signal_BPF = filter(b_BPF,1,carrier_signal);
%DPSK_recv_signal_BPF = DPSK_recv_signal;
recv_m_t = DPSK_recv_signal_BPF .* (2*carrier_signal_BPF);
%--------------------------------------------------------------------------

%---------------------------------通过低通滤波器----------------------------
LPF_order = 50;									%低通滤波器阶数
b_LPF = fir1(LPF_order,Rb/(fs/2));
recv_m_t_LPF = filter(b_LPF,1,recv_m_t);
%--------------------------------------------------------------------------
ii=LPF_order;										%滤波器时延
recv_diff_bit_stream = [];						%经过定时抽样判决得到的相对码
V_TH = 0;											%判决门限
recv_diff_signal = [];
%--------------------------------定时抽样判决--------------------------------
while(ii<=length(recv_m_t_LPF))
    if recv_m_t_LPF(ii)>0
        recv_diff_bit_stream = [recv_diff_bit_stream 1];
        recv_diff_signal = [recv_diff_signal high];
    else
        recv_diff_bit_stream = [recv_diff_bit_stream 0];
        recv_diff_signal = [recv_diff_signal low];
    end
    ii = ii + length(t);
end
recv_diff_bit_stream
%--------------------------------------------------------------------------
recv_bit_stream = [];								%经过模2加（异或）得到的绝对码

%----------------------------------模2加（异或）----------------------------
for ii = 1 : length(recv_diff_bit_stream)
    if(ii==1)
        recv_prev_diff_bit = 1;
    else 
        recv_prev_diff_bit = recv_diff_bit_stream(ii-1);
    end
    recv_bit_stream = [recv_bit_stream xor(recv_prev_diff_bit,recv_diff_bit_stream(ii))];
end
recv_bit_stream
%--------------------------------------------------------------------------

recv_digital_signal = [];
for ii = 1 : length(recv_bit_stream)
    if recv_bit_stream(ii)==0
        recv_digital_signal = [recv_digital_signal zero];
    end
     
    if recv_bit_stream(ii)==1
        recv_digital_signal = [recv_digital_signal high];
    end
end

%-------------------------------绘制接收端送端波形--------------------------
figure(2);
subplot(5,1,1);									%绘制DPSK 接收信号 通过BPF
plot(time, DPSK_recv_signal_BPF);
xlabel('时间');
ylabel('幅度');
title('DPSK 接收信号 通过BPF');
axis([0 time(end) -1.2*A 1.2*A]);
grid  on;
subplot(5,1,2);									%绘制DPSK 接收信号 通过BPF 乘以载波
%（相干解调）
plot(time, recv_m_t);
xlabel('时间');
ylabel('幅度');
title('DPSK 接收信号 通过BPF 乘以载波');
axis([0 time(end) -1.2*A 1.2*A]);
grid  on;

subplot(5,1,3);									%绘制再通过LPF的波形
plot(time, recv_m_t_LPF);
xlabel('时间');
ylabel('幅度');
title('通过LPF');
axis([0 time(end) -1.2*A 1.2*A]);
grid  on;

subplot(5,1,4);									%绘制解调出的绝对码双极性NRZ基带信号
plot(time, recv_diff_signal);
xlabel('时间');
ylabel('幅度');
title('接收到端解调出的相对码');
axis([0 time(end) -1.2*A 1.2*A]);
grid  on;

subplot(5,1,5);									%绘制解调出的绝对码单极性NRZ基带信号
plot(time, recv_digital_signal);
xlabel('时间');
ylabel('幅度');
title('接收到端解调出的绝对码（经过了电平转换）');
axis([0 time(end) -0.1*A 1.2*A]);
grid  on; 
%--------------------------------------------------------------------------

%----------------------------绘制功率谱-------------------------------------
N_FFT = 2^16;
figure(3);
subplot(5,1,1)
[p,w]=periodogram(digital_signal,[],N_FFT,fs,'onesided');
w=w(1:fix(length(w)/10));
p=p(1:fix(length(p)/10));
[p_max,i_max]=max(p);
plot(w,p,w(i_max),(p_max),'r*');
xlabel('频率 Hz');
ylabel('功率/频率 W/Hz');
title('绘制绝对码单极性NRZ基带信号 PSD');
axis tight;

subplot(5,1,2)
[p,w]=periodogram(diff_signal,[],N_FFT,fs,'onesided');
w=w(1:fix(length(w)/10));
p=p(1:fix(length(p)/10));
[p_max,i_max]=max(p);
plot(w,p,w(i_max),(p_max),'r*');
xlabel('频率 Hz');
ylabel('功率/频率 W/Hz');
title('绘制相对码双极性NRZ基带信号 PSD');
axis tight;

subplot(5,1,3);
[p,w]=periodogram(carrier_signal,[],N_FFT,fs,'onesided');
w=w(1:fix(length(w)/10));
p=p(1:fix(length(p)/10));
[p_max,i_max]=max(p);
plot(w,p,w(i_max),(p_max),'r*');
xlabel('频率 Hz');
ylabel('功率/频率 W/Hz');
title('载波信号PSD');
axis tight;

subplot(5,1,4)
[p,w]=periodogram(DPSK_signal,[],N_FFT,fs,'onesided');
w=w(1:fix(length(w)/10));
p=p(1:fix(length(p)/10));
[p_max,i_max]=max(p);
plot(w,p,w(i_max),(p_max),'r*');
xlabel('频率 Hz');
ylabel('功率/频率 W/Hz');
title('DPSK 调制信号 PSD');
axis tight;

subplot(5,1,5)
[p,w]=periodogram(DPSK_recv_signal,[],N_FFT,fs,'onesided');
w=w(1:fix(length(w)/10));
p=p(1:fix(length(p)/10));
[p_max,i_max]=max(p);
plot(w,p,w(i_max),(p_max),'r*');
xlabel('频率 Hz');
ylabel('功率/频率 W/Hz');
title('DPSK 接收信号（通过AWGN信道）PSD');
axis tight;

figure(4);
subplot(5,1,1)
[p,w]=periodogram(DPSK_recv_signal_BPF,[],N_FFT,fs,'onesided');
w=w(1:fix(length(w)/10));
p=p(1:fix(length(p)/10));
[p_max,i_max]=max(p);
plot(w,p,w(i_max),(p_max),'r*');
xlabel('频率 Hz');
ylabel('功率/频率 W/Hz');
title('DPSK 接收信号 通过BPF PSD');
axis tight;
subplot(5,1,2)
[p,w]=periodogram(recv_m_t,[],N_FFT,fs,'onesided');
w=w(1:fix(length(w)/10));
p=p(1:fix(length(p)/10));
[p_max,i_max]=max(p);
plot(w,p,w(i_max),(p_max),'r*');
xlabel('频率 Hz');
ylabel('功率/频率 W/Hz');
title('DPSK 接收信号 通过BPF 乘以载波 PSD');
axis tight;

subplot(5,1,3)
[p,w]=periodogram(recv_m_t_LPF,[],N_FFT,fs,'onesided');
w=w(1:fix(length(w)/10));
p=p(1:fix(length(p)/10));
[p_max,i_max]=max(p);
plot(w,p,w(i_max),(p_max),'r*');
xlabel('频率 Hz');
ylabel('功率/频率 W/Hz');
title('再通过LPF PSD');
axis tight;

subplot(5,1,4)
[p,w]=periodogram(recv_diff_signal,[],N_FFT,fs,'onesided');
w=w(1:fix(length(w)/10));
p=p(1:fix(length(p)/10));
[p_max,i_max]=max(p);
plot(w,p,w(i_max),(p_max),'r*');
xlabel('频率 Hz');
ylabel('功率/频率 W/Hz');
title('解调出的相对码双极性NRZ基带信号 PSD');
axis tight;

subplot(5,1,5)
[p,w]=periodogram(recv_digital_signal,[],N_FFT,fs,'onesided');
w=w(1:fix(length(w)/10));
p=p(1:fix(length(p)/10));
[p_max,i_max]=max(p);
plot(w,p,w(i_max),(p_max),'r*');
xlabel('频率 Hz');
ylabel('功率/频率 W/Hz');
title('解调出的绝对码单极性NRZ基带信号 PSD');
axis tight;

%--------------------------------------------------------------------------

%==========================================================================
%==========================================================================
