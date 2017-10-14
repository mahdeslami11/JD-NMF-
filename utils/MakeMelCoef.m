function wts = MakeMelCoef(sr, nfilts, fbtype, minfreq, maxfreq, bwidth,FFT_SIZE)
%Make Mel coefficient as global coefficients


nfft = (FFT_SIZE/2-1)*2;

%BARK,MEL, HTKMEL, FCMEL
nfft = (FFT_SIZE/2-1)*2;
if strcmp(fbtype, 'bark')
    wts = fft2barkmx(nfft, sr, nfilts, bwidth, minfreq, maxfreq);
elseif strcmp(fbtype, 'mel')
    wts = fft2melmx(nfft, sr, nfilts, bwidth, minfreq, maxfreq);
elseif strcmp(fbtype, 'htkmel')
    wts = fft2melmx(nfft, sr, nfilts, bwidth, minfreq, maxfreq, 1, 1);
elseif strcmp(fbtype, 'fcmel')
    wts = fft2melmx(nfft, sr, nfilts, bwidth, minfreq, maxfreq, 1, 0);
else
    disp(['fbtype ', fbtype, ' not recognized']);
    error;
end

wts = wts(:, 1:FFT_SIZE/2);


