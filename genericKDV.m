function result = genericKDV(f, xmin, xmax, N, tmax, delta_t, plotter)
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

    for n = 1:nmax
        t = n*delta_t;
        
        U = fiLinear(U, k, delta_t);
        U = U + fiNonLinear(U, k, delta_t);

        if mod(n,nplt) == 0
            u = real(ifft(U));
            udata = [udata u.']; tdata = [tdata t];
            if mod(n,4*nplt) == 0 && plotter
                plot2D(x, u, t, xmin, xmax, 0, 10);
            end
        end
    end
    
    if plotter
        figure
        plot3D(x, udata(:,1:4:end)', tdata(1:4:end), xmin, xmax, 0, 10, 0, tmax);
    end
    
    result = udata;
end