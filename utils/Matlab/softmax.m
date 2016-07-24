function S=softmax(D,dim)
   expD=exp(D);
   sz=ones(1,length(size(D)));
   sz(dim)=size(D,dim);
   S=expD./repmat(sum(expD,dim),sz);
end

