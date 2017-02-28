function s3d = set(s3d,varargin)

	prop = varargin{1};
	switch prop
		case 'name'
			val = varargin{2};
			s3d.name = val;
		case 'fekoshapes'
			val = varargin{2};
			s3d.fekoshapes=val;
		otherwise
			warning('property of Feko3DShapes object not found');
	end
