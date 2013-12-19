%2.5 linearity and time-invariance 
%2.5a
clear;clc;
x1=[1 zeros(1,5)];
x2=[0 1 zeros(1,4)];
x3=[1 2 zeros(1,4)];
wa=[1];
wb=[1 -1 -2];
n=[0:5];
%%
w1=filter(wb,wa,x1);
w2=filter(wb,wa,x2);
w3=filter(wb,wa,x3);
figure(1);
subplot(4,1,1);stem(n,w1,'fill');title('w_1[n]');
subplot(4,1,2);stem(n,w2,'fill');title('w_2[n]');
subplot(4,1,3);stem(n,w3,'fill');title('w_3[n]');
subplot(4,1,4);stem(n,w1+2.*w2,'fill');title('w_1[n]+2\times w_2[n]');
%%
y1=cos(x1);
y2=cos(x2);
y3=cos(x3);
figure(2)
subplot(4,1,1);stem(n,y1,'fill');title('y_1[n]');
subplot(4,1,2);stem(n,y2,'fill');title('y_2[n]');
subplot(4,1,3);stem(n,y3,'fill');title('y_3[n]');
subplot(4,1,4);stem(n,y1+2.*y2,'fill');title('y_1[n]+2\times y_2[n]');
%%
z1=n.*x1;
z2=n.*x2;
z3=n.*x3;
figure(3);
subplot(4,1,1);stem(n,z1,'fill');title('z_1[n]');
subplot(4,1,2);stem(n,z2,'fill');title('z_2[n]');
subplot(4,1,3);stem(n,z3,'fill');title('z_3[n]');
subplot(4,1,4);stem(n,z1+2.*z2,'fill');title('z_1[n]+2\times z_2[n]');
