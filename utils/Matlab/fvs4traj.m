function [fvs,trajN]=fvs4traj(traj,MaxFrm,gmmModelFile)
    descTypes = {'trajXY', 'trajHog', 'trajHof', 'trajMbh'};
    fvs=[];        % fv for each frame
    trajN=[];      % number of traj for each frame
    ns=size(traj.trajXY,1);
    if ~(ns==0)
        load(gmmModelFile);
        FrmIdxs=1:MaxFrm;
        fvs=zeros(MaxFrm,109056,'single');
        trajN=zeros(MaxFrm,1);
        for i=1:MaxFrm
            inx=find(traj.trajEnd==FrmIdxs(i)+8);
            if isempty(inx)
                continue;
            end
            fv=cell(1,4);
            for j=1:length(descTypes)
                Frame.(descTypes{j}) = traj.(descTypes{j})(inx,:)';
                % apply PCA
                PCA_j = PCA.(descTypes{j});
                Frame.(descTypes{j}) = Frame.(descTypes{j}) - repmat(PCA_j.mu, 1, size(Frame.(descTypes{j}),2));
                Frame.(descTypes{j}) = PCA_j.PcaBasis'*Frame.(descTypes{j});
                % get fisher vector
                GMM_j = GMM.(descTypes{j});
                fv{j} = vl_fisher(Frame.(descTypes{j}), GMM_j.mus, GMM_j.covs, GMM_j.priors);
            end
            fvs(i,:)=(cat(1,fv{:})*length(inx))';
            trajN(i,:)=length(inx);
        end
    end
end


