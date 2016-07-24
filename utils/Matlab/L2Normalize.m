function D=L2Normalize(D,dim)
    L2=sqrt(sum(D.*D,dim))+eps;
    temp=ones(1,length(size(D)));
    temp(dim)=size(D,dim);
    D=D./repmat(L2,temp);
end
