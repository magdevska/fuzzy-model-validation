% constants of the reference ODE model

EGFRtot = 3e5;
RAStot = 6e4;
SOStot = 1e5;
RasGAPtot = 6e3;
RAFtot = 5e5;
MEKtot = 2e5;
ERKtot = 3e6;

kfast = 100;
a1 = 5e-5;
a2 = 1e-7;
b1 = 1e-5;
p1 = 1e-7;
p2 = 3e-6;

d = 0.01;
d1 = d;
d2 = d;
u1A = d;
q1 = d;
q2 = d;
b2A = 1e-6;
b2B = 0.1*b2A;
u1B = kfast;
u2A = 1;
u2B = 1;

k2A = 1e-4;
k2B = 0.1*k2A;
k2C = 0;
b3 = 1e-5;
k3 = kfast;
u3 = 0.01;

p3 = 3e-9;
p = 6e-10;
p4 = p;
p6 = p;

q = 3e-4;
q3 = q;
q4 = q;
q6 = q;
q5 = kfast;

fERKppSOS1 = 1;
fERKppMEK1 = 1;
fERKppRAF = 1;
