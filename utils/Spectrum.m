function [Spectrum,x_seg,yphase] = Spectrum(y,FrameLength,FrameRate,FFT_SIZE, flag);
%function [Spectrum,En] = Spectrum(y,FrameLength,FrameRate,FFT_SIZE,flag);
%y: input wave data
%FrameLength: frame window length (256)
%FrameRate: frame shift (128)
%FFT_SIZE: fft size (256)
%If flag==2, power spectrum, 1 Amplitude, 0 raw fft spectrum

%Xugang Lu
%May 15, 2009, @ATR/NICT

Len      =length(y);
ncols    =fix((Len-FrameLength)/FrameRate);
fftspectrum       =zeros(FFT_SIZE,ncols);
Spectrum =zeros(FFT_SIZE/2+1,ncols); %For Odd sample
En       =zeros(1,ncols);
wind     =hamming(FrameLength);
%wind      =1;
i        =1;
for t = 1:FrameRate:Len-FrameLength;
    x_seg(:,i)          = wind.*y(t:(t+FrameLength-1));
    fftspectrum(:,i)    = fft(x_seg(:,i),FFT_SIZE);
    yphase(:,i)         =angle(fftspectrum(:,i));    
    Spectrum(:,i)       = abs(fftspectrum(1:FFT_SIZE/2+1,i)); %For Odd sample       
    i                   = i+1;
end;
if flag==2
    Spectrum  =Spectrum.^2;
elseif flag==1
    Spectrum  =Spectrum;
else
    Spectrum =fftspectrum(1:FFT_SIZE/2+1,:); %For Odd sample    
end

return;