function plot2D(x, u, t, xmin, xmax, umin, umax)
    plot(x,u,'LineWidth',2)
    axis([xmin xmax umin umax])
    xlabel('x')
    ylabel('u')
    text(6,9,['t = ',num2str(t,'%1.2f')],'FontSize',14)
    drawnow
end