%do testów z tworzenia funkcji aproksymuj¹cych nale¿y podmieniæ nazwê
%funckjci aproksymuj¹cej na thermal_conductivity i wykomentow¹æ domyœln¹ 
%funkcjê która jest widoczna pod spodem

function h = thermal_conductivity(T1,T2, order)
h = poly_approx(T1-T2, order);
end

function y = poly_approx(x, order)
X = [ -1500 -1000 -300 -50 -1 1 20 50 200 400 1000 2000];
Y = [178 176 168 161 160 160 160.2 161 165 168 174 179];
M = [ones(12,1)];
%tworzenie macierzy M w zale¿noœci od rzêdu
for i = 1 : order
    M = [M X'.^i];
end
%obliczanie macierzy wspó³czynników
A = inv(M'*M)*M'*Y';

y = A(1); 
    %obliczanie wartoœci funkcji
    for i = 1 : order
         y = y + x^i*A(i+1);
    end
end

function h = glued_foo(T1, T2)

end