sigma=5;
mu=0;
Xi=normrnd(mu,sigma,1,1000);
mXi=mean(Xi)
varXi=var(Xi)
subplot(4,1,1);hist(Xi),title('正态分布直方图');
X=-20:0.1:40;
Y_pdf=normpdf(X,mu,sigma);
subplot(4,1,2);plot(X,Y_pdf),title('正态分布概率密度函数');
Y_cdf=normcdf(X,mu,sigma);
subplot(4,1,3);plot(X,Y_cdf),title('正态分布概率分布函数');
[m,v]=normstat(mu,sigma)
[Rx,lags]=xcorr(Xi,'');
subplot(4,1,4);plot(lags/1,Rx/1000),title('正态随机信号自相关函数');