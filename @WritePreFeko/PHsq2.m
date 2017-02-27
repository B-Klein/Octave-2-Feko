function F = PHsq2(F, xyz, rad, pname, cnt)

% Produces a square plate from vector xyz accepts duplicates
%
%   . -->-- .
%   |				|
%   ^		o		v
%   |		  	|
%   . --<-- .
%
% rad of o at cnt point, if cnt is not given assumes equall spacing and finds the average

if(0) %example
	%	side A
	% xyz(1,:) = [linspace(0,10,11) linspace(10,10,11)	linspace(10,0,11) 	linspace(0,0,11)];
	% xyz(3,:) = [linspace(0,0,11)	linspace(0,10,11) 	linspace(10,10,11) 	linspace(10,0,11)];
	% xyz(2,:) = [linspace(0,0,11) 	linspace(0,0,11)		linspace(0,0,11)		linspace(0,0,11)];

	xyz(1,:) = [linspace(0,10,11) linspace(10,10,5)	linspace(10,0,11) 	linspace(0,0,11)];
	xyz(2,:) = [linspace(0,0,11)	linspace(0,5,5) 	linspace(5,5,11) 	linspace(5,0,11)];
	xyz(3,:) = [linspace(0,0,11) 	linspace(0,0,5)		linspace(0,0,11)		linspace(0,0,11)];
	cnt = [5 2.5 0];

	xyz = xyz';
	rad = 2;
	pname = 'sqname';
end

xyz = removeduplicatesxyz(xyz);

[r c] = size(xyz);
xyz(r+1,:) = xyz(1,:);

if ~exist('cnt'), cnt = mean(xyz); end

for n = 1:r
	s1 = cnt;
	s2 = xyz(n,:);
	v = (xyz(n,:) - cnt); v = v/norm(v);
	s5 = cnt + rad*v;
	s4 = xyz(n+1,:);
	maxedge = norm(s4-s1);
	F = DP(F, [pname 's1' num2str(n)], s1(1), s1(2), s1(3));
	F = DP(F, [pname 's2' num2str(n)], s2(1), s2(2), s2(3));
	F = DP(F, [pname 's4' num2str(n)], s4(1), s4(2), s4(3));
	F = DP(F, [pname 's5' num2str(n)], s5(1), s5(2), s5(3));

	F = PH(F, [pname 's1' num2str(n)],[pname 's2' num2str(n)],[],[pname 's4' num2str(n)],[pname 's5' num2str(n)], maxedge, []);
end
