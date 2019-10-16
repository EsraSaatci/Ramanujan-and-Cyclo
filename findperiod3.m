function [dt_Phat]=findperiod3(Phat,k,lim)

% Detrending Phat

a=floor(length(Phat)/k);

dt_Phat=[];
for i=1:k
A=Phat(1+(i-1)*a:i*a);

% dt_Phat=[dt_Phat detrend(A)]; 

opol = 1; nnt=1:a; % detrend degree and series
[p,s,mu] = polyfit(nnt,A,opol);
f_y = polyval(p,nnt,[],mu);
dt_Phat=[dt_Phat A-f_y];
end


