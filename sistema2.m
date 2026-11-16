% Funcion del sistema 2 de la ecuación en diferencia
% y[n] = 1/2x[n] - 1/2x[n-1]
% Es un filtro FIR pasa-altos

function y = sistema2(x)
   N = length(x); %Calcula la longitud del vector x
   y = zeros(1,N);
   x_prev = 0; % es la condicion inicial nula x[-1] = 0
   for n = 1:N
     y(n) = 0.5 * x(n) - 0.5 * x_prev;
     x_prev = x(n);
   end
end
