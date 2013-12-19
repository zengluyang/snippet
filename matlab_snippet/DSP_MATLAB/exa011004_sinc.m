%-----------------------------------------------------------------
% exa011004_sinc.m, for example 1.10.4
%                   to generate the sinc function.
% 产生一 sinc 函数；
%-----------------------------------------------------------------
clear;

n=100;
stept=4*pi/n;
t=-2*pi:stept:2*pi;
y=sinc(t);
subplot(211);
plot(t,y,t,zeros(size(t)));
ylabel('sinc(t)');
xlabel('t=-2*pi~2*pi');
grid on;
subplot(212);
stem(t,y);

   