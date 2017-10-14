%%%% JDNMF %%%%

%--------------------------------------------------------------------------
% This code is used for training Joint dictionary by NMF with an
% application in voice conversion. But the idea can be used in other
% applications where the two dictionaries have to be aligned.
% 
% Usage: 
%        
% 
% Citation: 
%       S. W. Fu, P. C. Li, Y. H. Lai, C. C. Yang, L. C. Hsieh, and Y. Tsao, ¡§Joint dictionary
%       learning-based non-negative matrix factorization for voice conversion to improve
%       speech intelligibility after oral surgery,¡¨IEEE Transactions on Biomedical
%       Engineering, 2016.
% 
% Contact:
%        Szu-Wei Fu
%        jasonfu@citi.sinica.edu.tw
%        Academia Sinica, Taipei, Taiwan
% @author: Jason
%--------------------------------------------------------------------------
warning off;
clear;close all;home
tic;

%%% These numbers are very important for the output quality, and the optimal settings may depend on your task.

alg=2;                % alg=1 is optimized with mse criterion, alg=2 is optimized with KL-divergernce criterion
iter_num=25;          % iteration number for training JDNMF
iter_num2=25;         % iteration number for conversion
number_bases=100;      %  number of bases


TargetList     ='Gittarget.list';  
SourceList     ='Gitsource.list';      
SourceTestList ='Gitsource_Test.list'; 

%%%%%%%%%% Alignment by DTW
disp('Aligning source and target speech by DTW...')
[AfterDTW_TargetWavFile, AfterDTW_SourceWavFile]=Implement_DTW(TargetList,SourceList);
filenum     =size(AfterDTW_TargetWavFile,1);
		
%%%%%%%%%%  Get St and Ss
disp('Converting target waveform to spectrogram St...')
St=[];
for i=1:filenum
    [tp,FS]=wavread(AfterDTW_TargetWavFile{i}); %TargetWavFile{i} is the wav file.
    [absSp,phaseSp,Spframes,resph]=Buildspectrogram(tp,FS);
    St=[St,absSp];
end
rr=size(absSp,1);
all_r=floor(rr/2)+1;
St=St(1:all_r,:);  
St=multiframes2(St); % Section III-C in the paper for Contextual Information

disp('Converting source waveform to spectrogram Ss...')
Ss=[];
for i=1:filenum
    [tp,FS]=wavread(AfterDTW_SourceWavFile{i}); 
    [absSp,phaseSp,Spframes,resph]=Buildspectrogram(tp,FS);   % Using STRAIGHT features may obtain better performance !!    http://www.wakayama-u.ac.jp/~kawahara/index-e.html
    Ss=[Ss,absSp];
end
Ss=Ss(1:all_r,:); 
Ss=multiframes2(Ss); % Section III-C in the paper for Contextual Information

%%%%%%%%%%%%%%%%%%%%% Training the joint dictionary %%%%%%%%%%%%%%%%%%%%%%%
S=[St;Ss];      % Concatenation. Please see Fig.3 and e.q.(10) in the paper.
disp('JD-NMF training (finding (Ws,Wt) and H)...')
if alg==1
    [Wh,Hh]=nmfmse( S, number_bases,iter_num ,0);
elseif alg==2
    [Wh,Hh]=nmfdiv( S, number_bases,iter_num ,0);
end
Wt=Wh(1:all_r*5,:); Ws=Wh(all_r*5+1:end,:);

imagesc(flipud(log([Wh(1:all_r,:);Wh(all_r*5+1:all_r*6,:)])))   % Show the learned joint-dictionary
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Conversion %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Starting conversion...')
SourceTestWavFile=GetFileNames(SourceTestList);

for i=1:size(SourceTestWavFile,2)
    [x fs]=wavread(SourceTestWavFile{i});
    [absMix,phaseMix,Mixframes,resdue]=Buildspectrogram(x,fs);
    absMix=absMix(1:all_r,:); absMix=multiframes2(absMix);

    % Ws fixed-> find Hs
    H=abs(randn(number_bases,Mixframes)); 
    W=Ws;
    if alg==1
        for iter=1:iter_num2
            H = H.*(W'*absMix)./(W'*W*H + 1e-9);
        end
    elseif alg==2
        for iter=1:iter_num2
            H = H.*(W'*(absMix./(W*H + 1e-9)))./(sum(W)'*ones(1,Mixframes));
        end
    end

    V=Wt*H; 
    V=singleframe2(V); % Section III-C in the paper for Contextual Information
    V=[V(1:all_r,:);V(end-1:-1:2,:)];

    convertedSpeech=Convert2Speech(V,phaseMix,fs,Mixframes,resdue);
    convertedSpeechN=convertedSpeech/max(abs(convertedSpeech));
    wavwrite(convertedSpeechN,fs,strcat('./Converted_speech/',int2str(i),'.wav')); 
end
toc;
   
