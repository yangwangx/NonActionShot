function traj = trajCollect4dtdFeatDir(dtdFeatDir, coord)
    if ~exist('coord','var') coord=false; end
    %% list all dtdFeatFiles
    dtdFeatDir=[dtdFeatDir,'/'];
    dtdFeatFiles = dir([dtdFeatDir,'dtdFeat*.mat']);
    %% initialize traj
    if (coord)
        descTypes = {'trajXY', 'trajHog', 'trajHof', 'trajMbh','trajXY_precise','trajEnd','trajStat'};
    else
        descTypes = {'trajXY', 'trajHog', 'trajHof', 'trajMbh','trajEnd','trajStat'};
    end
    for i=1:length(descTypes)
        traj.(descTypes{i})=[];
    end
    %% load dtdFeatFiles into traj
    for i=1:length(dtdFeatFiles)
        % Load DTD features
        Load = load([dtdFeatDir,'/',dtdFeatFiles(i).name]);
        if size(Load.trajXY,1) == 0
            continue;
        end;
        % convert DTD to double format
        traj.trajXY=[traj.trajXY;double(Load.trajXY)/Load.trajXY_scale];
        for j=2:4
            traj.(descTypes{j})=[traj.(descTypes{j});double(Load.(descTypes{j}))/Load.desc_scale];
        end
        if (coord)
            traj.trajXY_precise=[traj.trajXY_precise;Load.trajXY_precise];
        end
        traj.trajEnd=[traj.trajEnd;Load.trajStat(:,1)];
        traj.trajStat=[traj.trajStat;Load.trajStat];
    end
end

