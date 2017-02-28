function s3dN = add3dshape(s3d, s3d2)

	% function s3dN = add3dshape(s3d, s3d2)
	%
	% Adds 3D shape s3d2 to s3d, and returns a new combined shape
	
	s3dN = s3d;
	s = get(s3d2, 'fekoshapes');
	for n = 1:length(s)
		s3dN = addshape(s3dN, s{n});	
	end
