clc;
clear;

h_thermal_conductivity = 160;    %parameter 1
A_cross_section =  0.0109;       %parameter 2
%mb_rod_mass = 0.2;               %parameter 3 task1 version
mb_rod_mass = 0.4; %task 3 version
%mw_oil_mass = 2.5;               %parameter 4
mw_oil_mass = 0.01; 
cb_oil_heat_capacity = 3.85;     %parameter 5
cw_oil_heat_capacity = 4.1813;   %parameter 6
T_rod_start = 1200;              %parameter 7
T_oil_start = 25;                %parameter 8
TIME_MAX = 2;
time_step = 0.001;
time = 0:time_step:TIME_MAX;

%gathering all parameters as array to pass in functions
%in task 3 parameter 3 will be matter of change
args = [A_cross_section, mb_rod_mass, mw_oil_mass, cb_oil_heat_capacity, cw_oil_heat_capacity];
temperature = [T_rod_start:T_rod_start+2000
                T_oil_start:T_oil_start+2000];
while (T_rod_start - temperature(1,2001)) < 100
temperature = [T_rod_start:T_rod_start+2000
                T_oil_start:T_oil_start+2000];
            
temperature(:,2) = temperature(:,1) + time_step*oil_temp_transfer(temperature(:,1), args);            
for i = 1 : length(time)-1
    time(i+1) = time(i) + time_step;
    time(i+1) = time_step*i;
    temperature(:,i+2) = temperature(:,i+1) + time_step*oil_temp_transfer(temperature(:,i), args); 
end
mw_oil_mass = mw_oil_mass + 0.01;
args(3) = mw_oil_mass;
end
mw_oil_mass

plot_task1(time, temperature, TIME_MAX, time_step)

temperature(:,2001) %end temperature in simulation

function plot_task1(t, y, TIME_MAX, time_step)
t = [t TIME_MAX+time_step];
figure 
plot(t, y(1,:), t, y(2,:))
title('symulator, zadanie 1')
xlabel('czas [s]')
ylabel('temperatura [C]')
end
