function [Log_MFCSpectrum,yphase]=Mel_Spectrum_FromX(x,AmFlag,FrameSize,FrameRate,FFT_SIZE,sr,minfreq,nfilts );
%function Log_MFCSpectrum=Mel_Spectrum_FromFile(fname,AmFlag);
%fname: input file name
%AmFlag=2, Power Spectrum, else Amplitude
%

fbtype   ='htkmel';

[powspectrum,x_seg,yphase]  =Spectrum(x,FrameSize,FrameRate,FFT_SIZE, AmFlag); %For power spectrum extraction

%sr      =16000 ;%Sampling frequency is 8khz
% nfilts  =40; %40 Mel filter bands
%minfreq =120;%minimum frequency is 120 hz
maxfreq =sr/2; %half of sr
MelCoef = MakeMelCoef(sr, nfilts, fbtype, minfreq, maxfreq, 1,FFT_SIZE);
MFCSpectrum=Get_Mel_Spectrum(powspectrum,MelCoef);
%MFCSpectrum1=Get_MaxMel_Spectrum(powspectrum,MelCoef);
%Log_MFCSpectrum1=log10(0.01+MFCSpectrum1); 
Log_MFCSpectrum=log10(eps+MFCSpectrum); 
return;
