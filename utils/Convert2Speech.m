function originalSpeech=Convert2Speech(spectrum,theta,Srate,Nframes,residuepoint)
len=floor(20*Srate/1000); % Frame size in samples
if rem(len,2)==1, len=len+1; end;
PERC=50; % window overlap in percent of frame size
len1=floor(len*PERC/100);
len2=len-len1; 
win=hamming(len); %tukey(len,PERC);  % define window
winGain=len2/sum(win); % normalization gain for overlap+add with 50% overlap
nFFT=2*2^nextpow2(len);
x_old=zeros(len1,1);
xfinal=zeros(Nframes*len2,1);
%spectrum(nFFT/2+2:nFFT,:)=flipud(spectrum(2:nFFT/2,:));
new_speech=real(ifft(spectrum.*exp(j*theta)));
%new_speech_len=new_speech(1:len,:);
k=1;
for cc=1:Nframes
    ind_frame=new_speech(:,cc);
    xfinal(k:k+len2-1)=x_old+ind_frame(1:len1);
    x_old=ind_frame(1+len1:len);
    k=k+len2;
end
originalSpeech=[winGain*xfinal;residuepoint];

