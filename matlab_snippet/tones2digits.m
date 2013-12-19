function digits=tones2digits(tones,n,fs,tl,sl)
    step=tl+sl;
    digits=ones(1,n);
    for i=1:n
        x=tones((step*(i-1)+1):(step*(i-1)+1000));
        digits(i)=tone2digit(x,fs,tl);
    end
    return;
function digit=tone2digit(tone,~,~)
    % beep:beep
    % fs:sampling freq
    % tl:tone length
    % sl:silence length
    % returns -1 if an error occurs
    %%
    t=0:999;
    N=2048;
    %%
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
    Eb=abs(fft(tone,N)).^2;
    th=12000;    %threshold
    if      abs(Eb(236)-E0(236))<th && abs(Eb(335)-E0(335))<th
        digit=0;
    elseif  abs(Eb(175)-E1(175))<th && abs(Eb(303)-E1(303))<th
        digit=1;
    elseif  abs(Eb(175)-E2(175))<th && abs(Eb(335)-E2(335))<th
        digit=2;
    elseif  abs(Eb(175)-E3(175))<th && abs(Eb(370)-E3(370))<th
        digit=3;
    elseif  abs(Eb(194)-E4(194))<th && abs(Eb(303)-E4(303))<th
        digit=4;
    elseif  abs(Eb(194)-E5(194))<th && abs(Eb(335)-E5(335))<th
        digit=5;
    elseif  abs(Eb(194)-E6(194))<th && abs(Eb(370)-E6(370))<th
        digit=6;
    elseif  abs(Eb(214)-E7(214))<th && abs(Eb(303)-E7(303))<th
        digit=7;
    elseif  abs(Eb(214)-E8(214))<th && abs(Eb(335)-E8(335))<th
        digit=8;
    elseif	abs(Eb(116)-E9(116))<th && abs(Eb(370)-E9(370))<th
        digit=9;
    else
        digit=-1;
    end
end
end