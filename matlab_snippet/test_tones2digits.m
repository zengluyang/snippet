%clear;
%load touch;
t=0:999;
    d0=sin(0.7217.*t)+sin(1.0247.*t);
    d1=sin(0.5346.*t)+sin(0.9273.*t);
    d2=sin(0.5346.*t)+sin(1.0247.*t);
    d3=sin(0.5346.*t)+sin(1.1328.*t);
    d4=sin(0.5906.*t)+sin(0.9273.*t);
    d5=sin(0.5906.*t)+sin(1.0247.*t);
    d6=sin(0.5906.*t)+sin(1.1328.*t);
    d7=sin(0.6535.*t)+sin(0.9273.*t);
    d8=sin(0.6535.*t)+sin(1.0247.*t);
    d9=sin(0.6535.*t)+sin(1.1328.*t);
sl=1200;
blank=ones(1,sl);
phone=[d1 blank d8 blank d6 blank d1 blank d5 blank d7 blank d9 blank d4 blank d9 blank d3 blank d1];
p1=phone(2201:3200);
length(p1)
length(d1)
sound(phone,8192);
%digits=tones2digits(phone,11,8196,1000,1000)
wavwrite(phone,8192,32,'phone_number');
[y, Fs, nbits, readinfo] = wavread('phone_number');
%sound(y,8192,16);
digits=tones2digits(y',11,8196,1000,sl)
