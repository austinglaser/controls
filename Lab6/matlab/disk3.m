clear all
clc

kh =2.58;
k1 =2.7;
k2 =2.7;
c1 =0.02;
c2 =0.01;
c3 = 0.08;
J1 = 0.1;
J2 = 0.1;
J3 = 0.1;

A = [0 0 0 1 0 0; 
    0 0 0 0 1 0; 
    0 0 0 0 0 1; 
    -(k1/J1) k1/J1 0 -(c1/J1) 0 0;
    (k1/J2) -(k1+k2)/J2 k2/J2 0 -(c2/J2) 0;
    0 k2/J3 -(k2/J3) 0 0 -(c3/J3)];
B = [0; 0; 0; kh/J1; 0; 0];
%C = [1 0 0 0 0 0; 0 1 0 0 0 0; 0 0 1 0 0 0];
C = [0 0 1 0 0 0];
%D = [0;0;0];
D = 0;

[num, den]= ss2tf(A, B, C, D);
G = tf(num, den);

% from sisotool
zl = 0.238735236105314;
pl = 0.54878048780488;
k = 0.167904143418752;
L = tf([1, zl], [1, pl]);

cltf = feedback(comp*G, 1);

figure(1)
subplot(2,2,1)
rlocus(G)
title('uncompensated')

subplot(2,2,2)
rlocus(G*L)
title('compensated')

subplot(2,2,[3 4])
step(cltf)
title('closed loop step')

figure(2)
subplot(2,2,1)
bode(G,{1,20})
title('open loop uncompensated')

subplot(2,2,2)
bode(L*G,{1,20})
title('open loop compensated')

subplot(2,2,3)
bode(feedback(G, 1),{1,20})
title('closed loop uncompensated')

subplot(2,2,4)
bode(feedback(L*G, 1),{1,20})
title('closed loop compensated')

figure(3)
subplot(2,1,1)
margin(G)
%title('uncompensated')

subplot(2,1,2)
margin(L*G)
%title('compensated')

