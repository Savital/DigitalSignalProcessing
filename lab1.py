import numpy as np
import matplotlib.pyplot as plt
import datetime

def rectF(x):
    sigma = 3
    return np.exp( - x * x / (sigma * sigma))

def gaussF(x):
    if (x < -T_range/2 or x > T_range/2):
        return 0
    else:
        return 1

def sinc(x):
    if x == 0:
        return 1
    else:
        return np.sin(x) / x

def recover(T, S_g, dt):
    S_r = [0] * len(T)
    for j in range(len(T)):
        sums = 0.
        for i in range(len(S_g)):
            sums += S_g[i] * sinc(np.pi / dt *(T[j]-dt * (-round(len(S_g)/2) + i)))
        S_r[j] = sums
    return np.array(S_r)

T_range = 5
N = 100
N_rec = 20

dt = T_range / (N_rec)

func = np.vectorize(gaussF)

T = np.linspace(-T_range, T_range, N)
T_rec = np.arange(-T_range, T_range, dt)

S_g = func(T)
S_gauss = rectF(T)

S_rec = func(T_rec)
S_rec = recover(T, S_rec, dt)

S_grec = rectF(T_rec)
S_grec = recover(T, S_grec, dt)

plt.figure("lab1 - Digital signal processing")
plt.subplot(2,2,1).plot(T, S_g, 'r')
plt.subplot(2,2,2).plot(T, S_rec, 'g')
plt.subplot(2,2,3).plot(T, S_gauss, 'r')
plt.subplot(2,2,4).plot(T, S_grec, 'g')
plt.subplot(2,2,1).grid(True)
plt.subplot(2,2,2).grid(True)
plt.subplot(2,2,3).grid(True)
plt.subplot(2,2,4).grid(True)
plt.show()
