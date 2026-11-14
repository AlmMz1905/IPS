clear all;
close all;
clc;

% Definición del vector de frecuencias digitales normalizadas s en [-0.5, 0.5]
ds = 0.001;
s = -0.5 : ds : 0.5;
fprintf('Ejercicio 1, inciso 1');
[n, x] = senial(); %Aca se carga la señal
%Aca se configura para el grafico
%Grafico temporal de la señal cargada
figure(1);
stem(n, x, 'filled', 'linewidth', 1.2);
grid on;
title('Inciso 1: Señal de entrada');
xlabel('Muestras n');
ylabel('Amplitud');
pause();
% Calculo de la TFTD de la señal cargada
% x es (1 x N), n' es (N x 1), s es (1 x Ns) -&gt; n' \* s genera matriz (N x Ns)
X = x * exp(-1j * 2 * pi * (n') * s);

%Grafico del espectro de la señal
figure(2);
plot(s, abs(X), 'b', 'linewidth', 1.5);
grid on;
title('Inciso 1: Espectro de Magnitud |X(e^{j2\\pi s})| de la Entrada');
xlabel('Frecuencia Digital s [ciclos/muestra]');
ylabel('|X(e^{j2\\pi s})|');
xlim([-0.5, 0.5]);
pause();
