function names = printNames(s3d)

	% names = printNames(s3d)
	%
	% returns all the shapes' names in a 3D object s3d
	
	for n = 1:length(s3d.fekoshapes)
		s = s3d.fekoshapes{n};
		names{n} = get(s,'shapename');
	end

