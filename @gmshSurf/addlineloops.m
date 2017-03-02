function [gms pLl] = addlineloops(gms,lines)

	% add lineloops to a gms object in a fast and easy way, currently assumes all lines are of
	% the same type
currlineloop = size(getgmshSurf(gms,'lineloops'))(2);

for n=1:size(lines)(1)
 gms = setgmshSurf(gms,'lineloop',lines(n,:));
end

pLl = currlineloop+1;
% 	case {'lineloops', 'lineloop'}
%   	val = varargin{2};
% 		ln=length(gms.lineloops);
% 		gms.lineloops{ln+1}=val;
