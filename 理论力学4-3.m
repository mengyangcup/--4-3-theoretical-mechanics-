%% way_2
syms  x1 x2 x3 x4 x5
equ1 = x1 + x4 - 400*sin(pi/4) == 0;
equ2 = x2 + x3 - 400*sin(pi/4) == 0;
equ3 = x3 + x4 - 120 == 0;
equ4 = x4 - x5*x2 == 0;
equ5 = x3 - x5*x1 == 0;
s = solve(equ1,equ2,equ3,equ4,equ5);
double(s.x5)