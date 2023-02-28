function [ ALFA_hat,CC ] = forward_algorithm_sc(PI,A,B,t,j)

N=length(PI);
alfa(1,:) = PI.*B(1,:);
alfa2h(1,:)= alfa(1,:);
C(1) = 1/sum(alfa(1,:));
alfah(1,:)=C(1)*alfa(1,:);
for x=2:t
    for k=1:N
    alfa2h(x,k)=sum(alfah(x-1,:).*(A(:,k))') * B(x,k);
    end
    C(x)=1/sum(alfa2h(x,:));
    alfah(x,:)=C(x)*alfa2h(x,:);
end
 ALFA_hat = alfah(t,j);
 CC = C(t);
end