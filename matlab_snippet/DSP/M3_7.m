%M3.7
%ÔøÂ·Ñó
%2010013060009
%compute group delaying using expr in problem 3.8
N=1024;%DFT length must >= the length of h_n
h_n=[1 2 3 3 2 1];%h[n] sequnce FIR no groupdelay
n=0:1:(length(h_n)-1);
omega_k = 0:2*pi/N:(2*pi-2*pi/N);
H_omega = fft(h_n,N);%the DFT of h[n]: H[\omega]
nH_omega= fft(n.*h_n,N);%the DFT of n*h[n]: nH[\omega]
groupdelay = real(nH_omega./nH_omega);
plot(omega_k,groupdelay);
