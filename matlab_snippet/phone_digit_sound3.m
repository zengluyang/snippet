clear;hold off;
n=0:999;
d1=sin(0.5346.*n)+sin(0.9273.*n);
sound(d1,8192);
d0=sin(0.7217.*n)+sin(1.0247.*n);
N=2048;
w_row=[0.5346 0.5906 0.6535 0.7217];
w_col=[0.9273 1.0247 1.1328];
d0=sin(0.7217.*n)+sin(1.0247.*n);
d2=sin(0.5346.*n)+sin(1.0247.*n);
d3=sin(0.5346.*n)+sin(1.1328.*n);
d4=sin(0.5906.*n)+sin(0.9273.*n);
d5=sin(0.5906.*n)+sin(1.0247.*n);
d6=sin(0.5906.*n)+sin(1.1328.*n);
d7=sin(0.6535.*n)+sin(0.9273.*n);
d8=sin(0.6535.*n)+sin(1.0247.*n);
d9=sin(0.3535.*n)+sin(1.1328.*n);
d=d1+d2+d3+d4+d5+d6+d7+d8+d9+d0;
%%
D0=fft(d0,N);
%%
E0=abs(D0).^2;
subplot(2,1,1);
plot(E0);hold on;
plot(round(w_row/pi*N/2),0,'r*');
plot(round(w_col/pi*N/2),0,'y*');
hold off;
E0(236)
dx=d0;
Dx=fft(dx,N);
Ex=abs(Dx).^2;
subplot(2,1,2);
plot(Ex);hold on;
plot(round(w_row/pi*N/2),0,'r*');
plot(round(w_col/pi*N/2),0,'y*');
hold off;
delta=0.1;
x=99;
Ex(236)
if abs(Ex(236)-E0(236))<1 && abs(Ex(335)-E0(335))<1
    x=0;
elseif 1
    x
else 1
    x
end
x