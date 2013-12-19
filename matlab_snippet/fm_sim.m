clear all;
clc;
N=1000;
fs=10000;
ts=1/fs;
t=(-N/2*ts):ts:(N/2-1)*ts;
fm=20;
fc=500;
m_t=sin(2*pi*t*fm);
%m_t= tripuls(t,0.025);
Ac=1;
k_FM=300;%不能太小
rang = [-N/2*ts,N/2*ts-ts,-1.1*Ac,+1.1*Ac];
s_FM_t = Ac*cos(2*pi*fc*t+2*pi*k_FM*cumsum(m_t)*ts);
s_fc_t = Ac*cos(2*pi*fc*t);

s_d_t = diff(s_FM_t);

envolope = abs(hilbert(s_d_t));
%用希尔伯特变换实现包络检波（实际电路采用RC二极管电路实现）
envolope = envolope-mean(envolope);%减去直流分量
recv_m_t = Ac*envolope/max(envolope);

set(text,'Interpreter','latex')
subplot(5,1,1);
plot(t,m_t);
xlabel('时间');
ylabel('幅度');
title('消息信号 {m(t)}');
axis(rang);

subplot(5,1,2);
plot(t,s_fc_t);
xlabel('时间');
ylabel('幅度');
title('载波信号 {s_{FC}(t)}');
axis(rang);

subplot(5,1,3);
plot(t,s_FM_t);
xlabel('时间');
ylabel('幅度');
title('调制信号 {s_{FM}(t)}');
axis(rang);

subplot(5,1,4);
plot(t(1:length(t)-1),abs(s_d_t));
xlabel('时间');
ylabel('幅度');
title('调制信号通过微分器 {s_d(t)}');
%axis(rang);

subplot(5,1,5);
plot(t(1:length(t)-1),recv_m_t);
xlabel('时间');
ylabel('幅度');
title('通过包络检波解调出消息信号{m_{recv}(t)}');
axis(rang);