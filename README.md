# Speech-Recognition


# Implementation of Markov's hidden model to detect separate speech in MATLAB

Objective: Identifying and classifying Persian numbers from 0 to 9

10 hidden Markov models for numbers 0 to 9 have been trained using the Baum-Welch algorithm and their coefficients, i.e. A, PI and B parameters, have been estimated.
Each of these models is a hidden left-to-right Markov model with five states. Finally, for each test input signal, the probability of correctness is calculated for each
model using the forward algorithm, and the highest value represents the result.

The speech recognition system consists of three components:
Pre-processing - feature vector extraction - pattern recognition and classification
For example, in the pre-processing step, the noise in the audio signals is removed.

![pre_processing](https://user-images.githubusercontent.com/126339266/221878325-c221f280-6ca2-48d2-aa0c-1695c7dfef21.png)


Input dataset: 100 recorded audio files.
Training data: 80% 
Test data: 20% 
The final accuracy of the model for the test data: 90%

# Click on the link below
To run the model, refer to this link and watch the recorded video file (Persian Language).
https://drive.google.com/drive/folders/1Retrd2ie00YrbGguAo1A0v-HxoCTHUm_?usp=share_link
