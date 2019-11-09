clc;
clear;

do_task_3 = 0;

A_cross_section =  0.0109;
mb_rod_mass = 0.2; %task 1 version         
mw_oil_mass = 2.5;  
cb_rod_heat_capacity = 3.85;                      
cw_oil_heat_capacity = 4.1813; 
h_thermal_conductivity = 160; %task 1 version
arguments = [A_cross_section, mb_rod_mass, mw_oil_mass, cb_rod_heat_capacity, cw_oil_heat_capacity, h_thermal_conductivity];

T_rod_start = 1200;       
T_oil_start = 25;  

TIME_MAX = 3;
time_step = 0.0001;
time = 0:time_step:TIME_MAX;
n = TIME_MAX/time_step;

if do_task_3 == 1
    calculate_oil_mass(T_oil_start, T_rod_start, arguments, time, n, time_step);
end

temperature = [T_rod_start:T_rod_start+n
                T_oil_start:T_oil_start+n];

for i = 1 : length(time)-1
    time(i+1) = time_step*i;
    temperature(:,i+1) = temperature(:,i) + time_step*oil_temp_transfer(temperature(:,i), arguments); 
end

plot_task1(time, temperature, TIME_MAX, time_step)

final_temperature_normal = temperature(:, n);

change_vulnerability = 1:length(arguments);

for j = 1 : length(arguments)
    arguments(j) = arguments(j) + arguments(j)*0.1;
    for i = 1 : length(time)-1
        time(i+1) = time_step*i;
        temperature(:,i+1) = temperature(:,i) + time_step*oil_temp_transfer(temperature(:,i), arguments); 
    end
    %change_vulnerability(j) = (temperature(:,n) - final_temperature_normal)/arguments(j)*0.1;
end

function plot_task1(t, y, TIME_MAX, time_step)
figure 
plot(t, y(1,:), t, y(2,:))
title('symulator, zadanie 1')
xlabel('czas [s]')
ylabel('temperatura [C]')
end

function mass = calculate_oil_mass(Tw, Tb, arguments, time, n, h)
temperature = [Tb:Tb+n
                Tw:Tw+n];
while temperature(1,n) > 100
temperature = [Tb:Tb+n
                Tw:Tw+n];
                       
for i = 1 : length(time)-1
    time(i+1) = h*i;
    temperature(:,i+1) = temperature(:,i) + h*oil_temp_transfer(temperature(:,i), arguments); 
end
arguments(3) = arguments(3) + 1;
temperature(:,n) %end temperature in simulation
end
arguments(3)
end