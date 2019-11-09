function dy = oil_temp_transfer(temperature_vector_prev, mass)
A_cross_section =  0.0109;
%mb_rod_mass = 0.2; %task 1 version
mb_rod_mass = 0.4; %task 3 version          
%mw_oil_mass = 2.5;  
mw_oil_mass = mass; 
cb_rod_heat_capacity = 3.85;                      
cw_oil_heat_capacity = 4.1813; 
Tb = temperature_vector_prev(1); %oil
Tw = temperature_vector_prev(2); %rod
%h_thermal_conductivity = thermal_conductivity(Tb,Tw); %task 2 version
h_thermal_conductivity = 190; %task 3 version
%h_thermal_conductivity = 160; %task 1 version

dy =  [(Tw-Tb)*( h_thermal_conductivity*A_cross_section)/(mb_rod_mass*cb_rod_heat_capacity)
       (Tb-Tw)*( h_thermal_conductivity*A_cross_section)/(mw_oil_mass*cw_oil_heat_capacity)
    ];
end 