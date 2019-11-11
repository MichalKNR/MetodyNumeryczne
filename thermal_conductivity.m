%do test�w z tworzenia funkcji aproksymuj�cych nale�y podmieni� nazw�
%funckjci aproksymuj�cej na thermal_conductivity i wykomentow�� domy�ln� 
%funkcj� kt�ra jest widoczna pod spodem

function h = thermal_conductivity(T1,T2, order)
h = poly_approx(T1-T2, order);
end

function y = poly_approx(x, order)
X = [ -1500 -1000 -300 -50 -1 1 20 50 200 400 1000 2000];
Y = [178 176 168 161 160 160 160.2 161 165 168 174 179];
M = [ones(12,1)];
%tworzenie macierzy M w zale�no�ci od rz�du
for i = 1 : order
    M = [M X'.^i];
end
%obliczanie macierzy wsp�czynnik�w
A = inv(M'*M)*M'*Y';

y = A(1); 
    %obliczanie warto�ci funkcji
    for i = 1 : order
         y = y + x^i*A(i+1);
    end
end

function h = glued_foo(T1, T2)

end