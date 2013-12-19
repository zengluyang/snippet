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
%-------------------------------������Ϣ����--------------------------------

N = 25;
bit_stream = round(rand(1,N))					%�������bit��
% h_ = dec2binvec(104,8);
% e_ = dec2binvec(101,8);
% l_ = dec2binvec(108,8);
% l_ = dec2binvec(108,8);
% o_ = dec2binvec(111,8);
% bit_stream = [h_ e_ l_ l_ o_]; 				%�Զ�����Ϣ���� 
														%'hello'��ascii�� 
%--------------------------------------------------------------------------

%-----------------------------------��������--------------------------------

p1 = 0; 											%��ʼ��λ

fc = 1800;											%�ز�Ƶ��
Rb = 1200;
ts = 1/Rb;											%���ּ��
fs = 50*Rb;										%����Ƶ��
A = 1;												%�����źŷ���
%--------------------------------------------------------------------------

t = 0: 1/fs : ts;									%������Ԫʱ��

%=================================���Ͷ�===================================
%==========================================================================
time = [];
diff_bit_stream = [];								%�����
DPSK_signal = [];									%DPSK�����ź�
digital_signal = [];								%������NRZ�����źţ������룩
diff_signal = [];									%˫����NRZ�����źţ�����룩
carrier_signal=[];								%�ز��ź�

low = -1*ones(1,length(t)); 						%�͵�ƽ
zero = zeros(1,length(t)); 						%���ƽ
high = ones(1,length(t));						%�ߵ�ƽ

%---------------------���������� ������˫����NRZ�����ź�---------------------
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
carrier_signal = sin(2*pi*fc*time);				%�����ز��ź�
DPSK_signal = carrier_signal.*diff_signal;		%���������ź�


carrier_signal = A*carrier_signal;				%���Ʒ��ȴ���
DPSK_signal = A*DPSK_signal;						%���Ʒ��ȴ���
 
%-------------------------------���������ź�--------------------------------
Eb = 0.5*A^2;
N0 = Eb/10^2;%SNR=20dB
sigma = sqrt(N0/2);
noise_signal = normrnd(0,sigma,[1,length(time)]);
%--------------------------------------------------------------------------

DPSK_recv_signal = DPSK_signal+noise_signal;	%�ź�ͨ��AWGN�ŵ�

%-------------------------------���Ʒ��Ͷ˲���------------------------------

figure(1);											%���ƾ����뵥����NRZ�����ź�
subplot(5,1,1);
plot(time,digital_signal);
xlabel('ʱ��');
ylabel('����');
title('������');
axis([0 time(end) -0.1 1.2*A]);
grid on;

subplot(5,1,2);									%������Զ���˫����NRZ�����ź�
plot(time,diff_signal);
xlabel('ʱ��');
ylabel('����');
title('�����(�����˵�ƽת��)');
axis([0 time(end) -1.2*A 1.2*A]);
grid on;

subplot(5,1,3);									%�����ز��ź�
plot(time,carrier_signal);
xlabel('ʱ��');
ylabel('����');
title('�ز�');
axis([0 time(end) -1.2*A 1.2*A]);
grid  on;  
 
subplot(5,1,4);									%����DPSK �����ź��ź�
plot(time, DPSK_signal);
xlabel('ʱ��');
ylabel('����');
title('DPSK �����ź�');
axis([0 time(end) -1.2*A 1.2*A]);
grid  on;

subplot(5,1,5);									%����DPSK �����źţ�ͨ��AWGN�ŵ���
plot(time, DPSK_recv_signal);
xlabel('ʱ��');
ylabel('����');
title('DPSK �����źţ�ͨ��AWGN�ŵ���');
axis([0 time(end) -1.2*A 1.2*A]);
grid  on;
%--------------------------------------------------------------------------
%==========================================================================
%==========================================================================

%=================================���ն�===================================
%==========================================================================

