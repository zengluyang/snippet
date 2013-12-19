function S=getUncertaintyFromArray(a)
S=0;
avg=sum(a)/length(a);
for i = 1:length(a)
    S=S+(a(i)-avg).^2;
end
S=sqrt( S/( length(a)*(length(a)-1) ) );
return;