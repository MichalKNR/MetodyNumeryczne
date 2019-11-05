function h = thermal_conductivity(T1,T2)

end

function y = poly_approx(x)
X = [ -1500 -1000 -300 -50 -1 1 20 50 200 400 1000 2000];
Y = [178 176 168 161 160 160 160.2 161 165 168 174 179];
M = [ones(12,1) X' X'.^2 X'.^3 X'.^4 X'.^5 X'.^6];  
A = inv(M'*M)*M'*Y';
y = A(1) +x*A(2) + x^2*A(3)+x^3*A(4); 
YY = [-2000:2000];
XX = [-2000:2000];
for i = 1 : 4001
    YY(i) = A(1) +XX(i)*A(2) + XX(i)^2*A(3)+XX(i)^3*A(4)+XX(i)^4*A(5)+XX(i)^5*A(6)+XX(i)^6*A(7);
end
plot(XX,YY)
end

function h = glued_foo(T1, T2)

end