function AP=smAP(scores,labels,alphas)
%%
% if alpha=0, AP is the original AP
% otherwise, perform alpha-softmax first

nAlpha=numel(alphas);
nLabel=size(labels,2);
AP=nan(nAlpha,nLabel);
for i=1:nAlpha
        alpha=alphas(i);
        if alpha==0
                scores_=scores;
        else
                scores_=softmax(scores*alpha,2);
        end
        for j=1:nLabel
                AP(i,j)=ml_ap(scores_(:,j),labels(:,j),0);
        end
end

end

