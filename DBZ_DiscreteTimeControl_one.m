clc;
clear;
close all ;


s = tf('s');
k = 0.1;
T = 0.2;
Ghk = ((1-k*exp(-T*s))*(1-exp(-T*s)))/(s)+(k/(T*s^2)*(1-exp(-T*s))^2);