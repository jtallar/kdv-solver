function fiNonLinear = fiNonLinear(u, k, h)
    fiNonLinear = -(3i * k * h).*fft((real(ifft(u))).^2);
end