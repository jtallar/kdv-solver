function res = termAfinSym(u, k, delta_t, numTerm)
    res = u;
    aux = floor((numTerm - 1) / 2) + 1;
    if mod(numTerm,2) == 1
        for i=1:aux
            res = fiLinear(res, k, delta_t/aux);
            res = fiNonLinear(res, k, delta_t/aux);
        end
    else
        for i=1:aux
            res = fiNonLinear(res, k, delta_t/aux);
            res = fiLinear(res, k, delta_t/aux);
        end
    end
end