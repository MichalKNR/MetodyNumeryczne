%do testów z tworzenia funkcji aproksymuj¹cych nale¿y podmieniæ nazwê
%funckjci aproksymuj¹cej na thermal_conductivity i wykomentow¹æ domyœln¹ 
%funkcjê która jest widoczna pod spodem


%na potrzeby testów w zadaniu dwa, zamieniæ komentarze na potrzeby
%symulacji
%function h = thermal_conductivity(T1,T2, order)
function h = thermal_conductivity(x, order)
h(1) = poly_approx(x, order);
h(2) = spline_approx(x);
%h = poly_approx(T1-T2, order);
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

function y = spline_approx(x)
X = [ -1500 -1000 -300 -50 -1 1 20 50 200 400 1000 2000];
Y = [178 176 168 161 160 160 160.2 161 165 168 174 179];

step = (2000 - (-1500))/12;
x_step = -1500 : step : 2000;
y_step = -1500 : step : 2000; %aby by³ ten sam rozmiar
y_step(1) = 178;
y_step(end) = 179;

%mamy 11 przedzia³ów
coefficients_1_order = [1:11 ; 1:11];

%obliczanie wspó³czynników funkcji sklejanej pierwszego stopnia
for i = 1 : length(coefficients_1_order)
    a = [1 X(i) 
         1 X(i+1)];
    y = [Y(i) ; Y(i+1)];
    coefficients_1_order(:,i) = a\y;
end

for i = 2 : (length(x_step)-1)
    y_step(i) = coefficients_1_order(1,find_foo_index(x_step(i))) + x_step(i)*coefficients_1_order(2,find_foo_index(x_step(i)));
end
% w tym miejscu mamy funkcjê sklejan¹ pierwszego stopnia

alfa = coefficients_1_order(2,1)/step;
beta = coefficients_1_order(2,end)/step;
y_step(1) = 178 + step/3*alfa;
y_step(end) = 179 - step/3*beta;
a  = [4 2 0 0 0 0 0 0 0 0 0 0 0
      1 4 1 0 0 0 0 0 0 0 0 0 0
      0 1 4 1 0 0 0 0 0 0 0 0 0
      0 0 1 4 1 0 0 0 0 0 0 0 0
      0 0 0 1 4 1 0 0 0 0 0 0 0
      0 0 0 0 1 4 1 0 0 0 0 0 0
      0 0 0 0 0 1 4 1 0 0 0 0 0
      0 0 0 0 0 0 1 4 1 0 0 0 0
      0 0 0 0 0 0 0 1 4 1 0 0 0
      0 0 0 0 0 0 0 0 1 4 1 0 0
      0 0 0 0 0 0 0 0 0 1 4 1 0
      0 0 0 0 0 0 0 0 0 0 1 4 1
      0 0 0 0 0 0 0 0 0 0 0 2 4];
  c = a\y_step';
  
c_m1 =  c(2) - step/3*alfa;
c_p13 = c(12) + step/3*beta;

c = [c_m1 c' c_p13];
%ka¿da funkcja bazowa jest dzielona przez trzeci¹ potegê odleg³osci pomiêdzy wêz³ami
c = c/step^3;

x_step = [-1791.66 x_step 2291.66];
y_step(1) = 178;
y_step(end) = 179;
    index = find_base_index(x, x_step);
    if index(2) == 0 % XX(1) == x_step(1) 
        y = c(index(1)-2)*(x_step(index(1)) -x)^3 + c(index(1)-1)*((x_step(index(1)+1) -x)^3 - 4*((x_step(index(1)) -x)^3)) + c(index(1))*((x-x_step(index(1)-2))^3 -4*(x-x_step(index(1)-1))^3)+c(index(1)+1)*(x-x_step(index(1)-1))^3;
    end
    if index(2) == 1 % XX(1) == x_step(1) 
        y = y_step(index(1)-2);
    end
end

function index = find_base_index(x, x_step)
index = [1;1]; %przygotowanie dwóch wymiarów
for i = 2 : (length(x_step)-1)
    if x == x_step(i)
        index(1) = i+1;
        index(2) = 1; %ma wartoœæ wêz³a
        break
    end
    if x < x_step(i+1)
        index(1) = i+1;
        index(2) = 0; %nie ma wartoœæ wêz³a
        break
    end
end
end

function index = find_foo_index(x)
X = [ -1500 -1000 -300 -50 -1 1 20 50 200 400 1000 2000];
for i = 1 : (length(X)-1)
    if x < X(i+1)
        index = i;
        break
    end
end
end