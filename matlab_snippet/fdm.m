fs=8000;
t=0:1/fs:2;
m1 = sin(2*pi*800.*t);
m2 = sin(2*pi*1000.*t);
m3 = sin(2*pi*1200.*t);



c1_1 = sin(2*pi*12000.*t);
c1_2 = sin(2*pi*16000.*t);
c1_3 = sin(2*pi*20000.*t);

c2_1 = sin(2*pi*84000.*t);

s1 = m1.*c1;
s2 = m2.*c2;
s3 = m3.*c3;



LPF_order = 50;
LPF = fir1(LPF_order,0,4000/(fs/2));

BPF_order = 50;

BPF1_1 = fir1(BPF_order,12000/(fs/2),12300/(fs/2));
BPF1_2 = fir1(BPF_order,16000/(fs/2),16300/(fs/2));
BPF1_3 = fir1(BPF_order,20000/(fs/2),20300/(fs/2));

s1_BPF = filter(BPF1_1,1,s1);
s2_BPF = filter(BPF1_2,1,s2);
s3_BPF = filter(BPF1_3,1,s3);

s_sum = s1+s2+s3; 
s_sum_mod = s_sum.*c2_1;

BPF2_1 = fir1(BPF_order,72000/(fs/2),84000/(fs/2));
s_sum_mod_BPF = filter(BPF2_1,1,s_sum_mod);

BPF3_1 = fir1(BPF_order,72000/(fs/2),84000/(fs/2));
