function [so] = generatePNTSoncurve(s, N, ang)

	% function [s] = generatePNTSoncurve(s,N,(angle))
	% function [s] = generatePNTSoncurve(s_disk, s_curve, 'outer' | 'inner')
	%
	% [s] = generatePNTSoncurve(s,N,(angle))
	% 	s.edgepoints should be passed as in the KK card so:
	%			S3
	% 	/  |
	% S4	 |	 
	% |		 |
	% S2 __S1
	%
	%		s.edgepoints = [s1; s2; s3; s4]
	%
	%		N - is the number of points required on curve, one side.
	%		angle [deg] - optional, sets the ending angle for top and bottom to angle.
	%			Recommended to ignore this option and set it in the shape properties.
	%
	%		The follwing properties are used to construct the curve and Default to:
	%     curveanglestarttop - 0 curveanglestartbot - 0
	%   	curveangletop - 360	curveanglebot - 360 
	%
	% Otherwise:
	% [s] = generatePNTSoncurve(s_disk, s_curve, 'outer' | 'inner')
	%
	% Attach a curve to an existing disk structure, much simpler : ) will return the curve
	% with either outer or inner disk. Example
	% generatPNTsoncurve(sdisk,scurve, 'outer')
	% generatPNTsoncurve(sdisk,scurve, 'inner')
	%
	% Create a situation where this can be called with a disk object and then a curve is
	% generated that connects to that disk : ) 
	% need to set diskangle

	if strcmp(get(s,'shapetype'), 'disk')
		crv = N;
		switch ang
			case{'outer'}
				A = get(s,'edgepoints');
				N = length(get(s,'diskpointso'));
				crv = set(crv,'shapetype','curve');
				% xyz = [A(1:3,:);A(3,:)+n];
				xyz = [A(1:3,:);A(3,:)+A(2,:)-A(1,:)];
				crv = edgepoints(crv,xyz);
				ang = get(s, 'diskangle');
				crv = set(crv,'curveangletop', ang);
				crv = set(crv,'curveanglebot', ang);
				crv = generatePNTSoncurve(crv,[N(1) N(1)]);
				so = crv;
			case{'inner'}
				A = get(s,'edgepoints');
				N = length(get(s,'diskpointsi'));
				crv = set(crv,'shapetype','curve');
				% xyz = [A(1:3,:);A(3,:)+n];
				xyz = [A(1:2,:);A(4,:); A(4,:)+A(2,:)-A(1,:)];
				crv = edgepoints(crv,xyz);
				ang = get(s, 'diskangle');
				crv = set(crv,'curveangletop', ang);
				crv = set(crv,'curveanglebot', ang);
				crv = generatePNTSoncurve(crv,[N(1) N(1)]);
				so = crv;
			otherwise
		end
		break
	end

	so = s;
	% Sets default values to start at 0 and end at 360
	if exist('ang'), so = set(so,'curveangletop',ang); so =	set(so,'curveanglebot',ang); end
		% ang = get(so,'curveangletop'); end
	% if isempty(ang), so = set(so,'curveangletop',360); ang=360; end
	tmp = get(so,'curveangletop'); if isempty(tmp), so = set(so,'curveangletop',360); end
	tmp = get(so,'curveanglebot'); if isempty(tmp), so = set(so,'curveanglebot',360); end
	tmp = get(so,'curveanglestartbot'); if isempty(tmp), so = set(so,'curveanglestartbot',0); end
	tmp = get(so,'curveanglestarttop'); if isempty(tmp), so = set(so,'curveanglestarttop',0); end


	A = get(so,'edgepoints'); if abs(length(A)-4)>tol, error('need edgepoints in generatePNTSoncurve'); end
	R = abs(norm(A(1,:)-A(3,:)));
	r = A(3,:)-A(1,:);
	r = r/norm(r);
	c1 = A(1,:);
	c2 = A(2,:);
	n = c2-c1;
	n = n/norm(n);
	% vang = linspace(0,ang,N(1));
	vang = linspace(get(so,'curveanglestartbot'),get(so,'curveanglebot'),N(1));

	% From the equation of a circle in free space:
	% P = R.*cosd(vang).*r + R.*sind(vang).*cross(r,n) + c;
	P1 = bsxfun(@plus, bsxfun(@times,r, [R.*cosd(vang)]') + bsxfun(@times, cross(n,r), [R.*sind(vang)]'), c1);

	R = abs(norm(A(2,:)-A(4,:)));
	r = A(4,:)-A(2,:);
	r = r/norm(r);
	% vang = linspace(0,ang,N(2));
%
	vang = linspace(get(so,'curveanglestarttop'),get(so,'curveangletop'),N(2));

	P2 = bsxfun(@plus, bsxfun(@times,r, [R.*cosd(vang)]') + bsxfun(@times, cross(n,r), [R.*sind(vang)]'), c2);

	so = set(so,'curvepointsi', [P1]);
	so = set(so,'curvepointso', [P2]);
