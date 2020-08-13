
function [F,pitch]= startpitch()

load('nnetwork.mat');


Fs=44100;        %Sampling Frequency

%Record Sound for T seconds.
T=0.5;         %seconds
recObj = audiorecorder(Fs,8,1);
recordblocking(recObj, T);           
sound = getaudiodata(recObj);       % Store Data in Double-Precision Array


%TODO Hagne lage to iss code ka kuch kario
for u=1:11000    %Remove Intital Samples of Sound Because of Initial Conditions
    sound(u)=0;
end


F=abs(fft(sound,Fs));    % Absolute Fourier Transform of Sound
F=F(1:Fs/2,1);      

lf=1;              % Lowest Frequencies
for i=1:lf           % Remove Low Frequencies Because of Noise and Microphone Limits
    F(i)=0;
end

for i=lf:Fs/2        % Remove Frequencies with relatively small amplitude, Because of Noise
    if F(i)<5
        F(i)=0;
    end;
end

%TODO add alternate method of finding maximas and test it
[val, Harmonic1]=max(F);     % Find Max

                     % Harmonics of Max

Harmonic2 = Harmonic1/2;
Harmonic3 = Harmonic1/3;
Harmonic4 = Harmonic1/4;
Harmonic5 = Harmonic1/5;
Harmonic2_2 = Harmonic2/2;
Harmonic2_4 = Harmonic2/4;
Harmonic2_3 = Harmonic2/3;
Harmonic3_2 = Harmonic3/2;




% Check Harmonics (Is there a peak? if yes 1 if no 0)
checkH1 = 0;
checkH2 = 0;
checkH3 = 0;
checkH4 = 0;
checkH5 = 0;
checkH22 = 0;
checkH24 = 0;
checkH23 = 0;
checkH32 = 0;

wH1 = 0;        %peaks position [1:41] ; normally is 21
wH2 = 0;         
wH3 = 0;
wH4 = 0;
wH5 = 0;
wH22 = 0;
wH24 = 0;
wH23 = 0;
wH32 = 0;

%Checks Harmonics
[checkH1,wH1]=harmonics(Harmonic1,F,net,lf);
if checkH1==1
    [checkH2,wH2]=harmonics(Harmonic2,F,net,lf);
    if checkH2==1
        [checkH22,wH22]=harmonics(Harmonic2_2,F,net,lf);
        if checkH22==1
            [checkH24,wH24]=harmonics(Harmonic2_4,F,net,lf);
        else
            [checkH23,wH23]=harmonics(Harmonic2_3,F,net,lf);
        end
    else
        [checkH3,wH3]=harmonics(Harmonic3,F,net,lf);
        if checkH3==1
            [checkH32,wH32]=harmonics(Harmonic3_2,F,net,lf);
        else
            [checkH4,wH32]=harmonics(Harmonic4,F,net,lf);
            if checkH4==0
                [checkH5,wH32]=harmonics(Harmonic5,F,net,lf);
            end
        end
    end
end

% Harmonics and Checks
a=[checkH1 checkH2 checkH3 checkH4 checkH5 checkH22 checkH24 checkH23 checkH32];
b=[ Harmonic1,Harmonic2,Harmonic3,Harmonic4,Harmonic5,Harmonic2_2,Harmonic2_4,Harmonic2_3,Harmonic3_2   ];
b=round(b);
pitch=b.*a; 
wH=[wH1,wH2,wH3,wH4,wH5,wH22,wH24,wH23,wH32];

for i=1:9
    if pitch(i)==0
        pitch(i)=inf;
    end
end

[pitch, loc]=min(pitch);
trig = wH(loc)-21;
pitch = pitch+trig
