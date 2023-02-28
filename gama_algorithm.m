function [ GAMA ] = gama_algorithm(PI,A,B,t,i ) 
N=length(PI);
alfa=forward_algorithm(PI,A,B,t,i);
beta=backward_algorithm(PI,A,B,t,i);

Ptot = 0;
for m=1:N
Ptot= Ptot + (forward_algorithm(PI,A,B,t,m)*backward_algorithm(PI,A,B,t,m));
end
GAMA=alfa*beta/Ptot;

end