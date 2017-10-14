% Get the result of DTW
function [AfterDTW_TargetWavFile,AfterDTW_SourceWavFile]=Implement_DTW(TargetList,SourceList)
nfft=256;
sr=16000;        % 16k Hz, sampling rate
minfreq=120;
maxfreq=sr/2; 
sumpower=1;
bwidth=1;
FeaDim=80;


%%% Target Mel spectrum extraction
TargetWavFile=GetFileNames(TargetList);
filenum     =size(TargetWavFile,2);
%disp('Converting target waveform to Mel spectrum...')
for i=1:filenum
    [tp,FS]=wavread(TargetWavFile{i}); %TargetWavFile{i} is the wav file.
    if size(tp,2)==2
        x=(tp(:,1)+tp(:,2))/2;
    else
        x=tp;
    end
    [TargetMFCSpectrum{i},yphase1{i}]=Mel_Spectrum_FromX(x*1000,2,256,128,256,FS,120,FeaDim);
    clear tp
end



%%% Source Mel spectrum extraction
SourceWavFile=GetFileNames(SourceList);
%disp('Converting source waveform to Mel spectrum...')
for i=1:filenum
    [tp,FS]=wavread(SourceWavFile{i}); %SourceWavFile{i} is the source wav file corresponding to the TargetWavFile{i}.
    if size(tp,2)==2
        x=(tp(:,1)+tp(:,2))/2;
    else
        x=tp;
    end
    [SourceMFCSpectrum{i},yphase2{i}]=Mel_Spectrum_FromX(x*1000,2,256,128,256,FS,120,FeaDim);
    clear tp
end

% DTW
disp('DTW...')
for i=1:length(SourceMFCSpectrum)
    Targetspectrum=TargetMFCSpectrum{i};y1=yphase1{i};
    Sourcespectrum=SourceMFCSpectrum{i};y2=yphase2{i};    
    
    path= DTW(Sourcespectrum,Targetspectrum);
    %%%%%%%%%%%%%%%%%%%%%%%%  remove repaeted frames
    p1=path(1,:); d1=diff(p1); z1=find(d1==0);
    p2=path(2,:); d2=diff(p2); z2=find(d2==0);
    path(:,[z1,z2])=[];
    %%%%%%%%%%%%%%%%%%%%%%%%
    
    SourceMFCSpectrum{i}=[];  yphase2{i}=[];
    SourceMFCSpectrum{i}=Sourcespectrum(:,path(1,:)); yphase2{i}=y2(:,path(1,:));
    TargetMFCSpectrum{i}=[];  yphase1{i}=[];
    TargetMFCSpectrum{i}=Targetspectrum(:,path(2,:)); yphase1{i}=y1(:,path(2,:));
    
    clear Targetspectrum Sourcespectrum
end


% F domain -> T domain
AfterDTW_TargetWavFile=cell(filenum,1);
AfterDTW_SourceWavFile=cell(filenum,1);
for i=1:filenum
    MelSpec             =power(10,SourceMFCSpectrum{i});
    [spec,wts,iwts]     =MelSpectrum2PowerSpectrum(MelSpec, sr, nfft, 'htkmel', minfreq, maxfreq, sumpower, bwidth); % for 16KHz
    log10powerspectrum  =log10(spec);
    sig=PowerSpectrum2WaveVC(log10powerspectrum,yphase2{i});
    siga=sig/max(abs(sig));  
    source_name=strcat('.\After_DTW\S_DTW_sentence_',num2str(i),'.wav');
    wavwrite(siga,sr,source_name);

    MelSpec             =power(10,TargetMFCSpectrum{i});
    [spec,wts,iwts]     =MelSpectrum2PowerSpectrum(MelSpec, sr, nfft, 'htkmel', minfreq, maxfreq, sumpower, bwidth); % for 16KHz
    log10powerspectrum  =log10(spec);
    sig=PowerSpectrum2WaveVC(log10powerspectrum,yphase1{i});
    siga=sig/max(abs(sig));
    target_name=strcat('.\After_DTW\T_DTW_sentence_',num2str(i),'.wav');
    wavwrite(siga,sr,target_name);
    
    AfterDTW_TargetWavFile{i}=target_name;
    AfterDTW_SourceWavFile{i}=source_name;
end
end

