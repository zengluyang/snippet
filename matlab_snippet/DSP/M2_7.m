alpha = 2; 
n = 30;
Y = [1];
X = alpha.*[0 ones(1,n-1)];
for k = -1 : (n-3)
    y_new = 0.5.*(Y(k+2)+X(k+3)/Y(k+2));
    Y = [Y y_new];
end
stem(-1:(n-2),Y);
err = Y(end) - sqrt(alpha)%这种方法计算的误差