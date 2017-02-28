function s3d = joinshapes(s3d, n, pnt, shapeB, pntj)

	% Joins shape 'shape' at point pnts to nth object at point pnt
	%
	% Will add object to shape s3d 
	%

	shapeA = s3d.fekoshapes{n};

	P1 = get(shapeA, 'edgepoints');
	p1 = P1(pnt,:);

	P2 = get(shapeB, 'edgepoints'); 
	p2 = P2(pntj,:);
	trans = p1 - p2;

	Nedge = get(shapeB, 'Numedgepoints');
	for n = 1:Nedge, Trans(n,:) = trans; end
	shapeB = set(shapeB, 'edgepoints', P2+Trans);

	s3d = addshape(s3d, shapeB);
