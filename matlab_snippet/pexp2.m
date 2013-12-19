clear all;
clc
VH=[0 1.0 1.7 2.5 3.3 4.1 4.9 5.8 6.4 7.2 8.0 8.8];
IH=5;
K=245;
B=VH./K./IH.*1000;
vpa(B,2)
Be=