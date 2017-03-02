function L = set(L,varargin)

	prL = varargin{1};
	switch prL
		case 'linename'
			val = varargin{2};
			L.linename = val;
		case 'type'
			val = varargin{2};
			L.typ = val;
		case 'cords'
			val = varargin{2};
			L.cords = val;
		case 'label'
			val = varargin{2};
			L.label = val;
		case 'tmpf'
			val = varargin{2};
			L.tmpf = val;
		case 'options'
			val = varargin{2};
			L.options = val;
		otherwise
			warning('property of OLine object not found');
	end
