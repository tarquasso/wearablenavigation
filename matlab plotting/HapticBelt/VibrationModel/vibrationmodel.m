% kh - human spring constant
% bh - human damping constant
% kr - rubber spring constant
% kb - elastic band spring constant
% mm - motor mass
% mc - motorcap mass
syms kh kr kb bh

mm = 0.05;
mc = 0.27;

A = [0                  0         1       0;...
     0                  0         0       1;...
     -(kh+kr)/mm       kr/mm    -bh/mm     0;...
     kr/mc       -(kh+kb+kr)/mc   0    -bh/mc];
 
B = [0; 0; 1/mm; 0];

C = [1 0 0 0; 0 1 0 0];

D = zeros(2,1);

kA = subs(A,[kb bh],[5 0.1]);

AA = double(subs(kA, [kh kr],[2 4]));

sys = ss(AA,B,C,D);

t = 0:0.001:2;
u = sin(100*t);

lsim(sys,u,t)