clear all;clc;close all;

gaussian_antenna(10, 10);

function gaussian_antenna(theta_s, theta_half)
theta = -20:0.1:20;

F1 = exp(-2.8 * (theta - theta_s/2).^2 / theta_half^2);
F2 = exp(-2.8 * (theta + theta_s/2).^2 / theta_half^2);

figure();
hold on;
plot(theta, F1);
plot(theta, F2);
grid on
title("高斯天线方向图");
end