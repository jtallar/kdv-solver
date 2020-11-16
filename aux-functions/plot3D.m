function plot3D(x, u, t, xmin, xmax, umin, umax, tmin, tmax)
    waterfall(x,t,u)
    axis([xmin xmax tmin tmax umin umax])
    xlabel('x')
    ylabel('t')
    zlabel('u')
    grid('off')
end