%---------------------------------ͨ����ͨ�˲���----------------------------
BPF_order = 20;									%��ͨ�˲�������
b_BPF = fir1(BPF_order,[(fc-Rb-500)/(fs/2),(fc+Rb+500)/(fs/2)]);
DPSK_recv_signal_BPF = filter(b_BPF,1,DPSK_recv_signal);
carrier_signal_BPF = filter(b_BPF,1,carrier_signal);
%DPSK_recv_signal_BPF = DPSK_recv_signal;
recv_m_t = DPSK_recv_signal_BPF .* (2*carrier_signal_BPF);
%--------------------------------------------------------------------------

%---------------------------------ͨ����ͨ�˲���----------------------------
LPF_order = 50;									%��ͨ�˲�������
b_LPF = fir1(LPF_order,Rb/(fs/2));
recv_m_t_LPF = filter(b_LPF,1,recv_m_t);
%--------------------------------------------------------------------------
ii=LPF_order;										%�˲���ʱ��
recv_diff_bit_stream = [];						%������ʱ�����о��õ��������
V_TH = 0;											%�о�����
recv_diff_signal = [];
%--------------------------------��ʱ�����о�--------------------------------
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
recv_bit_stream = [];								%����ģ2�ӣ���򣩵õ��ľ�����

%----------------------------------ģ2�ӣ����----------------------------
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

%-------------------------------���ƽ��ն��Ͷ˲���--------------------------
figure(2);
subplot(5,1,1);									%����DPSK �����ź� ͨ��BPF
plot(time, DPSK_recv_signal_BPF);
xlabel('ʱ��');
ylabel('����');
title('DPSK �����ź� ͨ��BPF');
axis([0 time(end) -1.2*A 1.2*A]);
grid  on;
subplot(5,1,2);									%����DPSK �����ź� ͨ��BPF �����ز�
%����ɽ����
plot(time, recv_m_t);
xlabel('ʱ��');
ylabel('����');
title('DPSK �����ź� ͨ��BPF �����ز�');
axis([0 time(end) -1.2*A 1.2*A]);
grid  on;

subplot(5,1,3);									%������ͨ��LPF�Ĳ���
plot(time, recv_m_t_LPF);
xlabel('ʱ��');
ylabel('����');
title('ͨ��LPF');
axis([0 time(end) -1.2*A 1.2*A]);
grid  on;

subplot(5,1,4);									%���ƽ�����ľ�����˫����NRZ�����ź�
plot(time, recv_diff_signal);
xlabel('ʱ��');
ylabel('����');
title('���յ��˽�����������');
axis([0 time(end) -1.2*A 1.2*A]);
grid  on;

subplot(5,1,5);									%���ƽ�����ľ����뵥����NRZ�����ź�
plot(time, recv_digital_signal);
xlabel('ʱ��');
ylabel('����');
title('���յ��˽�����ľ����루�����˵�ƽת����');
axis([0 time(end) -0.1*A 1.2*A]);
grid  on; 
%--------------------------------------------------------------------------

%----------------------------���ƹ�����-------------------------------------
N_FFT = 2^16;
figure(3);
subplot(5,1,1)
[p,w]=periodogram(digital_signal,[],N_FFT,fs,'onesided');
w=w(1:fix(length(w)/10));
p=p(1:fix(length(p)/10));
[p_max,i_max]=max(p);
plot(w,p,w(i_max),(p_max),'r*');
xlabel('Ƶ�� Hz');
ylabel('����/Ƶ�� W/Hz');
title('���ƾ����뵥����NRZ�����ź� PSD');
axis tight;

subplot(5,1,2)
[p,w]=periodogram(diff_signal,[],N_FFT,fs,'onesided');
w=w(1:fix(length(w)/10));
p=p(1:fix(length(p)/10));
[p_max,i_max]=max(p);
plot(w,p,w(i_max),(p_max),'r*');
xlabel('Ƶ�� Hz');
ylabel('����/Ƶ�� W/Hz');
title('���������˫����NRZ�����ź� PSD');
axis tight;

