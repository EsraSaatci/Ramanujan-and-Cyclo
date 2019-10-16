
function [Phat2]=calP5(x,Q,kk)

%Signal periodic decomposition cyclostationary autocorrelation
%06.10.2019 calP modified for IEEElettres
%with k and khat
%and shi-wen deng P (energy) periodicty metric
%working must be sum in khat line 45 and k=0 for shi-wen and 
%khat=0,k=0 for cyclo

N=length(x);
k=kk-1;

for m=kk:Q
    Mq=floor(N/m);
    Rhattt=zeros(Mq,m-k);
    mhattt=zeros(Mq,m-k);
        
    for khat=0:Mq-1
        for r=0:m-1-k  
            Rhat=0;
            mhat=0;
            for i=0:Mq-1-khat
                Rhat=Rhat+(x((i*m)+r+1)*x((i*m)+r+k+(khat*m)+1));
                mhat=mhat+x((i*m)+r+1);
            end
            Rhatt(r+1)=Rhat;%/Mq;
            mhatt(r+1)=mhat/Mq;
        end
        Rhattt(khat+1,:)=Rhatt;
        mhattt(khat+1,:)=mhatt;

    end
    
%     %%%%%to manage k%%%%%%%%%%%%%%%%%%%%%%%
% not used because k=0 and Rhattt matrix is changed
%     NewR=[Rhattt Rhattt];
%     NewR2=zeros(m,m);
%     for i=1:m
%         for ii=1:m
%            NewR2(ii,i)= NewR(ii,ii+i-1);
%         end
%     end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Rhatttsum=sum(Rhattt,2); %sum in khat
%     Rhatttsum=Rhattt(1,:); %1 khat=0, 2 khat=1, 3 khat=2
    
    v1=sum(Rhatttsum)/m; %sum in r
    v2(m)=sum((Rhatttsum-v1).^2)/m;
    
    %%%%%%%%shi-wen deng P (energy) periodicty metric
    cphi(m)=sum(Rhatttsum);%/m;
      
end 
% 
for q=2:Q
    divi=findd_d(q);
    Phat(q)=((1+(q/N))/(2*q))*(q*cphi(q)-divi*cphi(divi)');
end  

% Phat2=v2; %only cyclo
Phat2=Phat; %cyclo+period metric
Phat2(Phat2<0)=0;


