%用matlab产生1/4周期内等距离的16384个点的sin值并复制
N=16384;
n=0:0.5*pi/(N-1):0.5*pi;
sin_n = sin(n);
sin_n_r=round(sin_n*(2^15-1));
plot(sin_n_r);
sqr_n = [];