run ../../setup.m
frmDir = sprintf('%s/frames/',pwd);
load('shots/shots.mat','shots');

%% calculate shot-wise Fisher vectors
gmmModelFile=[MatlabRoot,'MHLfuncs/Video/others/GMM.mat'];
nShot=size(shots,2);
shotFV=zeros(nShot,109056);             % unnormalized shot FV
for i=1:nShot
    frmIdxs=shots(1,i):shots(2,i);  % shot length varies
    fv=ML_IDTD.fvEncode4dir(outFrmDir,'png',frmIdxs,gmmModelFile);
    shotFV(i,:)=fvFlat(fv);
end
save('./shots/shotFV_unnorm.mat','shotFV','-v7.3');

%% calculate shot-wise non-action scores
load('../ActionThread/2.ClassifyNonAction/shotCLF.mat','CLF');
winFV = filter2(ones(6,1),shotFV);
inFV = fvsNormalize(shotFV);
outFV = fvsNormalize(winFV-inFV);
shotScore = [inFV,outFV]*CLF.W+CLF.B;

save('./shots/shotScore.mat','shotScore');

