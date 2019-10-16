function divi=findd_d(i)

if i==2
    s=1;
else
    s=1:i-1;
end

divi=[];

for j=1:length(s)
    if mod(i,s(j))==0
        divi=[divi s(j)];
    end
end

%divi=[divi i]; %for shi-wen deng coment this for vaidyanathan uncomment

