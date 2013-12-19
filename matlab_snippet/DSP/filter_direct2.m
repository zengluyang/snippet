function y=filter_direct2(p,d,x)
%IIR direct II realization
M = length(x);
d_len = length(d);
p_len = length(p);
N = max(d_len, p_len);
sf = zeros(1,N-1);
y = zeros(1,M);
if length(d_len) < length(p_len)
    d = [d zeros(1,p_len - d_len)];
else
    p = [p zeros(1,d_len - p_len)];
end
p=p/d(1);
d=d/d(1);
for n = 1:M
    wnew = [1 -d(2:N)] * [x(n) sf]';
    k = [wnew sf];
    y(n) = k*p';
    sf = [wnew sf(1:N-2)];
end