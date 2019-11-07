function dy = oil_temp_transfer(temperature_vector_prev, arguments)
A_cross_section =  arguments(1);       
mb_rod_mass = arguments(2);            
mw_oil_mass = arguments(3);            
cb_rod_heat_capacity = arguments(4);                      
cw_oil_heat_capacity = arguments(5); 
Tb = temperature_vector_prev(1); %oil
Tw = temperature_vector_prev(2); %rod
%h_thermal_conductivity = thermal_conductivity(Tb,Tw); 
h_thermal_conductivity = 190; %task 3 version

dy =  [(Tw-Tb)*( h_thermal_conductivity*A_cross_section)/(mb_rod_mass*cb_rod_heat_capacity)
       (Tb-Tw)*( h_thermal_conductivity*A_cross_section)/(mw_oil_mass*cw_oil_heat_capacity)
    ];
end 