% =========================================================================
%  Self-Organizing Map (SOM) Neural Network
%  Author      : Mohammad Dehbozorgi (MO.DBZ)
%  Created on  : 1404/01/31 (Persian Calendar)
%  Updated on  : 2025/04/20
%  Description : Competitive DT LQR with idare
% =========================================================================
%  License:
%  This code is provided as-is without any warranty. 
%  You may use, modify, and distribute it for educational 
%  and research purposes with proper credit to the author.
% =========================================================================

clc;
clear all;
close all ;

%% Creat Data in Contino
Ac = [0 1 0 0;0 0 1 0;0 0 0 1;-24 -50 -35 -10];
Bc = [0 0 0 1]';
Cc = [1 0 0 0];
Dc = 0;

%% Data convert continu to discreat 

sys_c = ss(Ac,Bc,Cc,Dc);
Ts = 0.1;
sys_d = c2d (sys_c,Ts);
step (sys_d)
A = sys_d.a ; 
B = sys_d.b ; 
%% Solve LQR with idare
n = size(A,1);
R = 1;
Q = eye (n);
E = eye(n);
S = zeros(n , 1);
[P_lqr,K_lqr,L_lqr] = idare(A,B,Q,R,S,E);

