function s3d = circularcurvecreate(s3d, xyzo, xyzi, name)

	% function s3d = circularcurvecreate(s3d, xyzo, xyzi, name)
	% creates two shapes so as to fill the space between two circles, circles must
	% be alligned and rotating in same direction.
	% requires the first point to be correctly aligned to whatever other objects are in the
	% feko3dshape and will use addshape NOT joinshape.
	%
	% Requires an existing 3D structure

	xyzo = removeduplicatesxyz(xyzo);
	xyzi = removeduplicatesxyz(xyzi);

	souter = FekoShapes([name 'outer']);
	souter = edgepoints(souter, xyzo);
	sinner = FekoShapes([name 'inner']);
	sinner = edgepoints(sinner, xyzi);

	pnts = [xyzo(1,:); xyzo(round(length(xyzo)/2),:);xyzi(1,:); xyzi(round(length(xyzi)/2),:)];
	res = abs(norm(xyzo(2,:)-xyzo(1,:)));
	[sa sb] = minusshapes(souter, sinner, pnts,res);

	s3d = addshape(s3d,sa);
	s3d = addshape(s3d,sb); 
