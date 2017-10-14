function [spec,wts,iwts] = MelSpectrum2PowerSpectrum(MelSpectrum, sr, nfft, fbtype, minfreq, maxfreq, sumpower, bwidth)
%From Mel spectrum to estimate the FFT power spectrum
%The Mel spectrum is not log compressed
%Must addpath /data/pansrt9/users/xlu/work/DBNCode/crbm_audio/code/
%Xugang Lu @NICT
%Feb.8, 2013

% if nargin < %  sr = 16000;     end 
if nargin < 3;  nfft = 512;     end
if nargin < 4;  fbtype = 'bark';  end
% if nargin < % minfreq = 0;    end
if nargin < 6;  maxfreq = sr/2; end
if nargin < 7;  sumpower = 1;   end
if nargin < 8;  bwidth = 1.0;   end

[nfilts,nframes] = size(MelSpectrum);

if strcmp(fbtype, 'bark')
  wts = fft2barkmx(nfft, sr, nfilts, bwidth, minfreq, maxfreq);
elseif strcmp(fbtype, 'mel')
  wts = fft2melmx(nfft, sr, nfilts, bwidth, minfreq, maxfreq);
elseif strcmp(fbtype, 'htkmel')
  wts = fft2melmx(nfft, sr, nfilts, bwidth, minfreq, maxfreq, 1, 1);
elseif strcmp(fbtype, 'fcmel')
  wts = fft2melmx(nfft, sr, nfilts, bwidth, minfreq, maxfreq, 1);
else
  disp(['fbtype ', fbtype, ' not recognized']);
  error;
end

% Cut off 2nd half
wts = wts(:,1:((nfft/2)+1));

% Just transpose, fix up 
ww = wts'*wts;
iwts = wts'./(repmat(max(mean(diag(ww))/100, sum(ww))',1,nfilts));
% Apply weights
if (sumpower)
  spec = iwts * MelSpectrum;
else
  spec = (iwts * sqrt(MelSpectrum)).^2;
end
return