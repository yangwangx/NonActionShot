run ../config.m
for i=1:nTrain+nTest
    video=All_videos{i};
    id=video(1:6);
    shots=All_shots{i};
    annos=All_annos{i};
    nShot=size(shots,2);

    % unnormalized shot FV
    load(sprintf('../1.ComputeShotFV/shotFV/%s.mat',id),'shotFV');
    allFV = sum(shotFV,1);
    %allFV_norm = repmat(fvsNormalize(allFV),[nShot,1]);
    inFV_norm = fvsNormalize(shotFV);
    outFV_norm = fvsNormalize(bsxfun(@minus,allFV,shotFV));
    %shotFt = [inFV_norm,outFV_norm,allFV_norm];
    shotFt = [inFV_norm,outFV_norm];
    shotLb = (annos==0)'; % non-action label

    record.shotFt{i}=shotFt;
    record.shotLb{i}=shotLb;
end
TrainFt=record.shotFt(1:nTrain);
TrainLb=record.shotLb(1:nTrain);
TestFt =record.shotFt(end-nTest+1:end);
TestLb =record.shotLb(end-nTest+1:end);
save('shotFtLb.mat','TrainFt','TrainLb','TestFt','TestLb','-v7.3');

