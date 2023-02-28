function [ B ] = B_matrix_gen( x,u_x,var_x ) 

[D,M]=size(x);
[W,N]=size(u_x);
    for j=1:N
         for t=1:M             
               s_1=sum(((x(:,t)-u_x(:,j))).^2./(2*var_x(:,j)));
               s_2=(prod(var_x(:,j)));
               B(j,t)=(exp(-s_1)/((2*pi)^(D/2)*sqrt(s_2)));
          end
    end
    B=B';
end