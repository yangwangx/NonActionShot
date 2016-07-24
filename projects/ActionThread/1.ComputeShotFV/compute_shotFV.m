% total=3035; count=15; step=203;

run ../config.m
!mkdir -p traj
!mkdir -p shotFV
!mkdir -p frmFV
for i=(count-1)*step+1:min(count*step,total)
    video=All_videos{i};
    id=video(1:6);
    shots=All_shots{i};
    annos=All_annos{i};

    %% check done or not
    if exist(sprintf('shotFV/%s.mat',id))
        continue;
    end
    %% extract frames into outFrmDir
    outFrmDir = sprintf('./traj/%s/',id);
    clip.file = [clipRoot,video];
    opts=[];opts.newH=360; opts.fps=25;
    ML_VidClip.extFrms(clip, outFrmDir, opts);
    
    %% calculate traj for video
    trajDir='traj';
    maxFrm=length(dir([outFrmDir,'/*.png']));
    frmIdxs=min(maxFrm,shots(1):shots(end));
    YW_IDTD.DTD4dir(outFrmDir,'png',frmIdxs,trajDir);
    dtdFeatDir=[outFrmDir,trajDir];
    traj=trajCollect4dtdFeatDir(dtdFeatDir, false);
    
    %% calculate shotFV for video
    gmmModelFile=[MatlabRoot,'MHLfuncs/Video/others/GMM.mat'];
    nFrm=length(frmIdxs);
    frmFV=fvs4traj(traj,nFrm,gmmModelFile); % unnormalized frame FV
    nShot=size(shots,2);
    shotFV=zeros(nShot,109056);             % unnormalized shot FV
    for j=1:nShot
        sStart=shots(1,j)-shots(1)+1;
        sEnd=shots(2,j)-shots(1)+1;
        shotFV(j,:)=sum(frmFV(sStart:sEnd,:),1);
    end
    save(sprintf('shotFV/%s.mat',id),'shotFV','-v7.3');
    % save(sprintf('frmFV/%s.mat',id),'frmFV','-v7.3');

    %% remove extracted frames and iDTD if not needed any more
    system(['rm -rf ',outFrmDir]);
end

