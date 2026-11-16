function y = canal_ecos(x, h_A)
% Aplicamos el modelo de canal con ecos a la señal de entrada x
% y = conv(x, h\_A) se encarga de hacer la convolución discreta equivalente a la
% ecuación en diferencias: en nuestro caso usamos el numero 025320 por lo que es
% y[n] = x[n] + 0.5\*x[n-8820] + 0.25\*x[n-17640]

    y = conv(x, h_A);
end