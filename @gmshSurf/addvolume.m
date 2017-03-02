function [gms pV] = addvolume(gms,surfaceloops)

	% add volume to a gms object in a fast and easy way, currently assumes all
	% surfaceloops are of
	% the same type
currsurfaceloop = size(getgmshSurf(gms,'volume'))(2);

for n=1:size(surfaceloops)(1)
 gms = setgmshSurf(gms,'volume',surfaceloops(n,:));
end

pV = currsurfaceloop+1;
% 	case {'volume', 'lineloop'}
%   	val = varargin{2};
% 		ln=length(gms.volume);
% 		gms.volume{ln+1}=val;
