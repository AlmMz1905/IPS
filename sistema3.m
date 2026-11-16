% Funcion del sistema 2 de la ecuación en diferencia
% y[n] = 1/4x[n] + 1/4x[n-1] + 1/2Y[n-1]
% Es un filtro IIR pasa-bajos
function y = sistema3(x)
  N = length(x);
  y = zeros(1, N);
  x_prev = 0;
  y_prev = 0;
    for n = 1:N
      y(n) = 0.25 * x(n) + 0.25 * x_prev + 0.5 * y_prev;
      x_prev = x(n);
      y_prev = y(n);
    end
end
