function [A,B,C,D,K,x0] = TDS(par,~)
K1=par(1,1);
J1=par(2,1);
C1=par(3,1);
J2=par(4,1);
K2=par(5,1);
C2=par(6,1);
J3=par(7,1);
C3=par(8,1);
kh=par(9,1);
A = [0,0,0,1,0,0;...
    0,0,0,0,1,0;...
    0,0,0,0,0,1;...
    -K1/J1,K1/J1,0,-C1/J1,0,0;...
    K1/J2,-(K1+K2)/J2,K2/J2,0,-C2/J2,0;...
    0,K2/J3,-K2/J3,0,0,-C3/J3]; 
B = [0;0;0;kh/J1;0;0];
C = [0,0,1,0,0,0];
D = zeros(1,1);
K = zeros(6,1);
x0 =[0;0;0;0;0;0];