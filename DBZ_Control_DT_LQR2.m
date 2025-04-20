% =========================================================================
%  Simulation of Closed-Loop Control using Discrete-Time LQR
%  Author      : Mohammad Dehbozorgi (MO.DBZ)
%  Created on  : 1404/01/31 (Persian Calendar)
%  Updated on  : 2025/04/20
%  Description : Competitive LQR (Discrete-time)
% =========================================================================
%  License:
%  This code is provided as-is without any warranty. 
%  You may use, modify, and distribute it for educational 
%  and research purposes with proper credit to the author.
% =========================================================================

clc;
clear;
close all;

%% Continuous-Time System Definition
Ac = [0 1 0 0;
      0 0 1 0;
      0 0 0 1;
     -24 -50 -35 -10];

Bc = [0 0 0 1]';
Cc = [1 0 0 0];
Dc = 0;

%% Convert to Discrete-Time System
Ts = 0.1;                      % Sampling time
sys_c = ss(Ac, Bc, Cc, Dc);    
sys_d = c2d(sys_c, Ts);        % Discrete system

A = sys_d.A;
B = sys_d.B;

%% Solve Discrete-Time LQR using IDARE
n = size(A, 1);      % Number of states
Q = eye(n);          % State weighting matrix
R = 1;               % Control weighting scalar
S = zeros(n, 1);     % Cross-weighting term
E = eye(n);          % Identity (for standard form)

[P_lqr, K_lqr, ~] = idare(A, B, Q, R, S, E);

%% Closed-Loop Simulation
Tf = 20;                         % Final time (seconds)
t = 0:Ts:Tf;                     % Time vector
Nt = numel(t);                   % Number of time steps

x = zeros(n, Nt);                % State trajectory
x(:,1) = randn(n, 1);            % Random initial condition
u = zeros(1, Nt);                % Control input

Cost = x(:,1)' * Q * x(:,1);     % Initial cost

for k = 1:Nt-1
    u(k) = -K_lqr * x(:,k);                        % Control law
    x(:,k+1) = A * x(:,k) + B * u(k);              % System update
    Cost = Cost + x(:,k+1)' * Q * x(:,k+1) + ...   % Cost accumulation
                  u(k)' * R * u(k);
end

% Terminal cost from LQR solution
CosttoGo = x(:,1)' * P_lqr * x(:,1);

% Display results
disp(['Cost-to-Go (x0^T * P * x0): ', num2str(CosttoGo)]);
disp(['Accumulated Cost: ', num2str(Cost)]);

%% Plot State Trajectories
figure('Color', 'w');
for i = 1:4
    subplot(2,2,i);
    plot(t, x(i,:), 'LineWidth', 2);
    grid on;
    xlabel('Time (s)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel(['x_', num2str(i)], 'FontSize', 12, 'FontWeight', 'bold');
    title(['State x_', num2str(i)], 'FontSize', 14, 'FontWeight', 'bold');
end


