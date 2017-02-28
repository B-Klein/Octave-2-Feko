function s3d = curvecreate(s3d, xyz, xyz2, name, resN, resC,looped)

	% function s3d = curvecreate(s3d, xyzCurve1, xyzCurve2, name)
	% creates a set of shapes so as to fill up the space between two curves
	% requires the first point to be correctly aligned to whatever other objects are in the
	% feko3dshape and will use addshape NOT joinshape.
	%
	% resN is the number of mesh points between curves for, [start_point middle_points end_point]
	% resC is cell of vectors of the actual points to start and end with, if given start_point
	% or end_point must be zero or it is ignored.
	%
	% Requires an existing 3D structure

	wrnstr = 'off'; % MAKE THIS GLOBAL

	if ~exist('resN') || isempty(resN), resN=[2 2 2]; end

	 % 1. Find curve with the least points
	if length(xyz)<length(xyz2)
		ca = xyz; cb = xyz2;
	else
		ca = xyz2; cb = xyz;
	end

	% 1st Triangle is obvious so create it
	shpn = 1;
	% CAB(:,1) = linspace(ca(1,1), cb(1,1), 
	% xyz = [ca(1,:) cb(1,:); cb(2,:)]; 
	xyz = [linspace3(ca(1,:), cb(1,:),resN(1)); cb(2,:)]; 
	if  ~abs(resN(1))<tol 
		xyz = [linspace3(ca(1,:), cb(1,:),resN(1)); cb(2,:)]; 
	else
		xyz = [resC{1}; cb(2,:)]; 
	end
	s = FekoShapes([name num2str(shpn)]);
	s = edgepoints(s, xyz);
  s = set(s, 'label', name);
%CHECK for duplicates 
	if size(removeduplicatesxyz(xyz))(1)>2,s3d = addshape(s3d, s);	else, warning(wrnstr,'cowardly refusing to add polygons with only 2 points');	end

	% Have first triangle so now need to add all new triangles
	%

	can=1;
	for n=2:(length(cb)-1)

		if (length(ca)-(can+1))>tol,
			pa = ca(can,:); pb = ca(can+1,:);
		end
		if norm(pa - cb(n,:)) < norm(pb - cb(n,:))
			xyz = [linspace3(pa,cb(n,:),resN(2))  ; cb(n+1,:)];
			shpn=shpn+1;
			s = FekoShapes([name num2str(shpn)]);
			s = edgepoints(s, xyz);
  s = set(s, 'label', name);
	if size(removeduplicatesxyz(xyz))(1)>2,s3d = addshape(s3d, s);	else, warning(wrnstr,'cowardly refusing to add polygons with only 2 points');	end
			% s3d = addshape(s3d, s);

		else%then then next point is closer and we must close off the triangle and move onto
			% the next point
			can = can+1;
			xyz = [linspace3(pa,pb,resN(2)) ; cb(n,:)];
			shpn=shpn+1;
			s = FekoShapes([name num2str(shpn)]);
			s = edgepoints(s, xyz);
  s = set(s, 'label', name);
	if size(removeduplicatesxyz(xyz))(1)>2,s3d = addshape(s3d, s);	else, warning(wrnstr,'cowardly refusing to add polygons with only 2 points');	end
			% s3d = addshape(s3d, s);

			xyz = [linspace3(pb,cb(n,:),resN(2))  ; cb(n+1,:)];
			shpn=shpn+1;
			s = FekoShapes([name num2str(shpn)]);
			s = edgepoints(s, xyz);
  s = set(s, 'label', name);
	if size(removeduplicatesxyz(xyz))(1)>2,s3d = addshape(s3d, s);	else, warning(wrnstr, 'cowardly refusing to add polygons with only 2 points');	end

		end
	end

	% Put on last triangle
	if ~abs(resN(3))<tol 
		xyz = [ca(end-1,:);linspace3(cb(end,:), ca(end,:),resN(3))];
	else
		xyz = [ca(end-1,:);resC{2}];
	end
	shpn=shpn+1;
	s = FekoShapes([name num2str(shpn)]);
	s = edgepoints(s, xyz);
  s = set(s, 'label', name);
	if size(removeduplicatesxyz(xyz))(1)>2,s3d = addshape(s3d, s);	else, warning(wrnstr, 'cowardly refusing to add polygons with only 2 points');	end
	%
	if exist('looped')

		N = str2num(looped);
		for n = 1:N
			shpn=shpn+1;
			s = FekoShapes([name num2str(shpn)]);
			xyz = [ca(end-n,:); ca(end-(n+1),:); cb(1,:)];
			s = edgepoints(s, xyz);
  s = set(s, 'label', name);
			if size(removeduplicatesxyz(xyz))(1)>2,s3d = addshape(s3d, s);	else, warning(wrnstr, 'cowardly refusing to add polygons with only 2 points');	end
		end

	end
