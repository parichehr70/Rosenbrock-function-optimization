clear all
syms x1 x2
f = @(x1,x2)((1-x1).^2 + 100*(x2-x1.^2).^2);
% f = @(x1,x2)(x1.^2 + 9*x2.^2);
X1 = -1.5:0.01:2;
X2 = -0.5:0.01:3;
[X1 X2] = meshgrid(X1, X2);
contour(X1, X2, f(X1, X2));
G = gradient(f(x1,x2));
alpha = 0.00111;
x(:,1) = [2;-0.5];
y(1) = f(x(1,1),x(2,1));
%-----------unsupervised-----------------
% for i = 1:1000
% g = subs(G,{x1, x2}, {x(1,i),x(2,i)});
% x(:,i+1) = x(:,i) - alpha*g;
% y(i+1) = f(x(1,i+1),x(2,i+1));
% end
%----------------------------------------

%------------supervised------------------
i = 0;
while(1)
i = i+1;
g = subs(G,{x1, x2}, {x(1,i),x(2,i)});
x(:,i+1) = x(:,i) - alpha*g;
y(i+1) = f(x(1,i+1),x(2,i+1));
if max(abs(vpa(g)))<0.01
    break;
end
end
%----------------------------------------

hold on
plot3(x(1,:), x(2,:), y, 'r-*');