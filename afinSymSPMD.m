function result = afinSymSPMD(f, order, xmin, xmax, N, tmax, delta_t, plotter)
    if mod(order,2) ~= 0 || order <= 0
        disp("Order must be pair");
        return;
    end

    c = parcluster;
    c.NumWorkers = order;
    parpool('local', order);
    
    x = linspace(xmin,xmax,N);
    delta_x = x(2) - x(1);
    
    delta_k = 2*pi/(N*delta_x);
    k = [0:delta_k:(N/2-1)*delta_k,0,-(N/2-1)*delta_k:delta_k:-delta_k];
    
    u = f(x);

    t=0;

    if plotter
        plot2D(x, u, t, xmin, xmax, 0, 10);
    end

    nplt = floor((tmax/100)/delta_t);
    nmax = round(tmax/delta_t);
    udata = u.'; tdata = 0;
    U = fft(u);

    gammas = repelem(gammaSym(order), 2); % [g1;g1;g2;g2;g3;g3...]
    
    for n = 1:nmax
        t = n*delta_t;
        
        spmd(order) % Abro el trabajo paralelo
            term = gammas(labindex) * termAfinSym(U, k, delta_t, labindex);
        end
  
        % Acumulo en U los resultados, que estan en cada term{i}
        U = zeros(1, N);
        for i=1:order
            U = U + term{i};
        end
        
        if mod(n,nplt) == 0
            u = real(ifft(U));
            udata = [udata u.']; tdata = [tdata t];
            if mod(n,4*nplt) == 0 && plotter
                plot2D(x, u, t, xmin, xmax, 0, 10);
            end
        end
    end
    
    delete(gcp('nocreate'))
    
    if plotter
        figure
        plot3D(x, udata(:,1:4:end)', tdata(1:4:end), xmin, xmax, 0, 10, 0, tmax);
    end
    
    result = udata;
end
