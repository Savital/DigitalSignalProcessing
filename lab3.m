T_range = 5;

% Gauss Signal
N_f = 100;
dt = 2* T_range / N_f;
T_f = -T_range:dt:T_range;
i = 0;
for x = T_f
    i = i + 1;
    S_f(i) = f(x);
end

% analogital Signal
N_analog = 100;
dt = 2* T_range / (N_analog);
T_analog = -T_range:dt:T_range;
i = 0;
for x = T_analog
    i = i + 1;
    S_analog(i) = g(x);
end

% Recovering of the analogital signal
N_rec = 50;
dt = T_range / (N_rec);
T_rec = -T_range:dt:T_range;
i = 0;
for x = T_rec
    i = i + 1;
    S_rec(i) = g(x);
end
S_rec = recover(T_rec, S_rec, dt);

disp(length(T_analog))
disp(length(S_rec))

figure('Name', 'analogital Signal Processing - Lab1');
hold on;
grid on;
xlabel('t');
ylabel('f(t)');
plot(T_f, S_f, 'g')
plot(T_analog, S_analog, 'r')
plot(T_rec, S_rec, 'b')
hold off;

function y = f(x)
    sigma = 2;
    y = exp( - x * x / (sigma * sigma));
end

function y = g(x)
    T_range = 5;
    if (x < -T_range/2) || (x > T_range/2)
        y = 0;
    else
        y = 1;
    end
end

function y = sinc(x) 
    if x == 0
        y = 1;
    else
        y = sin(x) / x;
    end
end

function y = recover(T, S, dt)
    for j = 1:length(T)
        sums = 0;
        for i = 1:length(S)
            sums = sums + S(i) * sinc(pi / dt *(T(j)-dt * (-round(length(S)/2) + i)));
        end
        S_r(j) = sums;
    end
    y = S_r;
end
    
