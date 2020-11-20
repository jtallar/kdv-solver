addpath(genpath(fileparts(which('main.m'))));

% N = 256;
N = 128;
xmin = -10; xmax = 10;
tmax = 1.2;
% delta_t = 1.65/N^2; % h, paso temporal
delta_t = 0.0001;
c_1 = 13;
c_2 = 3;
% Ver si es x+8 o x+3 aca:         .|.
u0 = @(x)(1/2*c_1*(sech(sqrt(c_1)*(x+8)/2)).^2 + 1/2*c_2*(sech(sqrt(c_2)*(x+1)/2)).^2);
order = 2;

% % Exactitud entre metodos ----------------------------------------------
% N = 256; delta_t = 0.000005;
% 
% disp('---- Lie Trotter ----');
% [lt1, t_lt1] = lieTrotter(u0, xmin, xmax, N, tmax, delta_t, false);
% [lt2, t_lt2] = lieTrotter(u0, xmin, xmax, N, tmax, delta_t/2, false);
% err_lt = max(abs(lt1-lt2));
% figure; plotError(t_lt1, err_lt, 'Lie Trotter');
% 
% disp('---- Strang ----');
% [st1, t_st1] = strang(u0, xmin, xmax, N, tmax, delta_t, false);
% [st2, t_st2] = strang(u0, xmin, xmax, N, tmax, delta_t/2, false);
% err_st = max(abs(st1-st2));
% figure; plotError(t_st1, err_st, 'Strang');
% 
% disp('---- Afin Simetrico Orden 2 ----');
% order = 2;
% [as1o2, t_as1o2] = afinSym(u0, order, xmin, xmax, N, tmax, delta_t, false);
% [as2o2, t_as2o2] = afinSym(u0, order, xmin, xmax, N, tmax, delta_t/2, false);
% err_aso2 = max(abs(as1o2-as2o2));
% figure; plotError(t_as1o2, err_aso2, 'Afin Sim Orden 2');
% 
% disp('---- Afin Simetrico Orden 4 ----');
% order = 4;
% [as1o4, t_as1o4] = afinSym(u0, order, xmin, xmax, N, tmax, delta_t, false);
% [as2o4, t_as2o4] = afinSym(u0, order, xmin, xmax, N, tmax, delta_t/2, false);
% err_aso4 = max(abs(as1o4-as2o4));
% figure; plotError(t_as1o4, err_aso4, 'Afin Sim Orden 4');
% 
% disp('---- Afin Simetrico Orden 6 ----');
% order = 6;
% [as1o6, t_as1o6] = afinSym(u0, order, xmin, xmax, N, tmax, delta_t, false);
% [as2o6, t_as2o6] = afinSym(u0, order, xmin, xmax, N, tmax, delta_t/2, false);
% err_aso6 = max(abs(as1o6-as2o6));
% figure; plotError(t_as1o6, err_aso6, 'Afin Sim Orden 6');
% 
% figure;
% plotError(t_as1o2, err_aso2, 'Afin Sim');
% hold on
% plotError(t_as1o4, err_aso4, 'Afin Sim');
% plotError(t_as1o6, err_aso6, 'Afin Sim');
% hold off

% % ----------------------------------------------------------------------

% % Exactitud del afin 4to orden entre pasos -----------------------------
% N = 256; delta_t = 0.000005;
%  
% disp('---- Afin Simetrico Orden 4 ----');
% order = 4;
% [as1o4, t_as1o4] = afinSym(u0, order, xmin, xmax, N, tmax, delta_t, false);
% [as2o4, t_as2o4] = afinSym(u0, order, xmin, xmax, N, tmax, delta_t/2, false);
% [as4o4, t_as4o4] = afinSym(u0, order, xmin, xmax, N, tmax, delta_t/4, false);
% [as8o4, t_as8o4] = afinSym(u0, order, xmin, xmax, N, tmax, delta_t/8, false);
% 
% err_h = max(abs(as1o4-as2o4));
% figure; plotError(t_as1o4, err_h, 'Afin Sim Orden 4 Paso h');
% 
% err_h_2 = max(abs(as2o4-as4o4));
% figure; plotError(t_as2o4, err_h_2, 'Afin Sim Orden 4 Paso h/2');
% 
% err_h_4 = max(abs(as4o4-as8o4));
% figure; plotError(t_as4o4, err_h_4, 'Afin Sim Orden 4 Paso h/4');
% 
% figure;
% plotError(t_as1o4, err_h, 'Afin Sim');
% hold on
% plotError(t_as2o4, err_h_2, 'Afin Sim');
% plotError(t_as4o4, err_h_4, 'Afin Sim');
% hold off

% % ----------------------------------------------------------------------
% 
% Variacion de Speed Up segun el orden ---------------------------------
% N = 128; delta_t = 0.0001;
%  
% order = 2;
% disp('----- Afin Simetrico Orden 2 -----');
% disp('Tiempo sin spmd Orden 2');
% tic
% as1o2s = afinSym(u0, order, xmin, xmax, N, tmax, delta_t, false);
% toc
% disp('Tiempo CON SPMD Orden 2');
% as1o2p = afinSymSPMD(u0, order, xmin, xmax, N, tmax, delta_t, false);
% dif = norm(as1o2s-as1o2p,inf);
% disp('Check diferencia ~0');
% disp(dif);
% 
% order = 4;
% disp('----- Afin Simetrico Orden 4 -----');
% disp('Tiempo sin spmd Orden 4');
% tic
% as2o4s = afinSym(u0, order, xmin, xmax, N, tmax, delta_t, false);
% toc
% disp('Tiempo CON SPMD Orden 4');
% as2o4p = afinSymSPMD(u0, order, xmin, xmax, N, tmax, delta_t, false);
% dif = norm(as2o4s-as2o4p,inf);
% disp('Check diferencia ~0');
% disp(dif);
% 
% order = 6;
% disp('----- Afin Simetrico Orden 6 -----');
% disp('Tiempo sin spmd Orden 6');
% tic
% as3o6s = afinSym(u0, order, xmin, xmax, N, tmax, delta_t, false);
% toc
% disp('Tiempo CON SPMD Orden 6');
% as3o6p = afinSymSPMD(u0, order, xmin, xmax, N, tmax, delta_t, false);
% dif = norm(as3o6s-as3o6p,inf);
% disp('Check diferencia ~0');
% disp(dif);
% 
% % ----------------------------------------------------------------------
% 
% % Animaciones temporales -----------------------------------------------
set(gca,'FontSize',8)
set(gca,'LineWidth',2)

N = 256; delta_t = 0.000005;

disp('---- Afin Simetrico Orden 4 con graficos ----');
order = 4;
as1o4 = afinSym(u0, order, xmin, xmax, N, tmax, delta_t, true);

% % ----------------------------------------------------------------------