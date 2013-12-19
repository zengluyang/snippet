[x,fs]=wavread('phone_number.wav');
figure(1);
subplot(3,1,1);
plot(x);
title('原始信号');
y=fft(x);
subplot(3,1,2);
plot(abs(y));
title('幅值');
subplot(3,1,3);
plot(angle(y));
title('相位');
Sound(x,fs);
[x,fs]=wavread('phone_number.wav');
x1=x;
x2=x;
x3=x;
x4=x;
x1=[x1',zeros(1,18000)];
x2=[zeros(1,6000),0.7*x2',zeros(1,12000)];
x3=[zeros(1,12000),0.4*x3',zeros(1,6000)];
x4=[zeros(1,18000),0.1*x4'];
y=x1+x2+x3+x4;
figure(2);
subplot(3,1,1);
plot(y);
title('回声');
y1=fft(y);
subplot(3,1,2);
plot(abs(y1));
title('幅值');
subplot(3,1,3);
plot(angle(y1));
title('相位');
Sound(y,fs);
b=1;
a=zeros(1,18000);
a(1)=1;
a(6001)=0.7;
a(12001)=0.4;
a(18001)=0.1;
z1=filter(b,a,y);
z2=fft(z1,1024);
figure(3);
subplot(3,1,1);
plot(abs(z2));
title('滤波幅值 ');
subplot(3,1,2);
plot(angle(z2));
title('滤波相位');
subplot(3,1,3);
plot(z1);
title('滤波信号');
