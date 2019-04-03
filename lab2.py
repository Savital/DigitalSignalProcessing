import numpy as np
import matplotlib.pyplot as plt
import time

def rectF(x):
    sigma = 2
    return np.exp( - x * x / (sigma * sigma))

def gaussF(x):
    return 0 if (x < -T_range/2 or x > T_range/2) else 1

def DFT_Xk(x, N, k):
    sums = complex(0,0)
    for n in range(N):
        phi = 2 * np.pi * k * n / N
        arg = x[n] * complex(np.cos(phi), -np.sin(phi)) 
        sums += arg
    return sums

def DFT(x):
    result = []
    N = len(x)
    for k in range(N):
        result.append(DFT_Xk(x, N, k))
    return np.array(result)

def FFT(x):
    N = len(x)
    if N <= 1: 
        return x
    even = FFT(x[0::2])
    odd =  FFT(x[1::2])
    T= [np.exp(-2j*np.pi*k/N)*odd[k] for k in range(N//2)]
    return [even[k] + T[k] for k in range(N//2)] + \
           [even[k] - T[k] for k in range(N//2)]

def FFT_except(x):
    N = len(x) 
    if N & (N-1):
        raise Exception("Число должно быть степенью 2")
    else:
        return np.array(FFT(x))

def formtwins(y):
    N = len(y)
    n2 = N // 2
    n1 = N - n2

    return np.append(y[n1:] ,y[:n2])

T_range = 5

func = np.vectorize(gaussF)  # rectF - Gauss, gaussF - Rect
T_max = 5
N_rect = 64
N_g = 64

K_spectre = np.arange(0, N_rect, 1)

T_rect = np.linspace(-T_max, T_max, N_rect)
S_rect = func(T_rect)


T_g = np.linspace(-T_max, T_max, N_g)
S_g = rectF(T_rect)

beg_d = time.time()
dft_res = abs(DFT(S_rect))
end_d = time.time()

beg_f = time.time()
fft_res = abs(FFT_except(S_rect))
end_f = time.time()

print("FFT faster then DFT in", (end_d - beg_d)/(end_f - beg_f), "times with N =", N_g)

dft_gres = abs(DFT(S_g))
fft_gres = abs(FFT_except(S_g))

plt.figure("lab2 - Digital signal processing")
plt.subplot(2,4,1).plot(K_spectre, dft_res, 'r')
plt.subplot(2,4,2).plot(K_spectre, formtwins(dft_res), 'g')
plt.subplot(2,4,3).plot(K_spectre, fft_res, 'k')
plt.subplot(2,4,4).plot(K_spectre, formtwins(fft_res), 'g')
plt.subplot(2,4,5).plot(K_spectre, dft_gres, 'r')
plt.subplot(2,4,6).plot(K_spectre, formtwins(dft_gres), 'g')
plt.subplot(2,4,7).plot(K_spectre, fft_gres, 'k')
plt.subplot(2,4,8).plot(K_spectre, formtwins(fft_gres), 'g')
plt.subplot(2,4,1).grid(True)
plt.subplot(2,4,2).grid(True)
plt.subplot(2,4,3).grid(True)
plt.subplot(2,4,4).grid(True)
plt.subplot(2,4,5).grid(True)
plt.subplot(2,4,6).grid(True)
plt.subplot(2,4,7).grid(True)
plt.subplot(2,4,8).grid(True)
plt.show()