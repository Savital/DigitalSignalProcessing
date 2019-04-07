r = 5;
sigma = 2;
n = 100;

[t_r, f_r] = RectSignal(-r, r, n);
[t_g, f_g] = GaussSignal(-r, r, sigma, n);

f_rr = conv(f_r, f_r);
dt_rr = 2*r / (length(t_r) + length(t_r) - 2);
t_rr = -r:dt_rr:r;
f_rg = conv(f_r, f_g);
dt_rg = 2*r / (length(t_r) + length(t_g) - 2);
t_rg = -r:dt_rg:r;
f_gg = conv(f_g, f_g);
dt_gg = 2*r / (length(t_g) + length(t_g) - 2);
t_gg = -r:dt_gg:r;

figure('Name', 'Digital Signal Processing - Lab3');
hold on;
grid on;
xlabel('t');
ylabel('f(t)');
subplot(3,3,1);
% Rectangle && Rectangle
plot(t_r, f_r, 'r');
subplot(3,3,2);
plot(t_r, f_r, 'r');
subplot(3,3,3);
plot(t_rr, f_rr, 'g');
% Rectangle && Gauss
subplot(3,3,4);
plot(t_r, f_r, 'r');
subplot(3,3,5);
plot(t_g, f_g, 'r');
subplot(3,3,6);
plot(t_rg, f_rg, 'g');
% Gauss && Gauss
subplot(3,3,7);
plot(t_g, f_g, 'r');
subplot(3,3,8);
plot(t_g, f_g, 'r');
subplot(3,3,9);
plot(t_gg, f_gg, 'g');
hold off;

function y = GaussFunc(x, sigma)
    y = exp( - x * x / (sigma * sigma));
end

function [t, signal] = GaussSignal(a, b, sigma, n)
    dt = (b - a) / (n - 1);
    t = a:dt:b;
    i = 0;
    for x = t
        i = i + 1;
        s(i) = GaussFunc(x, sigma);
    end
    signal = s;
end

function y = RectFunc(x)
    Range = 5;
    if (x < -Range/2) || (x > Range/2)
        y = 0;
    else
        y = 1;
    end
end

function [t, signal] = RectSignal(a, b, n)
    dt = (b - a) / (n - 1);
    t = a:dt:b;
    i = 0;
    for x = t
        i = i + 1;
        s(i) = RectFunc(x);
    end
    signal = s;
end


