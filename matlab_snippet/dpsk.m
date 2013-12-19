%
%2-DPSK mod and demod
%Zeng Luyang
%2010013060009
%�������
%	��MatLab����һ��DPSKͨ��ϵͳ������������
%1��fc=1800Hz��
%2��Rb=1200bps��
%3��AWGN�ŵ���Eb/N0=20dB
%4���Զ���һС����Ϣ����

clear all;
clc;
N = 25;
bit_stream = round(rand(1,N))			%�������bit��
% h_ = dec2binvec(104,8);
% e_ = dec2binvec(101,8);
% l_ = dec2binvec(108,8);
% l_ = dec2binvec(108,8);
% o_ = dec2binvec(111,8);
% bit_stream = [h_ e_ l_ l_ o_]; 		%�Զ�����Ϣ���� 
										%'hello'��ascii�� 
p1 = 0; 								%��ʼ��λ

fc = 1800;								%�ز�Ƶ��
Rb = 1200;
ts = 1/Rb;								%���ּ��
fs = 100*1200;							%����Ƶ��
A = 1;									%�����źŷ���
t = 0: 1/fs : ts;						%������Ԫʱ��

time = [];
diff_bit_stream = [];					%�����
DPSK_signal = [];						%DPSK�����ź�
Digital_signal = [];					%NRZ�����źţ������룩
diff_signal = [];						%NRZ�����źţ������룩
carrier_signal=[];

low = -1*ones(1,length(t)); 			%�͵�ƽ
zero = zeros(1,length(t)); 				%���ƽ
high = ones(1,length(t));				%�ߵ�ƽ

for ii = 1 : length(bit_stream)
    if bit_stream(ii)==0
        Digital_signal = [Digital_signal zero];
    end
     
    if bit_stream(ii)==1
        Digital_signal = [Digital_signal high];
    end
    
    if(ii==1)
        prev_diff_bit = 1;
        %diff_bit_stream = [diff_bit_stream 1];
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
diff_bit_stream
carrier_signal = sin(2*pi*fc*time);
DPSK_signal = carrier_signal.*diff_signal;


carrier_signal = A*carrier_signal;
DPSK_signal = A*DPSK_signal;
 

Eb = 0.5*A^2;
N0 = Eb/10^2;%SNR=20dB
sigma = sqrt(N0/2);
noise_signal = normrnd(0,sigma,[1,length(time)]);
DPSK_recv_signal = DPSK_signal+noise_signal;

figure(1);
subplot(5,1,1);
plot(time,Digital_signal);
xlabel('ʱ��');
ylabel('����');
title('������');
axis([0 time(end) -0.1 1.2*A]);
grid on;

subplot(5,1,2);
plot(time,diff_signal);
xlabel('ʱ��');
ylabel('����');
title('�����(�����˵�ƽת��)');
axis([0 time(end) -1.2*A 1.2*A]);
grid on;

subplot(5,1,3);
plot(time,carrier_signal);
xlabel('ʱ��');
ylabel('����');
title('�ز�');
axis([0 time(end) -1.2*A 1.2*A]);
grid  on;  
 
subplot(5,1,4);
plot(time, DPSK_signal);
xlabel('ʱ��');
ylabel('����');
title('DPSK �����ź�');
axis([0 time(end) -1.2*A 1.2*A]);
grid  on;

subplot(5,1,5);
plot(time, DPSK_recv_signal);
xlabel('ʱ��');
ylabel('����');
title('DPSK �����ź�');
axis([0 time(end) -1.2*A 1.2*A]);
grid  on;

BPF_order = 20;
b_BPF = fir1(BPF_order,[(fc-Rb-500)/(fs/2),(fc+Rb+500)/(fs/2)]);
DPSK_recv_signal_BPF = filter(b_BPF,1,DPSK_recv_signal);
carrier_signal_BPF = filter(b_BPF,1,carrier_signal);
%DPSK_recv_signal_BPF = DPSK_recv_signal;
recv_m_t = DPSK_recv_signal_BPF .* (2*carrier_signal_BPF);
LPF_order = 50;
b_LPF = fir1(LPF_order,Rb/(fs/2));
recv_m_t_LPF = filter(b_LPF,1,recv_m_t);

ii=LPF_order;
recv_diff_bit_stream = [];
V_TH = 0;
recv_diff_signal = [];
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
recv_bit_stream = [];

for ii = 1 : length(recv_diff_bit_stream)
    if(ii==1)
        recv_prev_diff_bit = 1;
    else 
        recv_prev_diff_bit = recv_diff_bit_stream(ii-1);
    end
    recv_bit_stream = [recv_bit_stream xor(recv_prev_diff_bit,recv_diff_bit_stream(ii))];
end
recv_bit_stream

recv_digital_signal = [];
for ii = 1 : length(recv_bit_stream)
    if recv_bit_stream(ii)==0
        recv_digital_signal = [recv_digital_signal zero];
    end
     
    if recv_bit_stream(ii)==1
        recv_digital_signal = [recv_digital_signal high];
    end
end
figure(2);
subplot(5,1,1);
plot(time, DPSK_recv_signal_BPF);
xlabel('ʱ��');
ylabel('����');
title('DPSK �����ź� ͨ��BPF');
axis([0 time(end) -1.2*A 1.2*A]);
grid  on;
subplot(5,1,2);
plot(time, recv_m_t);
xlabel('ʱ��');
ylabel('����');
title('DPSK �����ź� ͨ��BPF �����ز�');
axis([0 time(end) -1.2*A 1.2*A]);
grid  on;
subplot(5,1,3);
plot(time, recv_m_t_LPF);
xlabel('ʱ��');
ylabel('����');
title('DPSK �����ź� ͨ��BPF �����ز� a');
axis([0 time(end) -1.2*A 1.2*A]);
grid  on;

subplot(5,1,4);
plot(time, recv_diff_signal);
xlabel('ʱ��');
ylabel('����');
title('���յ��������');
axis([0 time(end) -1.2*A 1.2*A]);
grid  on;

subplot(5,1,5);
plot(time, recv_digital_signal);
xlabel('ʱ��');
ylabel('����');
title('���յ��ľ�����,�����˵�ƽת��');
axis([0 time(end) -0.1 1.2*A]);
grid  on;
