%Signal periodic decomposition cyclostationary autocorrelation + 
%shi-wen deng P (energy) periodicty metric used
%working DONT CHANGE 
% SNR
% Monte Carlo
% Signal length
%IEEE signals letter
% real signal

% 
% close all
clear all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Signals used
load('Untitled1') 
xr=data(17250:25000)'; xr=xr-mean(xr); %xr = downsample(xr,10); %use downsampking
N=length(xr);
figure, plot(xr), grid on, xlabel('Points'), ylabel('Amplitude')

% Search period limit
Q=1000;
[Phat2]=calP5(xr,Q,1);
Phat2=Phat2/max(Phat2);

% Detrending Phat
dt_Phat2=findperiod3(Phat2,4,0); dt_Phat2(dt_Phat2<0)=0;Phat2=dt_Phat2;
figure, stem(Phat2), grid on,


[pfvalue pf]=maxk(Phat2,10);

% Additionly compute FFT
Nfft=1024;
Y=abs(fft(xr,Nfft));
figure, stem(Y(1:Nfft/2)), grid on, xlabel('DFT Points'), ylabel('Amplitude')


A1=[2 418 648 1071 1306 1773];  %Untitled1 17250:25000
A2=[4941 5339 5771]; 
A3=[6168 6561];
A4=[6861 7000 7170];

Per=[diff(A1) diff(A2) diff(A3) diff(A4)]

pf
