run '../config.m';
Alpha=3; % 2 for hollywood data
load('../2.ClassifyNonAction/shotCLF.mat','CLF');
fvs={};
fvs_prune={};
for i=1:3035
    video=All_videos{i};
    id=video(1:6);
    load(sprintf('../1.ComputeShotFV/shotFV/%s.mat',id),'shotFV');
    %% score
    allFV = sum(shotFV,1);
    %allFV_norm = repmat(fvsNormalize(allFV),[nShot,1]);
    inFV_norm = fvsNormalize(shotFV);
    outFV_norm = fvsNormalize(bsxfun(@minus,allFV,shotFV));
    %shotFt = [inFV_norm,outFV_norm,allFV_norm];
    shotFt = [inFV_norm,outFV_norm];
    score = shotFt*CLF.W+CLF.B;
    %% weighting
    weight=softmax(-score*Alpha,1);
    fvs_prune{i}=fvsNormalize(weight'*inFV_norm); 
    fvs{i}=fvsNormalize(allFV);
end

TrainFV=cat(1,fvs{1:nTrain});
TrainLb=NonAction.train.label;
TestFV=cat(1,fvs{end-nTest+1:end});
TestLb=NonAction.test.label;
save('origFV.mat','TrainFV','TrainLb','TestFV','TestLb','-v7.3');

TrainFV=cat(1,fvs_prune{1:nTrain});
TrainLb=NonAction.train.label;
TestFV=cat(1,fvs_prune{end-nTest+1:end});
TestLb=NonAction.test.label;
save(sprintf('pruneFV_alpha%d.mat',Alpha),'TrainFV','TrainLb','TestFV','TestLb','-v7.3');



