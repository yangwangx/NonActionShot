run ../config.m

% train classifier
load('shotFtLb.mat','TrainFt','TrainLb');
TrD=cat(1,TrainFt{:});
TrLb=sign(cat(1,TrainLb{:})-0.5);
TrK=KernelByBatch(TrD,100);
[alphas,B] = ML_Ridge.kerRidgeReg(TrK, TrLb, 0.001*length(TrLb), ones(size(TrLb)));
CLF.W=TrD'*alphas;
CLF.B=B;
save('shotCLF.mat','CLF');

% test classifier
load('shotFtLb.mat','TestFt','TestLb');
load('shotCLF.mat','CLF');
TstD=cat(1,TestFt{:});
TstLb=sign(cat(1,TestLb{:})-0.5);
TstScore=TstD*CLF.W+CLF.B;
AP=ml_ap(TstScore, TstLb, 0);
save('shotCLF.mat','AP','-append');