subplot(5,1,3);
[p,w]=periodogram(carrier_signal,[],N_FFT,fs,'onesided');
w=w(1:fix(length(w)/10));
p=p(1:fix(length(p)/10));
[p_max,i_max]=max(p);
plot(w,p,w(i_max),(p_max),'r*');
xlabel('Ƶ�� Hz');
ylabel('����/Ƶ�� W/Hz');
title('�ز��ź�PSD');
axis tight;

subplot(5,1,4)
[p,w]=periodogram(DPSK_signal,[],N_FFT,fs,'onesided');
w=w(1:fix(length(w)/10));
p=p(1:fix(length(p)/10));
[p_max,i_max]=max(p);
plot(w,p,w(i_max),(p_max),'r*');
xlabel('Ƶ�� Hz');
ylabel('����/Ƶ�� W/Hz');
title('DPSK �����ź� PSD');
axis tight;

subplot(5,1,5)
[p,w]=periodogram(DPSK_recv_signal,[],N_FFT,fs,'onesided');
w=w(1:fix(length(w)/10));
p=p(1:fix(length(p)/10));
[p_max,i_max]=max(p);
plot(w,p,w(i_max),(p_max),'r*');
xlabel('Ƶ�� Hz');
ylabel('����/Ƶ�� W/Hz');
title('DPSK �����źţ�ͨ��AWGN�ŵ���PSD');
axis tight;

figure(4);
subplot(5,1,1)
[p,w]=periodogram(DPSK_recv_signal_BPF,[],N_FFT,fs,'onesided');
w=w(1:fix(length(w)/10));
p=p(1:fix(length(p)/10));
[p_max,i_max]=max(p);
plot(w,p,w(i_max),(p_max),'r*');
xlabel('Ƶ�� Hz');
ylabel('����/Ƶ�� W/Hz');
title('DPSK �����ź� ͨ��BPF PSD');
axis tight;
subplot(5,1,2)
[p,w]=periodogram(recv_m_t,[],N_FFT,fs,'onesided');
w=w(1:fix(length(w)/10));
p=p(1:fix(length(p)/10));
[p_max,i_max]=max(p);
plot(w,p,w(i_max),(p_max),'r*');
xlabel('Ƶ�� Hz');
ylabel('����/Ƶ�� W/Hz');
title('DPSK �����ź� ͨ��BPF �����ز� PSD');
axis tight;

subplot(5,1,3)
[p,w]=periodogram(recv_m_t_LPF,[],N_FFT,fs,'onesided');
w=w(1:fix(length(w)/10));
p=p(1:fix(length(p)/10));
[p_max,i_max]=max(p);
plot(w,p,w(i_max),(p_max),'r*');
xlabel('Ƶ�� Hz');
ylabel('����/Ƶ�� W/Hz');
title('��ͨ��LPF PSD');
axis tight;

subplot(5,1,4)
[p,w]=periodogram(recv_diff_signal,[],N_FFT,fs,'onesided');
w=w(1:fix(length(w)/10));
p=p(1:fix(length(p)/10));
[p_max,i_max]=max(p);
plot(w,p,w(i_max),(p_max),'r*');
xlabel('Ƶ�� Hz');
ylabel('����/Ƶ�� W/Hz');
title('������������˫����NRZ�����ź� PSD');
axis tight;

subplot(5,1,5)
[p,w]=periodogram(recv_digital_signal,[],N_FFT,fs,'onesided');
w=w(1:fix(length(w)/10));
p=p(1:fix(length(p)/10));
[p_max,i_max]=max(p);
plot(w,p,w(i_max),(p_max),'r*');
xlabel('Ƶ�� Hz');
ylabel('����/Ƶ�� W/Hz');
title('������ľ����뵥����NRZ�����ź� PSD');
axis tight;

%--------------------------------------------------------------------------

%==========================================================================
%==========================================================================
