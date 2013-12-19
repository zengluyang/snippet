%-----------------------------------------------------------------
% exa020805_residues.m, for example 2.8.5
% to test residuez.m and to obtain the residues of H(z).
%-----------------------------------------------------------------
clear;

b=[1.7,-1.69,.39];
a=[1 -1.7,0.8,-.1]; 
% ϵͳ H(z)=B(z)/A(z)
[r,p,k]=residuez(b,a)
% ��ϵ������ b,a ��  r,p �� k������H(z) �ֽ��������ʽ��
%H(z)=1/[1-z^-1]+0.2/[1-0.5z^-1]+0.5/[1-0.2z^-1]

[b1,a1]=residuez(r,p,k)
% �� r,p �� k ��������ϵ������ b �� a;

% �� H2(z)=A(z)/B(z),������ b2=a,a2=b,��һ���� r,p �� k�� 
% H2(z)��Ϊ H(z)����ϵͳ
b2=a;a2=b;
[r,p,k]=residuez(b2,a2)