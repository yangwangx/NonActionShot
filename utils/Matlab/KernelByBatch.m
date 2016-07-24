function K=KernelByBatch(D,batch)
	N=size(D,1);
	K=nan(N,N,'like',D); 
	step=ceil(N/batch);
	
	row=[];col=[];
	for i=1:batch
		row=[row,repmat(i,[1,batch+1-i])];
		col=[col,i:batch];
	end

	for i=1:((batch+1)*batch/2)
                fprintf('batch: %d / %d\n',i,((batch+1)*batch/2));
		r=row(i);
		c=col(i);
		inx_r=(r-1)*step+1:min(N,r*step);
		inx_c=(c-1)*step+1:min(N,c*step);
		K(inx_r,inx_c)=D(inx_r,:)*D(inx_c,:)';
	end

	for i=1:N
		for j=1:i-1
			K(i,j)=K(j,i);
		end
	end
	
end

