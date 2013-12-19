clear;clc; format shortE;
g_local=9.79;
L=0.641;D=1.176;b=73.9/1000;
n_inc=[79.0 75.6 71.9 69.5 66.0 63.8 61.3 58.6]/1000;
n_dec=[79.1 75.3 71.9 69.3 65.7 63.3 61.4 58.6]/1000;
d=[0.825 0.824 0.823 0.819 0.826 0.817 0.814 0.820 0.816]/1000;
n=0.5.*(n_inc+n_dec);
n_delta=[];
for i = 1:4
    n_delta = [n_delta,(n(i+4)-n(i))]; %#ok<AGROW>
end
n_avg = -sum(n_delta)/length(n_delta) %#ok<NOPTS> 
F=4*g_local %#ok<NOPTS> 
d_avg = sum(d)/length(d) %#ok<NOPTS>

Y_avg = 8*L*D*F/(pi*d_avg.^2*b*n_avg) %#ok<NOPTS>
% format shortG;
L_delta = 2/1000/3^0.5
D_delta = 5/1000/3^0.5
b_delta = 0.1/1000/3^0.5
S_d = getUncertaintyFromArray(d) %#ok<NOPTS>
u_d = 0.005/1000/sqrt(3)
delta_d = sqrt(S_d^2 + u_d^2)
S_n_delta_avg = getUncertaintyFromArray(n_delta)
u_n_delta_avg = 0.5/1000/sqrt(3)
delta_n_delta_avg = sqrt(S_n_delta_avg^2 + u_n_delta_avg^2)
format longE;
delta_Y = Y_avg*sqrt((L_delta/L)^2 + (D_delta/D)^2 + (2*delta_d/d_avg)^2 + (b_delta/b)^2 + (delta_n_delta_avg/n_avg)^2 )
                        
                        
                        
                        

                   