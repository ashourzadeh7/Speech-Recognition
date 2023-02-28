# Speech-Recognition


# Implementation of Markov's hidden model to detect separate speech in MATLAB

Objective: Identifying and classifying Persian numbers from 0 to 9

10 hidden Markov models for numbers 0 to 9 have been trained using the Baum-Welch algorithm and their coefficients, i.e. A, PI and B parameters, have been estimated.
Each of these models is a hidden left-to-right Markov model with five states. Finally, for each test input signal, the probability of correctness is calculated for each
model using the forward algorithm, and the highest value represents the result.



Input dataset: 100 recorded audio files
Training data: 80 percent
Test data: 20 percent
The final accuracy of the model for the test data: 90%

![Screenshot (517)](https://user-images.githubusercontent.com/126339266/221876440-7acebc75-b555-411f-9de2-06be25c5f4f7.png)
