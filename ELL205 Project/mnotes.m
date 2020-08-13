Fs = 44100;
T=0.5;
recObj = audiorecorder(Fs,8,1);
recordblocking(recObj, T);           
y = getaudiodata(recObj);
% [y,Fs] = audioread('notes/D5.wav');
%y = (y(:,1)+y(:,2))/2;
N = size(y);
N = N(1);
% T = N/Fs;
t = (0:N-1)/Fs;
plot(t,y);
for i=1:T/20
    y(i) = 0;
    y(end-i) = 0;
end
F = abs(fft(y)/N);
if (mod(N,2) ~= 0)
    N = N-1;
end
F = F(1:((N)/2)+1);
F(2:end-1) = 2*F(2:end-1);
f = Fs*(0:N/2)/N;
plot(f,F);
%[peaks,indices] = findpeaks(F);
%indices = Fs*indices/N;
[largest, F0] = max(F);
for i=1:100*N/Fs
    if(F(i) < 0.2*largest)
        F(i) = 0;
    end
end
plot(f,F);
F0 = abs(Fs*F0/N);
note = 12*log2(F0/440);
note = round(note);
disp(note)