function [n,conv_result]=conv_zly(nx,x,ny,y)
%�����±��conv,n��conv_result���±�
%x�洢��x[n]��ֵ(1*n����)��nx�洢�ź�x[n]��������ţ�
%y,nyͬ����
%Author: ��·�� ���ӿƼ���ѧ 2011/11/19
%Licenses:GNU GPL:http://www.gnu.org/licenses/gpl.html
nx_start=nx(1);
nx_end=nx(end);
ny_start=ny(1);
ny_end=ny(end);
conv_result=conv(x,y);
n=(nx_start+ny_start):1:(nx_end+ny_end);%nx_start+nx_start+
return;
end