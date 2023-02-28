function [ ALFA ] = forward_algorithm(PI,A,B,t,j)
N=length(PI);
alfa(1,:)=PI.*B(1,:);
for x=2:t
    for k=1:N            
      alfa(x,k) = sum(alfa(x-1,:).*(A(:,k))') * B(x,k) ;                 
    end
end
ALFA = alfa(t,j);
end