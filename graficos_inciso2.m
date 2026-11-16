clear all; 
close all; 
clc;
graphics_toolkit('qt');
fprintf('Generando gráficos analíticos del Inciso 2...\\n');
%% Definición de los ejes 
% Eje temporal discreto para visualizar h[n] 
N_muestras = 25; 
% 25 muestras bastan para ver decaer a los IIR 
n = 0 : (N_muestras - 1);
% Eje de frecuencia digital s en el período fundamental [-0.5; 0.5] 
ds = 0.001; 
s = -0.5 : ds : 2;
%% Expresiones Analíticas de h[n] 
% Sistema 1 (FIR Pasa-bajos): h1[n] = 0.5\*delta[n] + 0.5\*delta[n-1] 
h1 = zeros(size(n)); 
h1(n == 0) = 0.5; 
h1(n == 1) = 0.5;
% Sistema 2 (FIR Pasa-altos): h2[n] = 0.5\*delta[n] - 0.5\*delta[n-1] 
h2 = zeros(size(n)); 
h2(n == 0) = 0.5; 
h2(n == 1) = -0.5;
% Sistema 3 (IIR Pasa-bajos): h3[0] = 0.25; h3[n&<;=1] = (3/4)\*(0.5)^n 
h3 = zeros(size(n)); 
h3(n == 0) = 0.25; 
h3(n >= 1) = (3/4) * (0.5 .^ n(n >= 1)); 
% Sistema 4 (IIR Pasa-altos): h4[0] = 0.25; h4[n >=1] = (3/4)\*(-0.5)^n 
h4 = zeros(size(n)); 
h4(n == 0) = 0.25; 
h4(n >= 1) = (3/4) * ((-0.5) .^ n(n >= 1));
ejw = exp(-1j * 2 * pi * s);
H1 = 0.5 * (1 + ejw); 
H2 = 0.5 * (1 - ejw); 
H3 = (0.25 * (1 + ejw)) ./ (1 - 0.5 * ejw); 
H4 = (0.25 * (1 - ejw)) ./ (1 + 0.5 * ejw);
%% 4\. FIGURA 1: Respuestas Impulsionales h[n] (Dominio Temporal) 
figure(1, 'name', 'Respuestas Impulsionales h[n]');
subplot(2, 2, 1); 
stem(n, h1, 'filled', 'linewidth', 1.3); 
grid on; 
title('Sistema 1: h_1[n] (FIR Pasa-bajos)'); 
xlabel('n'); 
ylabel('Amplitud'); 
ylim([-0.2, 0.6]);

subplot(2, 2, 2); 
stem(n, h2, 'filled', 'linewidth', 1.3); 
grid on; 
title('Sistema 2: h_2[n] (FIR Pasa-altos)'); 
xlabel('n'); 
ylabel('Amplitud'); 
ylim([-0.6, 0.6]);

subplot(2, 2, 3); 
stem(n, h3, 'filled', 'linewidth', 1.3); 
grid on; 
title('Sistema 3: h_3[n] (IIR Pasa-bajos)'); 
xlabel('n'); 
('Amplitud'); 
ylim([-0.1, 0.5]);

subplot(2, 2, 4); 
stem(n, h4, 'filled', 'linewidth', 1.3); 
grid on; 
title('Sistema 4: h_4[n] (IIR Pasa-altos)'); 
xlabel('n'); 
ylabel('Amplitud'); 
ylim([-0.5, 0.5]);

%% 5\. FIGURA 2: Respuestas en Frecuencia |H(e^{j2\\pi s})| (Magnitud) 
figure(2, 'name', 'Respuestas en Frecuencia |H(s)|');

subplot(2, 2, 1); 
plot(s, abs(H1), 'r', 'linewidth', 1.8); 
grid on; 
title('Sistema 1: |H_1(e^{j2\\pi s})| (FIR)'); 
xlabel('Frecuencia digital s [ciclos/muestra]'); 
ylabel('|H_1|'); 
xlim([-0.5, 2]); 
ylim([0, 1.1]);

subplot(2, 2, 2); 
plot(s, abs(H2), 'b', 'linewidth', 1.8); 
grid on; 
title('Sistema 2: |H_2(e^{j2\\pi s})| (FIR)'); 
xlabel('Frecuencia digital s [ciclos/muestra]'); 
ylabel('|H_2|'); 
xlim([-0.5, 2]); 
ylim([0, 1.1]);

subplot(2, 2, 3); 
plot(s, abs(H3), 'r', 'linewidth', 1.8); 
grid on; 
title('Sistema 3: |H_3(e^{j2\\pi s})| (IIR)'); 
xlabel('Frecuencia digital s [ciclos/muestra]');
ylabel('|H_3|'); 
xlim([-0.5, 2]); 
ylim([0, 1.1]);

subplot(2, 2, 4); 
plot(s, abs(H4), 'b', 'linewidth', 1.8); 
grid on; 
title('Sistema 4: |H_4(e^{j2\\pi s})| (IIR)'); 
xlabel('Frecuencia digital s [ciclos/muestra]'); 
ylabel('|H_4|'); 
xlim([-0.5, 2]); 
ylim([0, 1.1]);
drawnow; 
fprintf('Gráficos listos en pantalla. Presiona Enter en la terminal para continuar...\\n'); 
pause();