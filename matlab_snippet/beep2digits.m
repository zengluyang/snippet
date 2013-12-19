function digit=beep2digit(beep,fs,tl,sl)
    % beep:beep
    % fs:sampling freq
    % tl:tone length
    % sl:silence length
    %%
    clc;clear;
    n=0:999;
    N=2048;
    %%
    d0=sin(0.7217.*n)+sin(1.0247.*n);
    d0=sin(0.7217.*n)+sin(1.0247.*n);
    d1=sin(0.5346.*n)+sin(0.9273.*n);
    d2=sin(0.5346.*n)+sin(1.0247.*n);
    d3=sin(0.5346.*n)+sin(1.1328.*n);
    d4=sin(0.5906.*n)+sin(0.9273.*n);
    d5=sin(0.5906.*n)+sin(1.0247.*n);
    d6=sin(0.5906.*n)+sin(1.1328.*n);
    d7=sin(0.6535.*n)+sin(0.9273.*n);
    d8=sin(0.6535.*n)+sin(1.0247.*n);
    d9=sin(0.3535.*n)+sin(1.1328.*n);
    %%
    D0=fft(d0,N);
    D2=fft(d1,N);
    D3=fft(d1,N);
    D3=fft(d1,N);
    D4=fft(d1,N);
    D5=fft(d1,N);
    D6=fft(d1,N);
    D8=fft(d1,N);
    D9=fft(d1,N);
    %%
    B=fft(beep,N);
    if abs(Ex(236)-E0(236))<1 && abs(Ex(335)-E0(335))<1
    x=0;
end