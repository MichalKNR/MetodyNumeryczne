function dy = oil_temp_transfer(temperature_vector_prev, x)
Tb = temperature_vector_prev(1); %oil
Tw = temperature_vector_prev(2); %rod

h = thermal_conductivity(Tb,Tw,5);

%równania stanu
%parametr 6 wymieniæ na h, je¿eli chcemy obliczyc wspó³czynnik poprzez
%aproksymacjê
dy =  [(Tw-Tb)*( h*x(1))/(x(2)*x(4))
       (Tb-Tw)*( h*x(1))/(x(3)*x(5))
    ];
end 