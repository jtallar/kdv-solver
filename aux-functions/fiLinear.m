function fiLinear = fiLinear(u, k, h)
    fiLinear = u.*exp(1i * k.^3 * h);
end