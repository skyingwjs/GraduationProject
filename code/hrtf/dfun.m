function df = dfun()
%方程组的Jacobi矩阵
f = fun();
df = [diff(f,'x1'); diff(f, 'x2'); diff(f, 'x3')];
df = df';