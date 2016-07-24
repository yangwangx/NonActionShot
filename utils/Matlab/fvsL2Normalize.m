function fvs=fvsL2Normalize(fvs)
if isempty(fvs)
    return;
end
% L2 normalize
fvs(:,1:7680)=fvs(:,1:7680)./repmat( sqrt(sum(fvs(:,1:7680).^2,2))+eps, [1,7680] );
fvs(:,7681:32256)=fvs(:,7681:32256)./repmat( sqrt(sum(fvs(:,7681:32256).^2,2))+eps , [1,24576] );
fvs(:,32257:59904)=fvs(:,32257:59904)./repmat( sqrt(sum(fvs(:,32257:59904).^2,2))+eps , [1,27648] );
fvs(:,59905:109056)=fvs(:,59905:109056)./repmat( sqrt(sum(fvs(:,59905:109056).^2,2))+eps , [1,49152] );
end

