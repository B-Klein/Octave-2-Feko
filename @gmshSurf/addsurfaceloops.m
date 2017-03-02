function [gms pSL] = addsurfaceloops(gms,surfaces)

	% add surfaceloops to a gms object in a fast and easy way, currently assumes all
	% surfaces are of
	% the same type
currsurfaceloop = size(getgmshSurf(gms,'surfaceloops'))(2);

for n=1:size(surfaces)(1)
 gms = setgmshSurf(gms,'surfaceloop',surfaces(n,:));
end

pSL = currsurfaceloop+1;
% 	case {'surfaceloops', 'surfaceloop'}
%   	val = varargin{2};
% 		ln=length(gms.surfaceloops);
% 		gms.surfaceloops{ln+1}=val;
