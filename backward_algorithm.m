function [ Beta ] = backward_algorithm(PI,A,B,t,j)
[M D]=size(B);  
N=length(PI);
beta(M,:)=1+zeros(1,N);
for x=M-1:-1:t
    for k=1:N            
      beta(x,k) = sum( (beta(x+1,:).*A(k,:) ) .* B(x+1,:)) ;                 
    end
end
Beta = beta(t,j);
end