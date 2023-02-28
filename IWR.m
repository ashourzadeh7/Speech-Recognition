function [ answer ] = IWR( test_sound )
 
load('landa0.mat'); % HMM model for "zero"
load('landa1.mat'); % HMM model for "one"
load('landa2.mat'); % HMM model for "two"
load('landa3.mat'); % HMM model for "three"
load('landa4.mat'); % HMM model for "four"
load('landa5.mat'); % HMM model for "five"
load('landa6.mat'); % HMM model for "six"
load('landa7.mat'); % HMM model for "seven"
load('landa8.mat'); % HMM model for "eight"
load('landa9.mat'); % HMM model for "nine"
%---------------------------------------
[y,x_denoise_vad,fs] = pre_processing(test_sound);
[MFCC_coeff] = MFCC_Feature_ext(x_denoise_vad,fs,13);
MFCC_coeff=MFCC_coeff';
%---------------------------------------
    B = B_matrix_gen( MFCC_coeff,landa0{3},landa0{4} );
    P_landa0  = Log_liklihood( landa0{1},landa0{2},B );
    %---------------------------------------
    B = B_matrix_gen( MFCC_coeff,landa1{3},landa1{4} );
    P_landa1  = Log_liklihood( landa1{1},landa1{2},B );
    %---------------------------------------
    B = B_matrix_gen( MFCC_coeff,landa2{3},landa2{4} );
    P_landa2  = Log_liklihood( landa2{1},landa2{2},B );
    %---------------------------------------
    B = B_matrix_gen( MFCC_coeff,landa3{3},landa3{4} );
    P_landa3  = Log_liklihood( landa3{1},landa3{2},B );
    %---------------------------------------
    B = B_matrix_gen( MFCC_coeff,landa4{3},landa4{4} );
    P_landa4  = Log_liklihood( landa4{1},landa4{2},B );
    %---------------------------------------
    B = B_matrix_gen( MFCC_coeff,landa5{3},landa5{4} );
    P_landa5  = Log_liklihood( landa5{1},landa5{2},B );
    %---------------------------------------
    B = B_matrix_gen( MFCC_coeff,landa6{3},landa6{4} );
    P_landa6  = Log_liklihood( landa6{1},landa6{2},B );
    %---------------------------------------
    B = B_matrix_gen( MFCC_coeff,landa7{3},landa7{4} );
    P_landa7  = Log_liklihood( landa7{1},landa7{2},B );
    %---------------------------------------
    B = B_matrix_gen( MFCC_coeff,landa8{3},landa8{4} );
    P_landa8  = Log_liklihood( landa8{1},landa8{2},B );
    %---------------------------------------
    B = B_matrix_gen( MFCC_coeff,landa9{3},landa9{4} );
    P_landa9  = Log_liklihood( landa9{1},landa9{2},B );
%---------------------------------------
    
Numbers = ["ZERO!!" ; "ONE!!" ; "TWO!!" ; "THREE!!" ; "FOUR!!" ; "FIVE!!" ; "SIX!!" ; "SEVEN!!" ; "EIGHT!!" ; "NINE!!"];
% N1 = [0;1;2;3;4;5;6;7;8;9];

[M I] = max([P_landa0 P_landa1 P_landa2 P_landa3 P_landa4 P_landa5 P_landa6 P_landa7 P_landa8 P_landa9]);

answer = Numbers(I);

end
