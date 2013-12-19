clear;
th_f = inline('3.64*(f/1000).^-0.8-6.5*exp(-0.6*(f/1000-3.3).^2) + 10^-3*(f/1000).^4');
f = 0:1:15000;
th = th_f(f);
diff_th_f = diff(th);
[~,ind]=min(abs(diff_th_f));
f_min_th=f(ind)