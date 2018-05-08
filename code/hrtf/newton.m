function x = newton(x0, eps, N)
% x0是初值，可以任取，不需要满足方程组
% 最后得到的解与初值选取有关
% eps为精度
% N最大迭代次数

for i = 1:N
    f = eval(subs(fun(), {'x1', 'x2', 'x3'}, {x0(1), x0(2), x0(3)}));
    df = eval(subs(dfun(), {'x1', 'x2', 'x3'}, {x0(1), x0(2), x0(3)}));
    x = x0 - f/df;
    if norm(x - x0) < eps
        for j = 1:length(x)
            fprintf('%.2f\t', x(j));
        end
        break;
    end
    x0 = x;
end