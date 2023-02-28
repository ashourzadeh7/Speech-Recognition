function fb_weights = fbankT(nbFilters,fftSize,samplingRate,minFreq,maxFreq)
 
 % interesting frequencies are lineary spaced in Mel scale
 hz2mel = @( hz )( 1127*log(1+hz/700) );     % Hertz to mel warping function
 mel2hz = @( mel )( 700*exp(mel/1127)-700 ); % mel to Hertz warping function
 freqs=mel2hz (linspace(hz2mel(minFreq),hz2mel(maxFreq),nbFilters+2));


 % lower, center, and upper band edges are consecutive interesting freqs
 lower = freqs(1:nbFilters);
 center = freqs(2:nbFilters+1);
 upper = freqs(3:nbFilters+2);

 % reserving memory for the transformation matrix
 fb_weights = zeros(nbFilters,fftSize/2);

 % assuming a triangular weighting function.
 triangleHeight =ones(1,nbFilters);    % height is constant = 1

 % frequency bins
 fftFreqs = (0:fftSize/2-1)/fftSize*samplingRate;

 % figure out each frequencies contribution
 for chan=1:nbFilters
	fb_weights(chan,:) =... 
  (fftFreqs > lower(chan) & fftFreqs <= center(chan)).* ...
   triangleHeight(chan).*(fftFreqs-lower(chan))/(center(chan)-lower(chan)) + ...
  (fftFreqs > center(chan) & fftFreqs < upper(chan)).* ...
   triangleHeight(chan).*(upper(chan)-fftFreqs)/(upper(chan)-center(chan));
end


