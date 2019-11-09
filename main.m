clc;
clear;

T_rod_start = 1200;       
T_oil_start = 25;  

TIME_MAX = 2;
time_step = 0.2;
time = 0:time_step:TIME_MAX;
n = TIME_MAX/time_step;
mw_oil_mass = 1;

temperature = [T_rod_start:T_rod_start+n
                T_oil_start:T_oil_start+n];
while temperature(1,n) > 100
temperature = [T_rod_start:T_rod_start+n
                T_oil_start:T_oil_start+n];
                       
for i = 1 : length(time)-1
    time(i+1) = time_step*i;
    temperature(:,i+1) = temperature(:,i) + time_step*oil_temp_transfer(temperature(:,i), mw_oil_mass); 
end
mw_oil_mass = mw_oil_mass + 1;
temperature(:,n) %end temperature in simulation
end

plot_task1(time, temperature, TIME_MAX, time_step)
mw_oil_mass

function plot_task1(t, y, TIME_MAX, time_step)
figure 
plot(t, y(1,:), t, y(2,:))
title('symulator, zadanie 1')
xlabel('czas [s]')
ylabel('temperatura [C]')
end
