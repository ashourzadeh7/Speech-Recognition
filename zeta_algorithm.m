function [ ZETA ] = zeta_algorithm(PI,A,B,t,i,j)

N=length(PI);
num=forward_algorithm(PI,A,B,t,i)*A(i,j)*B(t+1,j)*backward_algorithm(PI,A,B,t+1,j);
Ptot=0;
for m=1:N
Ptot= Ptot + (forward_algorithm(PI,A,B,t,m)*backward_algorithm(PI,A,B,t,m));
end
ZETA=num/Ptot;
end
