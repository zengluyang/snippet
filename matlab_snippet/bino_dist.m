clc;
name='����ֲ�';
N=100;
p=0.2
Xi=binornd(N,p,1,1000);
mXi=mean(Xi)
varXi=var(Xi)
subplot(4,1,1);hist(Xi),title(strcat(name,'ֱ��ͼ'));
X=0:N;
Y_pdf=binopdf(X,N,p);
subplot(4,1,2);plot(X,Y_pdf),title(strcat(name,'�����ܶȺ���'));
Y_cdf=binocdf(X,N,p);
subplot(4,1,3);plot(X,Y_cdf),title(strcat(name,'���ʷֲ�����'));
[m,v]=binostat(N,p)
[Rx,lags]=xcorr(Xi,'none');
subplot(4,1,4);plot(lags/1,Rx),title(strcat(name,'�ź�����غ���'));