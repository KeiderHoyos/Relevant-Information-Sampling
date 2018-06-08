function [X, ww]=ris(X,N_size,lambda,sigma)
%% function to perform the RIS approach.

% Parameters:
% X      : Majority Class
% N_size : Samples to select from the majority Class. Generally equal to
% the size of the minority class.
% lambda : The weighting parameter which combines the regularization and similarity 
% terms in appropriate proportion to capture different aspects of the data structure.
% sigma  : The resolution parameter which controls the “scale” of the analysis

% Copyright (C) 2018 Automatica Research Group
% Keider Hoyos Osorio -Universidad Tecnológica de Pereira
% $Id: ris.m 2018-06-08$
%%


X=X'; 
[n,N] = size(X);
%----------- data generation ----------------
ww = (-0.2*min(X(:))+((0.15*max(X(:)))-0.15*min(X(:)))*rand(n,N_size));
% ----------------------------------------------------
[~,M]=size(ww);

epoch = 0;

diff = 1;
while diff >5e-5
    %-----Annealing---
    epoch = epoch + 1 ;
    sigma_S = sigma/(1+epoch);
    sigma_X=sigma_S;
    % Here, we compute the kernels
    for j=1:M
        kernel_ww(j,:)=kernel(repmat(ww(:,j),1,M)-ww,sigma_S);
        kernel_xw(j,:)=kernel(repmat(ww(:,j),1,N)-X,sigma_X);
    end
    
    V_ww = (1/M^2)*sum(sum(kernel_ww));
    V_wx = (1/(M*N))*sum(sum(kernel_xw));
    C    = (N*V_wx)/(M*V_ww); 
    w_old = ww;
    
    for k=1:M
        factor_1 = kernel_ww(k,:)*w_old';
        factor_2 = (sum(kernel_xw(k,:)));
        factor_3 = kernel_xw(k,:)*X';
        factor_4 = factor_2;
        factor_5 = (sum(kernel_ww(k,:)));
        factor_6 = factor_2;
        
        ww(:,k) = C*((1-lambda)/lambda)*factor_1/factor_2 + factor_3/factor_4...
                - C*((1-lambda)/lambda)*(factor_5/factor_6)*w_old(:,k)';
    end
    
    diff = norm(ww-w_old);
    
    figure(4);%subplot(2,1,1),
    cla, plot(X(1,:),X(2,:),'.'); hold on ; plot(ww(1,:),ww(2,:),'r.','MarkerSize',10); drawnow,...
    axis([ min(X(1,:)) max(X(1,:)) min(X(2,:)) max(X(2,:))]); 
end 




function [J] = cost(X,ww,sigma_X,sigma_S,M,N,epoch)
F=0; G=0;
for i=1:M
    F=F+log(sum(kernel(repmat(ww(:,i),1,M)-ww,sigma_S))/M);       
    G=G+log(sum(kernel(repmat(ww(:,i),1,N)-X, sigma_X))/N); 
end
F=mean(F); 
G=mean(G);
J=F-G;

%---------------------------------------
function out = kernel(in,zigma)
in2 = inv(zigma)*in;
%A=(2*pi*det(zigma))^(size(in,1)/2);
out = exp(-0.5*sum(in.*in2,1));   % to normalize the sum /(size(in,2))
return 