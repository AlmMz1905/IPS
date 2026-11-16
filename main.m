clear all;
close all;
clc;

% Merequeteque
% Definición del vector de frecuencias digitales normalizadas s en [-0.5, 0.5]
ds = 0.001;
s = -0.5 : ds : 2;
%% -------------------------------------------------------------------------
fprintf('Ejercicio 1, Inciso 1: Grafico temporarl y de la frecuencia de la señal otorgada..\n');
[n, x] = senial(); %Aca se carga la señal
%Aca se configura para el grafico
%Grafico temporal de la señal cargada
fprintf('\nPulse enter para generar la grafica de la frecuencia..\\n');
figure(1);
stem(n, x, 'filled', 'linewidth', 1.2);
grid on;
title('Inciso 1: Señal de entrada');
xlabel('Muestras n');
ylabel('Amplitud');
pause();

% Calculo de la TFTD de la señal cargada
% x es (1 x N), n' es (N x 1), s es (1 x Ns) ->; n' \* s genera una matriz (N x Ns)
X = x * exp(-1j * 2 * pi * (n') * s);

fprintf('Cada vez que se cierra una figura apretar enter para generar las otras graficas...\n'); 

% Grafico del espectro de la señal
figure(2);

plot(s, abs(X), 'b', 'linewidth', 1.5);
grid on;
title('Inciso 1: Espectro de Magnitud |X(e^{j2\\pi s})| de la Entrada');
xlabel('Frecuencia Digital s [ciclos/muestra]');
ylabel('|X(e^{j2\\pi s})|');
xlim([-0.5, 0.5]);
pause();

%% ------------------------------------------------------------------------- 
% Inciso 3: Verificación numérica de la Respuesta al Impulso y en Frecuencia 

fprintf('Procesando el Inciso 3: Verificación con delta de Kronecker...\\n'); 
% Generamos un impulso unitario centrado en el primer elemento con largo L 
L = 40; 
% 40 muestras son suficientes para ver el decaimiento de los IIR 
delta = [1, zeros(1, L-1)]; 
n_h = 0 : L-1; 
% Obtenemos las respuestas impulsionales numéricas pasando la delta a los sistemas 
h1_num = sistema1(delta); 
h2_num = sistema2(delta); 
h3_num = sistema3(delta); 
h4_num = sistema4(delta); 
% Calculamos la TFTD de cada respuesta al impulso 
H1_num = h1_num * exp(-1j * 2 * pi * (n_h') * s); 
H2_num = h2_num * exp(-1j * 2 * pi * (n_h') * s); 
H3_num = h3_num * exp(-1j * 2 * pi * (n_h') * s); 
H4_num = h4_num * exp(-1j * 2 * pi * (n_h') * s); 
% Gráfico comparativo de las respuestas en frecuencia |H(s)| 
figure(3); 

subplot(2,2,1); 
plot(s, abs(H1_num), 'r', 'linewidth', 1.5); 
grid on; 
title('Sistema 1 (FIR Pasa-bajos)'); 
xlabel('s'); 
ylabel('|H_1|'); 
xlim([-0.5, 2]); 

subplot(2,2,2); 
plot(s, abs(H2_num), 'b', 'linewidth', 1.5); 
grid on; 
title('Sistema 2 (FIR Pasa-altos)'); 
xlabel('s'); 
ylabel('|H_2|'); 
xlim([-0.5, 2]); 

subplot(2,2,3); 
plot(s, abs(H3_num), 'r', 'linewidth', 1.5); 
grid on; 
title('Sistema 3 (IIR Pasa-bajos)'); 
xlabel('s'); 
ylabel('|H_3|'); 
xlim([-0.5, 2]); 

subplot(2,2,4); 
plot(s, abs(H4_num), 'b', 'linewidth', 1.5); 
grid on; 
title('Sistema 4 (IIR Pasa-altos)'); 
xlabel('s'); 
ylabel('|H_4|'); 
xlim([-0.5, 2]);
pause();

%% ------------------------------------------------------------------------- 
% INCISO 4: Procesamiento de x[n] a través de los cuatro sistemas 

fprintf('Procesando el Inciso 4: Filtrado temporal de la señal x[n]...\\n'); 
y1 = sistema1(x); 
y2 = sistema2(x); 
y3 = sistema3(x); 
y4 = sistema4(x); 

% Grafico para cada sistemas
figure(4); 

subplot(2,2,1); 
stem(n, y1, 'filled'); 
grid on; 
title('Salida y_1[n] (Pasa-bajos FIR)'); 
xlabel('n'); 
ylabel('Amplitud');

subplot(2,2,2); 
stem(n, y2, 'filled'); 
grid on; 
title('Salida y_2[n] (Pasa-altos FIR)'); 
xlabel('n'); 
ylabel('Amplitud'); 

subplot(2,2,3); 
stem(n, y3, 'filled'); 
grid on; 
title('Salida y_3[n] (Pasa-bajos IIR)'); 
xlabel('n'); 
ylabel('Amplitud');

subplot(2,2,4); 
stem(n, y4, 'filled'); 
grid on; 
title('Salida y_4[n] (Pasa-altos IIR)'); 
xlabel('n'); 
ylabel('Amplitud');
pause();

%% ------------------------------------------------------------------------- 
% INCISO 5: Espectros de salida (TFTD) y comparación

fprintf('Procesando Inciso 5: Espectros de salida...\\n'); 
Y1 = y1 * exp(-1j * 2 * pi * (n') * s); 
Y2 = y2 * exp(-1j * 2 * pi * (n') * s); 
Y3 = y3 * exp(-1j * 2 * pi * (n') * s); 
Y4 = y4 * exp(-1j * 2 * pi * (n') * s); 

% Grafica del espectro de TFTD de la salida de la entrada
figure(5); 

subplot(2,2,1); 
plot(s, abs(Y1), 'm', 'linewidth', 1.5); 
grid on; 
title('Espectro |Y_1(e^{j2\\pi s})|'); 
xlabel('s'); 
ylabel('Magnitud'); 
xlim([-0.5, 0.5]); 

subplot(2,2,2); 
plot(s, abs(Y2), 'c', 'linewidth', 1.5); 
grid on; 
title('Espectro |Y_2(e^{j2\\pi s})|'); 
xlabel('s'); 
ylabel('Magnitud'); 
xlim([-0.5, 0.5]); 

subplot(2,2,3); 
plot(s, abs(Y3), 'm', 'linewidth', 1.5); 
grid on; 
title('Espectro |Y_3(e^{j2\\pi s})|'); 
xlabel('s'); 
ylabel('Magnitud'); 
xlim([-0.5, 0.5]); 

subplot(2,2,4); 
plot(s, abs(Y4), 'c', 'linewidth', 1.5); 
grid on; 
title('Espectro |Y_4(e^{j2\\pi s})|'); 
xlabel('s'); 
ylabel('Magnitud'); 
xlim([-0.5, 0.5]); 
pause();

fprintf('\\nEjecución finalizada con éxito. Todas las figuras generadas.\\n');