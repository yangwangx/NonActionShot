%% This function showcases how to compute VideoDarwin with/out pruning

run '../config.m';
% range for descriptors: [Traj, Hog, Hof, Mbh]
descRange=[  1, 7681,32257, 59905; ...
          7680,32256,59904,109056];
C=1;
Window=25;
Alpha=3;
load('../2.ClassifyNonAction/shotCLF.mat','CLF');

for i=1
    video=All_videos{i};
    id=video(1:6);
    load(sprintf('../1.ComputeShotFV/frmFV/%s.mat',id),'frmFV');
    frmFV=frmFV(8:end-8,:); % remove zero fvs
    N=size(frmFV,1);

    %% VideoDarwin
    weight=ones(N,1);
    FwLb=cumsum(weight);
    BwLb=cumsum(flip(weight,1));
    FwFV=fvsNormalize(cumsum(frmFV));
    BwFV=fvsNormalize(cumsum(flip(frmFV,1)));
    % get video darwin
    FwDw=[];
    BwDw=[];
    for j=1:4
        inx=descRange(1,j):descRange(2,j);
        Data=FwFV(:,inx);
        model=train(double(FwLb),sparse(double(Data)),sprintf('-c %1.6f -s 11 -q',C));
        FwDw{j}=L2Normalize(model.w',1);
        Data=BwFV(:,inx);
        model=train(double(BwLb),sparse(double(Data)),sprintf('-c %1.6f -s 11 -q',C));
        BwDw{j}=L2Normalize(model.w',1);
    end
    FwDw=cat(1,FwDw{:});
    BwDw=cat(1,BwDw{:});

    %% VideoDarwin++
    % non-action score & weighting
    allFV=sum(frmFV,1);
    inFV=fvsNormalize(filter2(ones(Window,1),frmFV));
    outFV=fvsNormalize(bsxfun(@minus,allFV,inFV));
    score=[inFV,outFV]*CLF.W+CLF.B;
    weight=softmax(-score*Alpha,1)*N;
    FwLb=cumsum(weight);
    BwLb=cumsum(flip(weight,1));
    frmFV_weight=frmFV.*repmat(weight,[1,109056]);
    FwFV=fvsNormalize(cumsum(frmFV_weight));
    BwFV=fvsNormalize(cumsum(flip(frmFV_weight,1)));
    % get video darwin
    FwDw=[];
    BwDw=[];
    for j=1:4
        inx=descRange(1,j):descRange(2,j);
        Data=FwFV(:,inx);
        model=train(double(FwLb),sparse(double(Data)),sprintf('-c %1.6f -s 11 -q',C));
        FwDw{j}=L2Normalize(model.w',1);
        Data=BwFV(:,inx);
        model=train(double(BwLb),sparse(double(Data)),sprintf('-c %1.6f -s 11 -q',C));
        BwDw{j}=L2Normalize(model.w',1);
    end
    FwDw=cat(1,FwDw{:});
    BwDw=cat(1,BwDw{:});
end


