figure
w = -5:0.1:5;
X=zeros(1,length(w))
X(24)=1;
X(74)=1;
h = stem(w,X,'k^');
set(h,'MarkerFaceColor','black')
%set(h(2),'MarkerFaceColor','red','Marker','square')