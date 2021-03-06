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
C = [1 0 0 0 0 0];
%D = [0;0;0];
D = 0;

[num, den]= ss2tf(A, B, C, D);
G = tf(num, den);

%from sisotool
pl = 8.51481572157349;
zl = 0.348551937866167;
k = 1.98881946562233;
L = tf([1, zl], [1, pl]);

subplot(2,2,1)
rlocus(G)

subplot(2,2,2)
rlocus(G*L)

subplot(2,2,[3 4])
cltf = feedback(k*G*L, 1);

step(cltf)