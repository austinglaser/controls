K = 1;
Kp = 1;
z = 1.25;
w = 2;

num = [K*Kp];
den = [1 2*z*w w^2];

H = tf(num, den);
rlocus(H, linspace(0,150,3000));