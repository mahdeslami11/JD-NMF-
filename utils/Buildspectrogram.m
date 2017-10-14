function [abs_spectrum,phse_spectrum,Nframes,resdiuePoint]=Buildspectrogram(x,Srate)

len=floor(20*Srate/1000); % Frame size in samples
if rem(len,2)==1, len=len+1; end;
PERC=50; % window overlap in percent of frame size
len1=floor(len*PERC/100);
len2=len-len1; 
win=hamming(len); %tukey(len,PERC);  % define window

nFFT=2*2^nextpow2(len);
%fft_vec_size=floor(nFFT/2)+1;
Nframes=floor(length(x)/len2)-1;
spectrgoram=zeros(nFFT,Nframes);
theta=zeros(nFFT,Nframes);
k=1;
for n=1:Nframes    
   insign=win.*x(k:k+len-1);     %Windowing  
   spec=fft(insign,nFFT);     %compute fourier transform of a frame
   abs_spec=abs(spec); % compute the magnitude
   spectrgoram(:,n)=abs_spec;
   theta(:,n)=phase(spec);
   k=k+len2;
   if n==Nframes
      resdiuePoint=x(k:length(x));
   end
end
abs_spectrum=spectrgoram;
phse_spectrum=theta;