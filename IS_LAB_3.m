clc


x = 0.1: 1/22: 1;
y = (1 + 0.6*sin (2 * pi * x / 0.7)) + 0.3 * sin (2 * pi * x) / 2;
[p,n1] = findpeaks(y);


for i = 1 : length(n1)
    
    c(i)= x(n1(i));
    
end

r1 = 0.36 - 0.19;
r2 = 0.89 - 0.73;
w0 = randn(1);
w1 = randn(1);
w2 = randn(1);
Eta = 0.1;
elim = 0.0000000001;
e = [];
etotal = 1;

while etotal >= elim
 
e = [];
Y = [];

for i = 1 : length(x)
    
F1 = exp(-(x(i)-c(1))^2/(2*r1^2));
F2 = exp(-(x(i)-c(2))^2/(2*r2^2));
Y(i) = F1*w1+F2*w2+w0;
e(i) = y(i) - Y(i);

D1 = e(i);
w1 = w1 + Eta*D1*F1;
w2 = w2 + Eta*D1*F2;
w0 = w0 + Eta*D1*1;

end


for i = 1 : length(x)
    F1 = exp(-(x(i)-c(1))^2/(2*r1^2));
    F2 = exp(-(x(i)-c(2))^2/(2*r2^2));
    Y(i) = F1*w1+F2*w2+w0;
    e(i) = y(i) - Y(i);
end

etotal = (e.^2)/length(x);
fprintf('e=%2.10f \n',etotal);

end

plot(x,y,'g*', x,Y,'ro')