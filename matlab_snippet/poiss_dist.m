clc;
name='���ɷֲ�';
N=20;
lamda=5;
Xi=poissrnd(lamda,1,1000);
mXi=mean(Xi)
varXi=var(Xi)
subplot(4,1,1);hist(Xi),title(strcat(name,'ֱ��ͼ'));
X=0:N;
Y_pdf=poisspdf(X,lamda);
subplot(4,1,2);plot(X,Y_pdf),title(strcat(name,'�����ܶȺ���'));
Y_cdf=poisscdf(X,lamda);
subplot(4,1,3);plot(X,Y_cdf),title(strcat(name,'���ʷֲ�����'));
[m,v]=poisstat(lamda)
[Rx,lags]=xcorr(Xi);
subplot(4,1,4);plot(lags/1,Rx),title(strcat(name,'�ź�����غ���'));