function sig=PowerSpectrum2WaveVC(log10powerspectrum,yphase)
%sig=InversePowerSpectrum(log10powerspectrum,yphase)
%log10powerspectrum: estimated from deep autoencoder, must be 129*frames,
%must be log10 compressed
%yphase: clean or noisy phase information, must be a matrix as 256*frames
%Xugang Lu @NICT


logpowspectrum             =log(power(10,log10powerspectrum)); %log power spectrum
yphase                     =yphase(1:floor(size(yphase,1)/2)+1,:); %For Odd sample
sig                        =OverlapAddVC(sqrt(exp(logpowspectrum)),yphase);

return;
