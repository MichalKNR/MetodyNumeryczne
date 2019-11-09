function dy = oil_temp_transfer(temperature_vector_prev, x)
Tb = temperature_vector_prev(1); %oil
Tw = temperature_vector_prev(2); %rod

dy =  [(Tw-Tb)*( x(6)*x(1))/(x(2)*x(4))
       (Tb-Tw)*( x(6)*x(1))/(x(3)*x(5))
    ];
end 