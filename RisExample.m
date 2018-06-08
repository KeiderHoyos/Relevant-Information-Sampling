%% ======================= RIS EXAMPLE ===============================%%
% Code for perfoming the relevant information-based sampling to classify 
% imbalancedatasets.

clear
load('data-imbalance-final.mat') %loading a synthetic imbalance dataset
datasets = data;
data = datasets{6};

[N,M] = size(data(:,1:end-1)); 

% It is necessary to normalize the input features between 0 and 1
data(:,1:end-1) = (data(:,1:end-1)-repmat(min(data(:,1:end-1)),N,1))./...
                  (repmat(max(data(:,1:end-1))-min(data(:,1:end-1)),N,1));
ClaseMin     = data(data(:,end)==-1,:);
ClaseMaj     = data(data(:,end)==1,:);
ImbRat       = size(ClaseMaj,1)/size(ClaseMin,1);
       
%% ========================= Undersampling ===============================%
% In this section we undersample the database by using the RIS approach
sigma = 5;
lambda = 1000;
tic
[X, NewMajClassPri] = ris(ClaseMaj(:,1:end-1),size(ClaseMin,1),...
                               lambda, sigma);
elapsed_time = toc;                       
disp('subsampling done...elapsed time : ')
disp(elapsed_time)
                       
NewMajClassPri = [NewMajClassPri' ones(size(NewMajClassPri,2),1)];
Xris  = [NewMajClassPri; ClaseMin];