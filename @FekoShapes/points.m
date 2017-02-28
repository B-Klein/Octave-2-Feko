function s = points(s,xyz)

% function s = points(s,XYZ)
% XYZ is a matrix of points to be added on to existing points


	if(isempty(s.points)), s.points = xyz; s = Numpoints(s, length(xyz)); return; end

	n = size(s.points)(1);
	s.points((n+1):(n+length(xyz)), :) = xyz;
% if 
% try n = length(s.Numpoints); catch, n=0; end
% 
% 
% s.points{n+1} = xyz;
% s = Numpoints(s, n+1);
%
s = Numpoints(s, length(s.points));
