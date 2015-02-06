zeta = 1.25;
omega = 2;
K = 1

num = K;
den = [1 2*zeta*omega omega^2];

P = tf(num, den);