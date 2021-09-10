clear all
syms x1 x2
% f = @(x1,x2)(1.5*x1.^2 + x2.^2 - 2*x1.*x2 + 2*x1.^3 + 0.5*x1.^4);
% f = @(x1,x2)(x1.^2 + 9*x2.^2);
f = @(x1,x2)((1-x1).^2 + 100*(x2-x1.^2).^2);
X1 = -1.5:0.01:2;
X2 = -0.5:0.01:3;
[X1 X2] = meshgrid(X1, X2);
contour(X1, X2, f(X1, X2));
G = gradient(f(x1,x2));
[X1 X2] = solve(G);
X1 = double(X1)
X2 = double(X2)
H = hessian(f(x1,x2));
for i = 1:length(X1)
    eval(sprintf('D(:,%d) = double(eig(subs(H, {x1, x2}, {X1(%d), X2(%d)})))',i, i, i));
end
alpha_max = 2/max(D)
y = f(X1, X2)
hold on
plot3(X1, X2, y, 'ro');