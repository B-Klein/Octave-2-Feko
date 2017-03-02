function [gms pL] = addlines(gms,pnts,ltype)

	% add lines to a gms object in a fast and easy way, currently assumes all lines are of
	% the same type
currline = size(getgmshSurf(gms,'lines'))(2);

for n=1:size(pnts)(1)
 currline=currline+1;
 gms = setgmshSurf(gms,'lines',currline,pnts(n,:),ltype);
end

pL = currline;
