% Write a MATLAB program to determine the 
% partial-fraction expansion of the z-transform 
% listed the following G(z) 
% num = [2 , 5 , 9 , 5 , 3] ;
% den = [5 , 45 , 2 , 1 , 1] ;
% |z|>1.2 ;
% and then determine their inverse z-transforms. 
num = [2 , 5 , 9 , 5 , 3] ;
den = [5 , 45 , 2 , 1 , 1] ;
[r , p , k] = residuez(num , den) ; flag = 0 ; for ii = 1:length(k)
    flag = 1 ;
    fprintf(1 , '(%s)*delta[n' , num2str(k(ii))) ;
    if ii > 1
        fprintf(1 , '-%d]' , ii - 1) ;
    else
        fprintf(1 , ']') ;
    end
end
for ii = 1:length(r)
    if flag
        fprintf(1 , '+') ;
    else 
        flag = 1 ;
    end
    fprintf(1 , '(%s)*(%s).^n*u[n]' , num2str(r(ii)) , num2str(p(ii))) ;
end
fprintf(1 , '\n') ;
