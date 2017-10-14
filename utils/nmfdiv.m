function [W,H]=nmfdiv( V, rdim,iter_num ,showflag)
%%% divergence objective = sum(sum((V.*log(V./(W*H))) - V + W*H));
     
% Check that we have non-negative data
if min(V(:))<0, error('Negative values in data!'); end

% Globally rescale data to avoid potential overflow/underflow
V = V/max(V(:));

% Dimensions
vdim = size(V,1);
samples = size(V,2);

% Create initial matrices
W = abs(randn(vdim,rdim));
H = abs(randn(rdim,samples));

% Initialize displays
if showflag,
   figure(1); clf; % this will show the energies and sparsenesses
end


% Start iteration
for iter=1:iter_num    
    % Show stats
    if showflag && (rem(iter,5)==0),
	figure(1);
	cursW = (sqrt(vdim)-(sum(W)./sqrt(sum(W.^2))))/(sqrt(vdim)-1);
	cursH = (sqrt(samples)-(sum(H')./sqrt(sum(H'.^2))))/(sqrt(samples)-1);
	subplot(3,1,1); bar(sqrt(sum(W.^2)));
	subplot(3,1,2); bar(cursW);
	subplot(3,1,3); bar(cursH);
    end
    
    
    % Compute new W and H (Lee and Seung; NIPS*2000)
    H = H.*(W'*(V./(W*H + 1e-9)))./(sum(W)'*ones(1,samples));
    W = W.*((V./(W*H + 1e-9))*H')./(ones(vdim,1)*sum(H'));

   
    
    
end