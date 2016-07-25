function flatfv=fvFlat(fv)
	if ~isempty(fv)
	    flatfv = [fv.trajXY',fv.trajHog',fv.trajHof',fv.trajMbh'];
	else
	    flatfv=zeros(1,109056);
	end
end

