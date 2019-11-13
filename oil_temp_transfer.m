function dy = oil_temp_transfer(temperature_vector_prev, x)
Tb = temperature_vector_prev(1); %oil
Tw = temperature_vector_prev(2); %rod

h = thermal_conductivity(Tb,Tw,5);

%r�wnania stanu
%parametr 6 wymieni� na h, je�eli chcemy obliczyc wsp�czynnik poprzez
%aproksymacj�
dy =  [(Tw-Tb)*( h*x(1))/(x(2)*x(4))
       (Tb-Tw)*( h*x(1))/(x(3)*x(5))
    ];
end 