function df = dfun()
%�������Jacobi����
f = fun();
df = [diff(f,'x1'); diff(f, 'x2'); diff(f, 'x3')];
df = df';