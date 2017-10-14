function sig=OverlapAdd(X,yphase)
%Xugang Lu @NICT
%sig=OverlapAdd(X,A);
%sig is the signal reconstructed signal from its spectrogram. X is a matrix
%with each column being the fft of a segment of signal. A is the phase
%angle of the spectrum which should have the same dimension as X. if it is
%not given the phase angle of X is used which in the case of real values is
%zero (assuming that its the magnitude). 

windowLen = 256;
ShiftLen  = 128;

[FreqRes FrameNum]=size(X);

Spec=X.*exp(j*yphase);

if mod(windowLen,2) %if FreqResol is odd
    Spec=[Spec;flipud(conj(Spec(2:end,:)))];
else
    Spec=[Spec;flipud(conj(Spec(2:end-1,:)))];        
end
sig=zeros((FrameNum-1)*ShiftLen+windowLen,1);
for i=1:FrameNum
    start=(i-1)*ShiftLen+1;    
    spec=Spec(:,i);
    sig(start:start+windowLen-1)=sig(start:start+windowLen-1)+real(ifft(spec,windowLen));       
end
return