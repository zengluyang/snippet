M=2000;
Ts=0.001;
t=0:Ts:(M-1)*Ts;
f1=40;
f2=100;
fai1=unifrnd(1,2*pi,1,M);
fai2=unifrnd(1,2*pi,1,M);
mu=0;
sigma=1;
N_t=normrnd(mu,sigma,1,M);
S_t=cos(2*pi*f1.*t+fai1)+4*cos(2*pi*f2.*t+fai2);
X_n=S_t+N_t;

Rxx=xcorr(X_n)/M;
Sw=abs(fft(Rxx));
m=[-M+1:M-1];
subplot(3,1,1),plot(t,X_n),title('样本波形');
subplot(3,1,2),plot(m,Rxx),title('自相关函数');
subplot(3,1,3);periodogram(X_n,[],M,1/Ts),title('样本的功率谱');
