clear
clc
X = [ -1500 -1000 -300 -50 -1 1 20 50 200 400 1000 2000];
Y = [178 176 168 161 160 160 160.2 161 165 168 174 179];
order = 6;
y = [1:12];
ew = [1:12];
ebw = [1:12];
for i = 1 : length(X)
    y(i) = thermal_conductivity(X(i),order);
    ebw(i) = abs(y(i)-Y(i));
    ew(i) = ebw(i)/Y(i);
end
YY = [-1500:2000];
XX = [-1500:2000];
for i = 1 : 3501
    YY(i) = thermal_conductivity(XX(i),order) ;
end
plot(XX,YY)
txt = ['rz¹d: ' num2str(order)];
text(1000, 165, txt,'FontSize',14)
title('Aproksymacja, zadanie 2.a')
xlabel('ró¿nica temperatur [C]')
ylabel('przewodnictwo cieplne [W/m^2]')

sum_ew = 0;
sum_ebw = 0;
maks = ebw(1);
min = ebw(1);
maks_ew = ew(1);
maks_ebw = ebw(1);
for i = 1 : length(X)
    sum_ew = sum_ew + ew(i);
    sum_ebw = sum_ebw + ebw(i);
    if ebw(i)>maks
        mask = ebw(i);
    end
    if ew(i)>maks_ew
        maks_ew = ew(i);
    end
    if ebw(i)>maks_ebw
        maks_ebw = ebw(i);
    end
    if ebw(i)<min
        min = ebw(i);
    end
end
maks_ebw
maks_ew
mean_ew = sum_ew/12
mean_ebw = sum_ebw/12