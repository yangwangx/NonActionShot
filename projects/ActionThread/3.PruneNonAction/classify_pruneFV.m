run ../config.m

% original FV
load('origFV.mat');
TrK=TrainFV*TrainFV';
for i=1:13
    train_label=TrainLb(:,i);
    [alphas,B] = ML_Ridge.kerRidgeReg(TrK, train_label, 0.001*length(train_label), ones(size(train_label)));
    % decision vector
    CLF.W{i}=TrainFV'*alphas;
    CLF.B{i}=B;
end
WW=cat(2,CLF.W{:});
BB=cat(2,CLF.B{:});
TestScore=bsxfun(@plus,TestFV*WW,BB);
APs=smAP(TestScore,TestLb,0);

% pruned FV
load('pruneFV_alpha3.mat');
TrK=TrainFV*TrainFV';
for i=1:13
    train_label=TrainLb(:,i);
    [alphas,B] = ML_Ridge.kerRidgeReg(TrK, train_label, 0.001*length(train_label), ones(size(train_label)));
    % decision vector
    CLF.W{i}=TrainFV'*alphas;
    CLF.B{i}=B;
end
WW=cat(2,CLF.W{:});
BB=cat(2,CLF.B{:});
TestScore=bsxfun(@plus,TestFV*WW,BB);
APs=smAP(TestScore,TestLb,2);

