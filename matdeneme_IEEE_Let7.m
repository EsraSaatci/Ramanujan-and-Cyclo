%Signal periodic decomposition cyclostationary autocorrelation + 
%shi-wen deng P (energy) periodicty metric used
%working DONT CHANGE 
% SNR
% Monte Carlo
% Signal length
%IEEE signals letter

% 
% close all
clear all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Signals used

% Signal correct periods
T1=27; T2=53; T3=95;
k=3; % number of components in the signal

% Search period limit
Q=100;

snrpl=20; snrps=0.5; snrph=20;sz1=((snrph-snrpl)/snrps)+1;sz1=fix(sz1);
mcph=100; sz2=mcph;
sll=10; sls=1; slh=200; sz3=((slh-sll)/sls)+1;
Phat3=zeros(Q,sz3,sz2,sz1); % Phat3(:,sl,mcp,snrp)
pp=zeros(5,sz3,sz2,sz1); %pp(:,sl,mcp,snrp)

i1=0;
for snrp=snrpl:snrps:snrph
    i1=i1+1;
    for mcp=1:mcph
        i2=0;
        for sl=sll:sls:slh
            i2=i2+1;
            N1=sl; N2=sl; N3=sl;
            n1=0:N1-1; n2=0:N2-1; n3=0:N3-1;
            xrr=cos(2*pi*n1/T1)+cos(2*pi*n2/T2)+cos(2*pi*n3/T3);
            xr = awgn(xrr,snrp);
            xr = repmat(xr,1,1);
            N(i2)=length(xr);
%             figure, plot(xr), grid on
            [Phat2]=calP5(xr,Q,1);
            Phat2=Phat2/max(Phat2);
            
            % Detrending Phat
            dt_Phat2=findperiod3(Phat2,4,0); dt_Phat2(dt_Phat2<0)=0;Phat2=dt_Phat2; 
            
            Phat3(:,i2,mcp,i1)=Phat2;
            [pfvalue pf]=maxk(Phat2,5);
            pp(:,i2,mcp,i1)=pf; % save pf
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plotting
% create x axis by changing variable
xx1=snrpl:snrps:snrph; % if snr change is plotted
xx2=sll:sls:slh; % if length change is plotted

% mean in MC
pplot(:,:,1,:)=mean(pp,3);%pp(:,sl,mcp,snrp)

xx=xx2;
figure, 
scatter(xx,pplot(1,:));hold on,grid on
scatter(xx,pplot(2,:),'r');scatter(xx,pplot(3,:),'g');scatter(xx,pplot(4,:),'k');scatter(xx,pplot(5,:),'m')
plot(xx,repmat(T1,1,length(xx)),'m','lineWidth',2), plot(xx,repmat(T2,1,length(xx)),'--r','lineWidth',2), plot(xx,repmat(T3,1,length(xx)),':k','lineWidth',2)
