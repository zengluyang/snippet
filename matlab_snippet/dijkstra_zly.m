function [path,distance]=dijkstra_zly(D)

D=[0,1,4,inf,inf,inf;
    1,0,2,7,5,inf;
    4,2,0,inf,1,inf;
    inf,7,inf,0,3,2;
    inf,5,1,3,0,6;
    inf,inf,inf,2,6,0]
%step1 initialize
n=length(D);
d(1)=0;
P=[1];
T=2:n;
for i=1:length(T)
    d(T(i))=D(1,T(i));
end
while P(length(P))~=6
    
    %step2 find the smallest
    minD=inf;
    for i=1:length(T)
        if d(T(i))<minD;
            minD=d(T(i));
            k=T(i);
            del=i;
        end
    end
    T(del)=0;
    P=[P,k];
    [row,col,T]=find(T);

    %step3 change 
    for i=1:length(T)
        if d(k)+D(k,T(i))<d(T(i))
            d(T(i))=d(k)+D(k,T(i));
        end
    end
end
path=P;
distance=d(length(P));
return;


