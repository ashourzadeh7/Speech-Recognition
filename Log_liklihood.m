function [ P_total_log] = Log_liklihood( PI,A,B ) 
T=size(B,1);
for h=1:T  
[ F_hat(h),C(h)  ] = forward_algorithm_sc(PI,A,B,h,2);
end
P_total_log = - sum(log10(C));

end