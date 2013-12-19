format compact;
clc;
clear;
beta=250;rbb=100;Vcc=12;VBEQ=0.7;
R1=15000
%10k zong hong hei hei zong 
R2=12000 
%2k zong zong hei zong hong
Rc=2000 
%1k
Re=3000
%3k
Rl=100000
%90k zong hong  hei hei zong 
VB=12*R2/(R1+R2)
VBE=VBEQ
IE=(VB-VBEQ)/Re
IC=beta/(1+beta)*IE
VCE=Vcc-(Rc+Re)*IC
rbe=rbb+(1+beta)*(26e-3)/IE;
Av=-beta*PL(Rc,Rl)/rbe
Ri=PL(PL(R1,R2),rbe)
Ro=Rc
