clear;clc;
n=0:19;
delta1=[1 zeros(1,19)];
a1=[1 -3/5];
b1=[1];
h1=filter(b1,a1,delta1);
subplot(2,1,1);stem(n,h1,'fill');title('h_1[n]');
%%
h2=[1];
for i=1:19;
    h2=[h2 (3/5)^(i+1)*h2(i)+delta1(i+1)];
end
subplot(2,1,2);stem(n,h2,'fill');title('h_2[n]');