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
Z1 = tf([2.7 1], [1]);
P1 = tf([1], [0.000061, 1]);
P2 = tf([1], [0.0676, 0.31, 1]);
k = 0.050542;
comp = k*Z1*P1*P2;

cltf = feedback(comp*G, 1);


subplot(2,2,1)
rlocus(G)

subplot(2,2,2)
rlocus(comp*G)

subplot(2,2,[3 4])
step(cltf)
% figure(1)
% subplot(2,1,1)
% bode(G)
% 
% subplot(2,1,2)
% bode(L*G)
% 
% figure(2)
% subplot(2,1,1)
% bode(feedback(G, 1))
% 
% subplot(2,1,2)
% bode(feedback(L*G, 1))