Wp = 40/500; Ws = 150/500;
Rp = 3; Rs = 60;
[n,Ws] = cheb2ord(Wp,Ws,Rp,Rs,'s')
% Returns n =4 Ws =0.3000
[b,a] = cheby2(n,Rs,Ws);
figure(1);freqz(b,a,512,1000); 
title('n=4 Chebyshev Type II Lowpass Filter')
[num,den] = bilinear(b,a,8000);
figure(2);freqz(b,a,512,1000);