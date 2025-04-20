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

