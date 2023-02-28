function [Result , Acc] = Test_all(Test_matrix)

% Test_matrix = ["Test_01.wav"
%     "Test_02.wav"
%     "Test_03.wav"
%     "Test_04.wav"
%     "Test_05.wav"
%     "Test_06.wav"
%     "Test_07.wav"
%     "Test_08.wav"
%     "Test_09.wav"
%     "Test_10.wav"
%     "Test_11.wav"
%     "Test_12.wav"
%     "Test_13.wav"
%     "Test_14.wav"
%     "Test_15.wav"
%     "Test_16.wav"
%     "Test_17.wav"
%     "Test_18.wav"
%     "Test_19.wav"
%     "Test_20.wav"];

Target = ["ZERO!!" ; "ZERO!!" ; "ONE!!" ; "ONE!!" ; "TWO!!" ; "TWO!!" ; "THREE!!" ; "THREE!!" ; "FOUR!!" ; "FOUR!!" 
    ; "FIVE!!" ; "FIVE!!" ; "SIX!!" ; "SIX!!" ; "SEVEN!!" ; "SEVEN!!" ; "EIGHT!!" ; "EIGHT!!" ; "NINE!!" ; "NINE!!"];

S = 0;

for i=1:size(Test_matrix,1)
     Result(i) = IWR( Test_matrix(i) );
    if (Result(i) == Target(i))
        S = S+1;
    end  
end

Acc = (S/size(Test_matrix,1))*100;
% Result;

end

