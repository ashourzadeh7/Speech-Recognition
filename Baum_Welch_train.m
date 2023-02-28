function [ A_n,PII_n,U_X_n,VAR_X_n ] = Baum_Welch_train( A_init, PII_init, Train_data,fs )  

%   A_init= [0.5 0.5  0 0 0 ;0 .5 0.5  0 0 ; 0 0 .5 .5 0 ;0 0 0  0.5 0.5 ; 0 0 0 0  1  ]; 
%   PII_init=[1 0 0 0 0];                                        
  N= length(PII_init);
  L= length(Train_data);
  D = 13;
%%%%%%%%%%%%% PII training %%%%%%%%%%%%%%%%%%%%%  
 for i=1:N         
        for h=1:L   
         input_sound=Train_data{h};            
         [x] = (MFCC_Feature_ext (input_sound, fs,D));
         x=x';
         [ u_x,var_x ] = var_mean_calc( x,N );
         B = B_matrix_gen( x,u_x,var_x );               
         G(h)=gama_algorithm(PII_init,A_init,B,1,i);
        end
    PII_n(i)=sum(G)/L;        
 end   
%%%%%%%%%%%%%%% A training %%%%%%%%%%%%%%%%%%% 
    G=0; Z=0;
    for i=1:N
        for j=1:N
            for h=1:L   
         input_sound=Train_data{h};
         [x] = (MFCC_Feature_ext (input_sound, fs,13));
         x=x';      
         [ u_x,var_x ] = var_mean_calc( x,N );
         B = B_matrix_gen( x,u_x,var_x ); 
         [I,T]=size(x);
                 for t=1:T-1
         Z=Z+zeta_algorithm(PII_n,A_init,B,t,i,j);       
         G=G+gama_algorithm(PII_n,A_init,B,t,i  );
                 end
            end
            A_n(i,j)=Z/G; 
            Z=0;G=0;
        end
    end  
    %%%%%%%%%%%%%% U training %%%%%%%%%%%%%%%%%%%% 
G=zeros(D,1);Z=0;
for j=1:N   
    for h=1:L
          input_sound=Train_data{h};
          [x] = (MFCC_Feature_ext (input_sound, fs,13));
          x=x';             
          [ u_x,var_x ] = var_mean_calc( x,N );
          B = B_matrix_gen( x,u_x,var_x );
          [I,T]=size(x);
           for t=1:T
           G=G+(  gama_algorithm( PII_n,A_n,B,t,j )*x(:,t) );           
           Z=Z+   gama_algorithm( PII_n,A_n,B,t,j );                  
           end
    end
     U_X_n(:, j ) =G / Z;
     G=zeros(D,1);Z=0;   
end

   %%%%%%%%%%%%%%%%%% VAR Training %%%%%%%%%%%%%%%%%%%
G=zeros(D,D);Z=0;       
for j=1:N
    for h=1:L  
        input_sound=Train_data{h};        
        [x] = (MFCC_Feature_ext (input_sound, fs,13));
        x=x';
        [ u_x,var_x ] = var_mean_calc( x,N );
        B = B_matrix_gen( x,u_x,var_x );
        [I,T]=size(x);
        for t=1:T
          G=G+(gama_algorithm(PII_n,A_n,B,t,j)*(((x(:,t)-U_X_n(:,j)))*(x(:,t)-U_X_n(:,j))'));                             
          Z=Z +gama_algorithm(PII_n,A_n,B,t,j );       
        end
    end  
         VAR_X_n(:,j)= diag(G) / Z;
         G=zeros(D,D);Z=0;
end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end