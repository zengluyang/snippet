function [nx,x] = sig_add(nx1,x1,nx2,x2)
%两个离散信号相加
%x1存储号x1[n]的值(1*n矩阵)，nx1存储信号x1[n]样本的序号；
%x2,nx2同理。
%Author: 曾路洋 电子科技大学 2011/11/28
%Licenses:GNU GPL:http://www.gnu.org/licenses/gpl.html
if length(x1)~=length(nx1) || length(x2)~=length(nx2)
    error('length of x1 and nx1 and length of x2 and nx2 must be the same');
end
if nx1(1)<nx2(1)
    nx_start=nx1(1);
    x2=[zeros(1,nx2(1)-nx1(1)) x2];
else
    nx_start=nx2(1);
    x1=[zeros(1,nx1(1)-nx2(1)) x1];
end
if nx1(end)>nx2(end)
    nx_end=nx1(end);
    x2=[x2 zeros(1,nx1(end)-nx2(end))];
else
    nx_end=nx2(end);
    x1=[x1 zeros(1,nx2(end)-nx1(end))];
end
nx=nx_start:nx_end;
x=x1+x2;
return;