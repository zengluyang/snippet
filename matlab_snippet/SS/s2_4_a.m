nx1=0:4;
x1=ones(1,5);
nh1=0:4;
h1=[1 -1 3 0 1];
nh2=1:4;
h2=[2 5 4 -1];
subplot(3,1,1),stem(nx1,x1,'fill');
subplot(3,1,2),stem(nh1,h1,'fill');
subplot(3,1,3),stem(nh2,h2,'fill');