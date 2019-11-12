clc;
clear;

% decydowanie które zadanie powinno og³aszaæ swoje wyniki
do_task_3 = 0;
do_task_4 = 0;

%podstawowe wartoœci wspó³czynników
A_cross_section =  0.0109;
mb_rod_mass = 0.2;        
mw_oil_mass = 2.5;  
cb_rod_heat_capacity = 3.85;                      
cw_oil_heat_capacity = 4.1813; 
h_thermal_conductivity = 160; 
arguments = [A_cross_section, mb_rod_mass, mw_oil_mass, cb_rod_heat_capacity, cw_oil_heat_capacity, h_thermal_conductivity];
T_rod_start = 1200;       
T_oil_start = 25;  

%zmienne opisuj¹ce czas i krok symulacji
TIME_MAX = 3;
time_step = 0.0001;
time = 0:time_step:TIME_MAX;
n = TIME_MAX/time_step;

if do_task_3 == 1
    calculate_oil_mass(T_oil_start, T_rod_start, arguments, time, n, time_step);
end

%przygotowanie wektora wynikowego
temperature = [T_rod_start:T_rod_start+n
                T_oil_start:T_oil_start+n];

%ca³kowanie metod¹ jawna Eulera            
for i = 1 : length(time)-1
    time(i+1) = time_step*i;
    %y_1_2 = temperature(:,i) + time_step/2*oil_temp_transfer(temperature(:,i), arguments);
    %temperature(:,i+1) = temperature(:,i) + time_step*oil_temp_transfer(y_1_2, arguments); 
    
    temperature(:,i+1) = temperature(:,i) + time_step*oil_temp_transfer(temperature(:,i), arguments); 
    %temperature(:,i+1) = temperature(:,i) + time_step*oil_temp_transfer(temperature(:,i+1), arguments);
end
% rysowanie wykresu
final_temperature_normal = temperature(:, n);
plot_task1(time, temperature, T_oil_start, T_rod_start, TIME_MAX,time_step, final_temperature_normal(2), final_temperature_normal(1))



%wykonywanie symulacji zadania 4 dla ró¿nych wartoœci pocz¹tkowych
if do_task_4 == 1
    change_vulnerability(final_temperature_normal, time, time_step, TIME_MAX, arguments, 1200, 25)
    change_vulnerability(final_temperature_normal, time, time_step, TIME_MAX, arguments, 700, 50)
end



function plot_task1(t, y, Tw, Tb, t_max, t_step, Tw_final, Tb_final)
figure 
plot(t, y(1,:), t, y(2,:))
txt = {['Tw(0):      ' num2str(Tw)],['Tw(end):  ' num2str(Tw_final)],[' '], ['Tb(0):      ' num2str(Tb)], ['Tb(end):  ' num2str(Tb_final)],[' '],[ 'Tsym:      ' num2str(t_max)],[ 'Tstep:      ' num2str(t_step)]};
text(1.5, 500, txt,'FontSize',14)
title('Symulator, zadanie 1')
xlabel('czas [s]')
ylabel('temperatura [C]')
legend('Tb','Tw')
end

function mass = calculate_oil_mass(Tw, Tb, arguments, time, n, h)
temperature = [Tb:Tb+n
                Tw:Tw+n];
while temperature(1,n) > 100 %a¿ temperatura na koniec symulacji bêdzie mniejsza równa 100
    %zerowanie wyników
    temperature = [Tb:Tb+n
                Tw:Tw+n];
    %metoda jawna Eulera                  
    for i = 1 : length(time)-1
         time(i+1) = h*i;
         temperature(:,i+1) = temperature(:,i) + h*oil_temp_transfer(temperature(:,i), arguments); 
    end
    %zwiêkszenie masy oleju o 0.1 kg
    arguments(3) = arguments(3) + 0.1;
    temperature(:,n) %dotychczas osi¹gniêta temperatura
    arguments(3) %dotychczas osi¹gniêta masa
end
mass = arguments(3);
end


function y = change_vulnerability(final_temp, time, time_step, TIME_MAX, arguments, Tb, Tw)
%przygotowanie wektora
temperature = [Tb:Tb+length(time)-1
                Tw:Tw+length(time)-1];
%    przygotowanie tablic wra¿liwoœci na zmiany        
args_vulnerability = [1:length(arguments)
                        1:length(arguments)];
time_vulnerability = [1:length(arguments)
                        1:length(arguments)];
                    
time_step_table = [0.1 0.01 0.001 0.0001 0.00001 0.000001];              

for j = 1 : length(arguments)
    delta_arg = 0.1;
    args = arguments;
    args(j) = args(j) + args(j)*delta_arg;
    %metoda jawna Eulera
    for i = 1 : length(time)-1
        time(i+1) = time_step*i;
        temperature(:,i+1) = temperature(:,i) + time_step*oil_temp_transfer(temperature(:,i), args); 
    end 
    %obliczenie pochodnej cz¹stkowej
    args_vulnerability(:,j) = (temperature(:,end) - final_temp)/(args(j)*delta_arg);
    
    n = TIME_MAX/time_step_table(j);
    temperature = [Tb:Tb+n-1
                Tw:Tw+n-1];
    %metoda jawna Eulera
    for i = 1 : n-1
        time(i+1) = time_step_table(j)*i;
        temperature(:,i+1) = temperature(:,i) + time_step_table(j)*oil_temp_transfer(temperature(:,i), args); 
    end 
    %obliczenie pochodnej cz¹stkowej
    time_vulnerability(:,j) = (temperature(:,end) - final_temp)/(time_step/time_step_table(j));
end
%wypisanie tabel
args_vulnerability
time_vulnerability
end