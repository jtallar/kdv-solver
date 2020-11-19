function plotError(t, err, method_name)
    plot(t,err,'LineWidth',2);
    title(method_name,' Error=f(t)');
    xlabel('t');
    ylabel('error');
end