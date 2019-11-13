clc
clear

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
figure
plot(x_step, y_step)
title('Funkcja sklejana pierwszego rzêdu')
xlabel('ró¿nica temperatur [C]')
ylabel('przewodnictwo cieplne [W/m^2]')

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

XX = -1500 : 2000;
YY = -1500 : 2000;
x_step = [-1791.66 x_step 2291.66];
y_step(1) = 178;
y_step(end) = 179;
YY(1) = Y(1);
YY(end) = Y(end);
for i = 1 : length(XX)
    index = find_base_index(XX(i), x_step);
    if index(2) == 0 % XX(1) == x_step(1) 
        YY(i) = c(index(1)-2)*(x_step(index(1)) -XX(i))^3 + c(index(1)-1)*((x_step(index(1)+1) -XX(i))^3 - 4*((x_step(index(1)) -XX(i))^3)) + c(index(1))*((XX(i)-x_step(index(1)-2))^3 -4*(XX(i)-x_step(index(1)-1))^3)+c(index(1)+1)*(XX(i)-x_step(index(1)-1))^3;
    end
    if index(2) == 1 % XX(1) == x_step(1) 
        YY(i) = y_step(index(1)-2);
    end
end
figure
plot(XX,YY)
title('Funkcja sklejana trzeciego rzêdu')
xlabel('ró¿nica temperatur [C]')
ylabel('przewodnictwo cieplne [W/m^2]')


%x musi sie zawieraæ w przedziale (-1500, 2000)
function index = find_foo_index(x)
X = [ -1500 -1000 -300 -50 -1 1 20 50 200 400 1000 2000];
for i = 1 : (length(X)-1)
    if x < X(i+1)
        index = i;
        break
    end
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