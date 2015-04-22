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
b = [0; 0; 0; kh/J1; 0; 0];
c = [0 0 1 0 0 0];

% Determine open-loop poles and zeros.
[OLPoles, OLZeros] = pzmap(ss(A,b,c, 0));

% Design the state feedback controller
Q = [
1 0 0 0 0 0;
0 1 0 0 0 0;
0 0 1 0 0 0;
0 0 0 1 0 0;
0 0 0 0 1 0;
0 0 0 0 0 1;
];
R = [1];

[K, x, CoPoles] = lqr(A,b,Q,R);
% Kar is just a copy of K so it can be output as an array for easy printing.
Kar=K;

% Let's disable the control for now:
K= [0 0 .1 0 0 0];    %  [MARKER 1]

ObPoles = 1*real(CoPoles) + 1i*imag(CoPoles);
L = place(A',c',ObPoles)';

% Let's disable the estimator feedback for now:
L = L*0;   % [MARKER 2]

% Create observer state space model
sys = ss(A,[L b],c, 0);

% Calculate Nx, Nu, Nbar 
% See (Franklin, 4th edition, p. 526)
N = inv([A b; c 0])*[zeros(size([A; c],1)-1,1); 1];
Nx = N(1:end-1);
Nu = N(end);
Nbar = Nu + K*Nx;