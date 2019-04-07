r = 5;
sigma = 2;
n = 100;

[t_g, f_g] = GaussSignal(-r, r, sigma, n);

wgnf_g = awgn(f_g, 1);
wunf_g = awun(f_g, 1);

[b_l,a_l] = butter(6, 0.5, 'low');
btwgn_l = filter(b_l, a_l, wgnf_g);
btugn_l = filter(b_l, a_l, wunf_g);

h = gaussdesign(0.01, 4, 2);
%fvtool(h,'impulse');
hd = dfilt.dffir(h);
y1 = filter(hd, wgnf_g);
y2 = filter(hd, wunf_g);

figure('Name', 'Digital Signal Processing - Lab4');
hold on;
grid on;
xlabel('t');
ylabel('f(t)');
subplot(3,3,1);
plot(t_g, f_g, 'k');
subplot(3,3,2);
plot(t_g, wunf_g, 'r');
subplot(3,3,3);
plot(t_g, wgnf_g, 'r');
subplot(3,3,5);
plot(t_g, btwgn_l, 'g');
subplot(3,3,6);
plot(t_g, btugn_l, 'g');
subplot(3,3,8);
stem(t_g, y1, 'b');
subplot(3,3,9);
stem(t_g, y2, 'b');
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

function [ y ] = awun( x, snr_db )
    SP=norm(x).^2;
    NP=sqrt(SP*10^-(snr_db/10)/length(x))*1;
    y=x+NP*(0.5-rand(size(x)));
end