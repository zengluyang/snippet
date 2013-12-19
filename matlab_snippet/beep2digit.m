function digit=tone2digit(tone,fs,tl)
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
    E0=abs(fft(d0,N)).^2;
    E1=abs(fft(d1,N)).^2;
    E2=abs(fft(d2,N)).^2;
    E3=abs(fft(d3,N)).^2;
    E4=abs(fft(d4,N)).^2;
    E5=abs(fft(d5,N)).^2;
    E6=abs(fft(d6,N)).^2;
    E7=abs(fft(d7,N)).^2;
    E8=abs(fft(d8,N)).^2;
    E9=abs(fft(d9,N)).^2;
    %%
    Eb=abs(fft(beep,N)).^2;
    if      abs(Eb(236)-E0(236))<1 && abs(Eb(335)-E0(335))<1
        digit=0;
    elseif  abs(Eb(175)-E0(175))<1 && abs(Eb(303)-E0(303))<1
        digit=1;
    elseif  abs(Eb(175)-E0(175))<1 && abs(Eb(335)-E0(335))<1
        digit=2;
    elseif  abs(Eb(175)-E0(175))<1 && abs(Eb(370)-E0(370))<1
        digit=3;
    elseif  abs(Eb(194)-E0(194))<1 && abs(Eb(303)-E0(303))<1
        digit=4;
    elseif  abs(Eb(194)-E0(194))<1 && abs(Eb(335)-E0(335))<1
        digit=5;
    elseif  abs(Eb(194)-E0(194))<1 && abs(Eb(335)-E0(335))<1
        digit=6;
    elseif  abs(Eb(214)-E0(214))<1 && abs(Eb(370)-E0(370))<1
        digit=7;
    elseif  abs(Eb(214)-E0(214))<1 && abs(Eb(335)-E0(335))<1
        digit=8;
    elseif	abs(Eb(116)-E0(116))<1 && abs(Eb(370)-E0(370))<1
        digit=9;
    end
end