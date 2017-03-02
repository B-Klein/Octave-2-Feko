function Op = set(Op,varargin)

	prop = varargin{1};
	switch prop
		case 'name'
			val = varargin{2};
			Op.name = val;
		case 'texfile'
			val = varargin{2};
			Op.texfile = val;
		case 'texpath'
			val = varargin{2};
			Op.texpath = val;
		case 'header'
			val = varargin{2};
			Op.header = val;
		case 'footer'
			val = varargin{2};
			Op.footer = val;
		case 'OLines'
			val = varargin{2};
			Op.OLines = val;
		case 'tmpf'
			val = varargin{2};
			Op.tmpf = val;
		otherwise
			warning('property of Octave2dpic object not found');
	end
