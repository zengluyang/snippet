%2.5 e f g
clear;clc;
n=0:19;
delta1=[1 zeros(1,19)];
u=[ones(1,20)];
a1=[1 -3/5];
b1=[1];
%%
h1=filter(b1,a1,delta1);
h2=[1];
for i=1:19;
    h2=[h2 (3/5)^(i+1)*h2(i)+delta1(i+1)];
end
%%
figure(1);
s1=filter(b1,a1,u);
stem(n,s1,'fill');title('s_1[n] and z_1[n]');hold on;
[nz1,z1]=conv_zly(n,h1,n,u);
nz1=nz1(1:20);
z1=z1(1:20);
stem(nz1,z1,'y--');hold off;
%%
figure(2);
s2=[1];
for i=1:19;
    s2=[s2 (3/5)^(i+1)*s2(i)+u(i+1)];
end
stem(n,s2,'fill');title('s_2[n]');