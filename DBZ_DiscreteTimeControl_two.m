clc;
clear;
close all;

% Define continuous-time transfer function
s = tf('s');
T = 0.01; % Sampling time
Gs = s / ((s + 1)^2 * (s + 2));

% Discretize using First-Order Hold
Gz = c2d(Gs, T, 'foh');

% Plot impulse responses
figure;
impulse(Gs, 'b'); hold on;
impulse(Gz, 'r--');
legend('Continuous-time', 'Discrete-time (FOH)');
title('Impulse Response Comparison');
grid on;

% Plot step responses
figure;
step(Gs, 'b'); hold on;
step(Gz, 'r--');
legend('Continuous-time', 'Discrete-time (FOH)');
title('Step Response Comparison');
grid on;
