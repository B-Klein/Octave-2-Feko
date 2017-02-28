function s = generatePNTSondisk(si, N, ang) %, scrv, scrvi, dsk)

	% function [s] = generatePNTSondisk(s,N,angle)
	%
	% 	s.edgepoints should be passed as in the KR card so:
	% 	S2
	% 	S1 - S4 -- S3
	%
	%		s.edgepoints = [s1; s2; s3(; s4)] % (optional variable)
	%
	%		N - is the number of points required on disk, one side.
	%		angle [deg] - is the angle traced out by the disk, if not passed here will be
	%		read from structure s.diskangle, otherwise it will be added. If nothing is given,
	%		defaults to 360 degrees.


	s = si;
	if exist('ang') && ~isempty(ang), s = set(s,'diskangle',ang); 
	else, ang = get(s,'diskangle'); if isempty(ang),...
			ang = 360; s =	set(s,'diskangle',ang); end, end
	if N(1)<7, N(1)=7; end
	s = set(s,'shapetype', 'disk');

	A = get(s,'edgepoints'); if abs(length(A))<3, error('need edgepoints in generatePNTSondisk'); end

	R = abs(norm(A(1,:)-A(3,:)));
	r = A(3,:)-A(1,:);
	r = r/norm(r);
	c1 = A(1,:);
	c2 = A(2,:);
	n = c2-c1;
	n = n/norm(n);
	vang = linspace(0,ang,N(1));

	% From the equation of a circle in free space:
	% P = R.*cosd(vang).*r + R.*sind(vang).*cross(r,n) + c;
	P1 = bsxfun(@plus, bsxfun(@times,r, [R.*cosd(vang)]') + bsxfun(@times, cross(n,r), [R.*sind(vang)]'), c1);
	
	s = set(s,'diskpointso', [P1]);


	if abs(size(A)(1)-4)<tol % 4 pnts given therefore need inner points as well

		if N(2)<7, N(2)=7; end
		R = abs(norm(A(1,:)-A(4,:)));
		r = A(4,:)-A(1,:);
		r = r/norm(r);
		vang = linspace(0,ang,N(2));

		P2 = bsxfun(@plus, bsxfun(@times,r, [R.*cosd(vang)]') + bsxfun(@times, cross(n,r), [R.*sind(vang)]'), c1);

		s = set(s,'diskpointsi', [P2]);

		% if exist('scrvi') % Create a curve object to be connected to this
		% scrvi = set(scrvi,'shapetype','curve');
		% xyz = [c1; c2; A(4,:);A(4,:)+n];
		% scrvi = edgepoints(scrvi,xyz);
		% scrvi = set(scrvi,'curveangletop', ang);
		% scrvi = set(scrvi,'curveanglebot', ang);
		% scrvi = generatePNTSoncurve(scrvi,N(2));
		% else
		% scrvi=[];
		% end
	else
		s = set(s,'diskpointsi', [c1]);
		% scrvi=[];
	end


