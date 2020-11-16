addpath(genpath(fileparts(which('main.m'))));

set(gca,'FontSize',8)
set(gca,'LineWidth',2)
N = 256;
xmin = -10; xmax = 10;
tmax = 1.2;
delta_t = 0.4/N^2; % h, paso temporal
c_1 = 13;
c_2 = 3;
% Ver si es x+8 o x+3 aca:         .|.
u0 = @(x)(1/2*c_1*(sech(sqrt(c_1)*(x+8)/2)).^2 + 1/2*c_2*(sech(sqrt(c_2)*(x+1)/2)).^2);

tic
genericKDV(u0, xmin, xmax, N, tmax, delta_t, false);
toc