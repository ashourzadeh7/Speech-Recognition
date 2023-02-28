function [ u_x,var_x] = var_mean_calc( x , N )
[D,M]=size(x);  % M : num of observations  
u_x=zeros(D,N);
var_x=zeros(D,N);
k=floor(M/N);    
    for i=1:N-1
            u_x(:,i)= mean( x(:,k*(i-1)+1:i*k)' )';
          var_x(:,i)=  var(  x(:,k*(i-1)+1:i*k)')';
    end
          i=N;
            u_x(:,i)= mean( x(:,k*(i-1)+1:end)' )';
          var_x(:,i)=  var( x(:,k*(i-1)+1:end)' )';
end