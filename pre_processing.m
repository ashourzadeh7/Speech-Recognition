function [x,x_denoise_vad,fs] = pre_processing(filename)
[x,fs]=audioread(filename);
% plot(x)
%%%%%%%%%%% pre emphasis filter %%%%%%%%%%%%%%%%
 num=[1 -0.95];
 denum = 1;
 x_pre_emph = filter(num,denum,x);
%%%%%%%%%%%%%%%%%%%%framing %%%%%%%%%%%%%%%%%%%%
Tf = 32 ;                                    % the analysis frame duration (ms) 
Tol = 16 ;                                   % the analysis frame shift (ms)
L  = length(x_pre_emph);                     % length of the input speech
frame_duration = round( 1e-3*Tf*fs );        % frame duration (samples) 
OL_duration = round( 1e-3*Tol*fs );          % frame shift (samples)
%------------------------------------
nofs    = floor((L/OL_duration))-1;
frames  = zeros(nofs, frame_duration);     
for i=1:nofs
    frames(i,:) = x_pre_emph((i-1)*OL_duration+1 : (i-1)*OL_duration+frame_duration);
end
%%%%%%%%%%%%%%%%% windowing %%%%%%%%%%%%%%%%%%%%%%%%%%
 w=hamming(frame_duration);  % hann - blackman - bartlett
 frames_w = frames.*w';
%%%%%%%%%%%%%%%%%%% denoising %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
frames_w_noise = frames_w(1,:);       % noise frame
frames_w_noise_F = (abs(fft(frames_w_noise)));
treshold = 10 * mean(frames_w_noise_F);
frames_w_F = fft(frames_w');
frames_w_denoise = zeros (nofs,frame_duration);
for i=1:nofs     
       frames_w_F_abs = abs(frames_w_F(:,i));
       K=(frames_w_F_abs > treshold);
       frames_w_F2= K .*frames_w_F(:,i) ;
       frames_w_denoise(i,:) = (ifft(frames_w_F2))';
end
 x_denoise= frames_w_denoise(1,:);
for i=1:nofs-1
    x_denoise=[x_denoise zeros(1,OL_duration)];
    x_denoise(i*OL_duration+1:end) = x_denoise(i*OL_duration+1:end) + frames_w_denoise(i+1,:);
end
x_denoise = x_denoise';
%--------------------------------------
%%%%%%%%%%%%%%%%%%%% V A D %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 1: nofs
           energy(i) = mean(frames_w_denoise(i,:).^2) ;
    end
         vad_Tr = zeros(1,nofs);
	     vad    = zeros(1,nofs);
         vad_Tr(1) = 0.5* energy(1);
	 
    for i =2 : nofs 
            if energy(i) > 4 * vad_Tr(i-1)
                vad(i) = 1;
                vad_Tr(i) =  vad_Tr(i-1) ;
            else               
                vad(i) = 0;
                vad_Tr(i) = 0.5 * vad_Tr(i-1) + 0.5 * energy(i);
            end                           
    end
      x_denoise_vad=[];
     for i=1:length(vad)
        if vad(i)==1
            x_denoise_vad = [x_denoise_vad ; x_denoise(i*OL_duration:(i+1)*OL_duration)];
        end
     end
   %--------------------------------
%      figure
%      plot(x_denoise_vad)

end