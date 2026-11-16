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
%pause();

% if 
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
%pause();


% ---------- Ejercicio 2 ---------- 
numAl = 025320;
% Caso de Alam Meza: 037091
% Caso de Nicolas Peñalba: 025320
[nh, h_A] = hcanald(numAl);
figure;
stem(nh, h_A, 'filled', 'linewidth', 1.5);
grid on;
title('Respuesta al impulso del canal h_A[n]');
xlabel('Muestras n');
ylabel('Amplitud');

% --- Ej2.2 ---
% Verificar la respuesta del canal ante un impulso unitario.
delta = [1, zeros(1, length(h_A) - 1)];
h_verif = canal_ecos(delta, h_A);
h_verif = h_verif(1:length(h_A));

error_max = max(abs(h_A - h_verif));
fprintf('Error máximo entre h_A y la respuesta calculada: %e\n', error_max);

figure;
subplot(2, 1, 1);
stem(nh, h_A, 'filled', 'linewidth', 1.2);
grid on;
title('Respuesta impulsional de referencia (hcanald.m)');
xlabel('Muestras n');
ylabel('Amplitud');

subplot(2, 1, 2);
stem(nh, h_verif, 'filled', 'r', 'linewidth', 1.2);
grid on;
title('Respuesta impulsional calculada con canal_ecos(delta[n])');
xlabel('Muestras n');
ylabel('Amplitud');

% --- INCISO 3 ---
% Cargar el audio original.
[x, fs] = audioread('audio.wav');

% Aplicar el canal con ecos a cada canal de audio.
y = zeros(size(x, 1) + length(h_A) - 1, size(x, 2));
for channel = 1:size(x, 2)
    y(:, channel) = canal_ecos(x(:, channel), h_A);
end

% Reproducir la señal con eco.
sound(y, fs);

% Graficar la señal original y la distorsionada.
figure;
subplot(2, 1, 1);
plot(x);
grid on;
title('Señal de audio original x[n]');
xlabel('Muestras');
ylabel('Amplitud');

subplot(2, 1, 2);
plot(y);
grid on;
title('Señal de audio distorsionada con ecos y[n]');
xlabel('Muestras');
ylabel('Amplitud');

% --- INCISO 4: Ecualizador de 2 ramas ---
N_max = 17640 + 1; % Largo suficiente para cubrir el retardo n2.
he2 = zeros(1, N_max);
he2(1) = 1;          % n = 0 (índice 1 en Octave)
he2(8820 + 1) = -0.5;   % n = 8820 (índice 8821)
he2(17640 + 1) = -0.25; % n = 17640 (índice 17641)

% Respuesta impulsional de la cascada canal + ecualizador de 2 ramas.
h_cascada_2 = conv(h_A, he2);

% --- INCISO 4: Ecualizador de 3 ramas ---
N_max_3 = 3 * 8820 + 1;
he3 = zeros(1, N_max_3);
he3(1) = 1;
he3(8820 + 1) = -0.5;
he3(17640 + 1) = -0.25;
he3(26460 + 1) = 0.25; % Rama adicional que cancela el residuo en n = 26460.

% Respuesta impulsional de la cascada canal + ecualizador de 3 ramas.
h_cascada_3 = conv(h_A, he3);

figure;
subplot(2, 1, 1);
stem(h_cascada_2(1:35281), 'filled');
grid on;
title('Cascada Canal + Ecualizador (2 ramas)');
xlabel('Muestras n');
ylabel('Amplitud');

subplot(2, 1, 2);
stem(h_cascada_3(1:44101), 'filled');
grid on;
title('Cascada Canal + Ecualizador (3 ramas)');
xlabel('Muestras n');
ylabel('Amplitud');


% --- INCISO 5: Filtrado de la señal distorsionada y comparación ---
% Filtrar la señal distorsionada con los ecualizadores de 2 y 3 ramas.
y_rec2 = zeros(size(y, 1) + length(he2) - 1, size(y, 2));
y_rec3 = zeros(size(y, 1) + length(he3) - 1, size(y, 2));
for channel = 1:size(y, 2)
    y_rec2(:, channel) = conv(y(:, channel), he2);
    y_rec3(:, channel) = conv(y(:, channel), he3);
end

% Comparar las muestras alineadas usando la norma 2 del audio estereo vectorizado.
error_rec2 = y_rec2(1:size(x, 1), :) - x;
error_rec3 = y_rec3(1:size(x, 1), :) - x;
E_rel2 = norm(error_rec2(:)) / norm(x(:));
E_rel3 = norm(error_rec3(:)) / norm(x(:));
fprintf('Error relativo con 2 ramas: %.4f (%.2f%%)\n', E_rel2, 100 * E_rel2);
fprintf('Error relativo con 3 ramas: %.4f (%.2f%%)\n', E_rel3, 100 * E_rel3);

% Reproducir el audio recuperado.
sound(y_rec2, fs); % Audio recuperado con 2 ramas
sound(y_rec3, fs); % Audio recuperado con 3 ramas

% Graficar las señales original y recuperadas.
figure;
subplot(3, 1, 1);
plot(x, 'b');
grid on;
title('1. Audio Original x[n]');
xlabel('Muestras');
ylabel('Amplitud');

subplot(3, 1, 2);
plot(y_rec2, 'r');
grid on;
title('2. Audio Recuperado - Ecualizador de 2 Ramas (y_{rec2}[n])');
xlabel('Muestras');
ylabel('Amplitud');

subplot(3, 1, 3);
plot(y_rec3, 'g');
grid on;
title('3. Audio Recuperado - Ecualizador de 3 Ramas (y_{rec3}[n])');
xlabel('Muestras');
ylabel('Amplitud');

% Exportar todas las figuras abiertas como imágenes PNG.
script_dir = fileparts(mfilename('fullpath'));
output_dir = fullfile(script_dir, 'Graficos');
if ~exist(output_dir, 'dir')
    mkdir(output_dir);
end

figures = findall(0, 'type', 'figure');
for index = 1:numel(figures)
    figure_number = get(figures(index), 'number');
    output_file = fullfile(output_dir, sprintf('figura_%02d.png', figure_number));
    print(figures(index), output_file, '-dpng', '-r150');
    fprintf('Figura exportada: %s\n', output_file);
end