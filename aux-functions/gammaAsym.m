function gammas = gammaAsym(order)
    M = ones(order);
    for i=2:order
        for j=1:order
            M(i,j)=j^(-i+1);
        end
    end
    gammas = M \ ([1 zeros(1, order - 1)]');
end