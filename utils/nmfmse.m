function [W,H]=nmfmse( V, rdim,iter_num ,showflag )
%%% MSE objective = 0.5*sum(sum((V-W*H).^2))

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
   figure(2); clf; % this will show the objective function
   drawnow;
end

% Calculate initial objective
objhistory = 0.5*sum(sum((V-W*H).^2));

% Start iteration
for iter=1:iter_num    
    % Show stats
    if showflag && (rem(iter,5)==0),
	figure(1);
	cursW = (sqrt(vdim)-(sum(W)./sqrt(sum(W.^2))))/(sqrt(vdim)-1);
	cursH = (sqrt(samples)-(sum(H')./sqrt(sum(H'.^2))))/(sqrt(samples)-1);
	subplot(3,1,1); bar(sqrt(sum(W.^2))); title('Energy of W');
	subplot(3,1,2); bar(cursW);title('sparsenesses of W'); ylabel('Sparsenesses');
	subplot(3,1,3); bar(cursH);title('sparsenesses of W'); ylabel('Sparsenesses');
    if iter>1,
	    figure(2);
	    plot(objhistory(2:end));title('Objective'); xlabel('number of iterations');
    end
    drawnow;
    end
    
    
    % Compute new W and H (Lee and Seung; NIPS*2000)
    H = H.*(W'*V)./(W'*W*H + 1e-9);
    W = W.*(V*H')./(W*H*H' + 1e-9);

    % Renormalize so rows of H have constant energy
    norms = sqrt(sum(H'.^2));
    H = H./(norms'*ones(1,samples));
    W = W.*(ones(vdim,1)*norms);
    
    % Calculate objective
    newobj = 0.5*sum(sum((V-W*H).^2));
    objhistory = [objhistory newobj];
    
end