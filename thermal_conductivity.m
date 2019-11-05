function h = thermal_conductivity(T1,T2)

end

function y = poly_approx(x)
X = [ -1500 -1000 -300 -50 -1 1 20 50 200 400 1000 2000];
Y = [178 176 168 161 160 160 160.2 161 165 168 174 179];
M = [ones(12,1) X' X'.^2 X'.^3];  
A = inv(M'*M)*M'*Y';
y = A(1) +x*A(2) + x^2*A(3)+x^3*A(4); 
YY = [-2000:2000];
XX = [-2000:2000];
for i = 1 : 4001
    YY(i) = A(1) +XX*A(2) + XX^2*A(3)+XX^3*A(4)
end
plot(XX,YY)
end

function h = glued_foo(T1, T2)

end