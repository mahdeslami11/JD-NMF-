function MFCSpectrum=Get_Mel_Spectrum(PowerSpectrum,MelFilt);
%function MFCSpectrum=Get_Mel_Spectrum(PowerSpectrum,MelFilt);
%PowerSpectrum: Input power spectrum
%MelFilt: The triangle filters with Mel scale
%TempPowerSpectrum=PowerSpectrum(Lower:Higher,:); %Adjust the dimension for MelFilt
%Xugang Lu, @ATR/NICT
%May, 15, 2009

len1=size(MelFilt,2);
len2=size(PowerSpectrum,1);
if len2~=len1
    TempPowerSpectrum=PowerSpectrum(len2-len1:len2-1,:); %Adjust the dimension for MelFilt
    MFCSpectrum=MelFilt*TempPowerSpectrum;
else
    MFCSpectrum=MelFilt*PowerSpectrum;
end

return;
