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

% Exactitud entre metodos ----------------------------------------------
N = 256; delta_t = 0.000005;

disp('---- Lie Trotter ----');
lt1 = lieTrotter(u0, xmin, xmax, N, tmax, delta_t, false);
lt2 = lieTrotter(u0, xmin, xmax, N, tmax, delta_t/2, false);
err = norm(lt2-lt1,inf);
disp('Error con Lie Trotter');
disp(err);

disp('---- Strang ----');
st1 = strang(u0, xmin, xmax, N, tmax, delta_t, false);
st2 = strang(u0, xmin, xmax, N, tmax, delta_t/2, false);
err = norm(st2-st1,inf);
disp('Error con Strang');
disp(err);

disp('---- Afin Simetrico Orden 2 ----');
order = 2;
as1o2 = afinSym(u0, order, xmin, xmax, N, tmax, delta_t, false);
as2o2 = afinSym(u0, order, xmin, xmax, N, tmax, delta_t/2, false);
err = norm(as1o2-as2o2,inf);
disp('Error con Afin Simetrico Orden 2');
disp(err);

disp('---- Afin Simetrico Orden 4 ----');
order = 4;
as1o4 = afinSym(u0, order, xmin, xmax, N, tmax, delta_t, false);
as2o4 = afinSym(u0, order, xmin, xmax, N, tmax, delta_t/2, false);
err = norm(as1o4-as2o4,inf);
disp('Error con Afin Simetrico Orden 4');
disp(err);

disp('---- Afin Simetrico Orden 6 ----');
order = 6;
as1o6 = afinSym(u0, order, xmin, xmax, N, tmax, delta_t, false);
as2o6 = afinSym(u0, order, xmin, xmax, N, tmax, delta_t/2, false);
err = norm(as1o6-as2o6,inf);
disp('Error con Afin Simetrico Orden 6');
disp(err);

% ----------------------------------------------------------------------

% % Exactitud del afin 4to orden entre pasos -----------------------------
% N = 256; delta_t = 0.000005;
% 
% disp('---- Afin Simetrico Orden 4 ----');
% order = 4;
% as1o4 = afinSym(u0, order, xmin, xmax, N, tmax, delta_t, false);
% as2o4 = afinSym(u0, order, xmin, xmax, N, tmax, delta_t/2, false);
% as4o4 = afinSym(u0, order, xmin, xmax, N, tmax, delta_t/4, false);
% as8o4 = afinSym(u0, order, xmin, xmax, N, tmax, delta_t/8, false);
% err = norm(as1o4-as2o4,inf);
% disp('Error con Afin Simetrico Orden 4 Paso h');
% disp(err);
% err = norm(as2o4-as4o4,inf);
% disp('Error con Afin Simetrico Orden 4 Paso h/2');
% disp(err);
% err = norm(as4o4-as8o4,inf);
% disp('Error con Afin Simetrico Orden 4 Paso h/4');
% disp(err);
% 
% % ----------------------------------------------------------------------
% 
% % Variacion de Speed Up segun el orden ---------------------------------
% N = 128; delta_t = 0.0001;
% 
% order = 2;
% disp('----- Afin Simetrico Orden 2 -----');
% disp('Tiempo sin spmd Orden 2');
% tic
% as1o4s = afinSym(u0, order, xmin, xmax, N, tmax, delta_t, false);
% toc
% disp('Tiempo CON SPMD Orden 2');
% as1o4p = afinSymSPMD(u0, order, xmin, xmax, N, tmax, delta_t, false);
% dif = norm(as1o4s-as1o4p,inf);
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
% set(gca,'FontSize',8)
% set(gca,'LineWidth',2)
% 
% N = 256; delta_t = 0.000005;
% 
% disp('---- Afin Simetrico Orden 4 con graficos ----');
% order = 4;
% as1o4 = afinSym(u0, order, xmin, xmax, N, tmax, delta_t, true);
% 
% % ----------------------------------------------------------------------