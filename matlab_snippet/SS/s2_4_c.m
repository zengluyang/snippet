clear;
clc;
nx1=0:4;
x1=ones(1,5);
nh1=0:4;
h1=[1 -1 3 0 1];
nh2=1:4;
h2=[2 5 4 -1];
[ny1,y1]=conv_zly(nx1,x1,nh1,h1);
[ny2,y2]=conv_zly(nx1,x1,nh2,h2);
[ny,y]=sig_add(ny1,y1,ny2,y2);
subplot(2,1,1);stem(ny,y,'fill');
title('x_1[n]*h_1[n]+x_1[n]*h_2[n]');
[nh,h]=sig_add(nh1,h1,nh2,h2);
[ny,y]=conv_zly(nx1,x1,nh,h);
subplot(2,1,2);stem(ny,y,'fill');
title('x_1[n]*(h_1[n]+h_2[n])');

