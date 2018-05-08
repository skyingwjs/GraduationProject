function f = fun()
% ���:
% 3*x1-cos(x2*x3)-1/2 = 0
% x1^2-81*(x2+0.1)^2+sin(x3)+1.06 = 0
% exp(-x1*x2)+20*x3+(10*pi-3)/3 = 0
% ��⾫��Ϊ0.00001

syms x1 x2 x3
f1 = 3*x1-cos(x2*x3)-1/2;
f2 = x1^2-81*(x2+0.1)^2+sin(x3)+1.06;
f3 = exp(-x1*x2)+20*x3+(10*pi-3)/3;
f = [f1 f2 f3];