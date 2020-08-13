Fs = 1000;           % Sampling frequency                    
T = 1/Fs;             % Sampling period       
T0 = 1.5;             % Duration of signal
N = Fs*T0;            % No. of samples
t = (0:N-1)*T;        % Time vector
S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);
X = S;% + 2*randn(size(t));
plot(1000*t(1:N/30),X(1:N/30))
title('Signal Corrupted with Zero-Mean Random Noise')
xlabel('t (milliseconds)')
ylabel('X(t)')
Y = fft(X);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')