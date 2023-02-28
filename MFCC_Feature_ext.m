function [MFCC_coeff] = MFCC_Feature_ext(x,fs,M)

%====== framing =======
Tf = 32 ;                                    % the analysis frame duration (ms) 
Tol = 16 ;                                   % the analysis frame shift (ms)
L  = length(x);                              % length of the input speech
frame_duration = round( 1e-3*Tf*fs );        % frame duration (samples) 
OL_duration = round( 1e-3*Tol*fs );          % frame shift (samples)
nofs    = floor((L/OL_duration))-1;
frames  = zeros(nofs, frame_duration);     
for i=1:nofs
    frames(i,:) = x((i-1)*OL_duration+1 : (i-1)*OL_duration+frame_duration);
end
%======== MFCC coeff =================
%------------ FFT ----------------------
NFFT = frame_duration *2;
fft_abs_frames = (abs(fft(frames' , NFFT)))'; 
fft_abs_frames = (fft_abs_frames(:,1:end/2)).^2;
%-------- Mel FilterBank---------------------
fmin      = 25;     % Hz
fmax     = fs/2;  % Hz
NfiltersOfMelBank = 25;

Mel_fb = fbankT(NfiltersOfMelBank,NFFT,fs, fmin, fmax); 

cepstral_log = log10(Mel_fb*fft_abs_frames'); 

ceps         = dct(cepstral_log); 
ceps         = ceps(1:M,:); 
MFCC_coeff   = ceps';

end