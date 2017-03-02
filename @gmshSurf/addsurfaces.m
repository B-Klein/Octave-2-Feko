function [gms pS] = addsurfaces(gms,lineloops,stype)

	% add lineloops to a gms object in a fast and easy way, currently assumes all lines are of
	% the same type
currsurface = size(getgmshSurf(gms,'surface'))(2);

for n=1:size(lineloops)(1)
 currsurface=currsurface+1;
 gms = setgmshSurf(gms,'surface',currsurface,lineloops(n,:),stype);
end
pS = currsurface;
% 	case {'surfaces', 'surface'}
% 		val1=varargin{2}; % number;
% 		if !val1 % doesn't work for 1st value
% 			val1=size(gms.surfaces)(2)+1;
% 		end
%   	val2=varargin{3}; % pnts
%   	val3=varargin{4}; % type
% 		gms.surfaces{1,val1}=val2;
% 		gms.surfaces{2,val1}=val3;
