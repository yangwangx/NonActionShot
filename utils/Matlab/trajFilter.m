function Filter=trajFilter(traj,Segments,padOpt)

if ~ismember(padOpt,{'padding','within'})
    error('invalid padOpt, use ''padding'' or ''within''');
else
    if strcmp(padOpt,'padding')
        padding=7;
    else
        padding=0;
    end
end

descTypes = {'trajXY', 'trajHog', 'trajHof', 'trajMbh','trajEnd'};
%% initialize Filter to be empty
for j=1:length(descTypes)
    Filter.(descTypes{j})=[];
end
%% add Differnt Segments into Filter
for i=1:size(Segments,2)
    SegStart=Segments(1,i);
    SegEnd=Segments(2,i);
    TrajStart=find(traj.trajEnd>=(SegStart+14-padding),1,'first');
    TrajEnd=find(traj.trajEnd<=(SegEnd+padding),1,'last');
    for j=1:length(descTypes)
        Filter.(descTypes{j})=[Filter.(descTypes{j});traj.(descTypes{j})(TrajStart:1:TrajEnd,:)];
    end
end
end
