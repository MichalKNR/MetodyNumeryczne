clc;
clear;

h_thermal_conductivity = 160;    %parameter 1
A_cross_section =  0.0109;       %parameter 2
mb_rod_mass = 0.2;               %parameter 3
mw_oil_mass = 2.5;               %parameter 4
cb_oil_heat_capacity = 3.85;     %parameter 5
cw_oil_heat_capacity = 4.1813;   %parameter 6
T_rod_start = 1200;              %parameter 7
T_oil_start = 25;                %parameter 8
TIME_MAX = 3;
time_step = 0.001;
time = 0:time_step:TIME_MAX;

%gathering all parameters as array to pass in functions
args = [h_thermal_conductivity, A_cross_section, mb_rod_mass, mw_oil_mass, cb_oil_heat_capacity, cw_oil_heat_capacity];

temperature = [1200
                25];
temperature(:,2) = temperature(:,1) + time_step*oil_temp_transfer(temperature(:,1), temperature(:,2), args);            
for i = 1 : length(time)-1
    time(i+1) = time(i) + time_step;
    time(i+1) = time_step*i;
    temperature(:,i+2) = temperature(:,i+1) + time_step*oil_temp_transfer(temperature(:,i), temperature(:,i+1), args); 
end

temperature(:, TIME_MAX/time_step)
