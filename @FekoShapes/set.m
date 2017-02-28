function s = set(s,varargin)

	prop = varargin{1};
	switch prop
		case 'shapename'
			val = varargin{2};
			s.shapename=val;
		case 'Numpoints'
			val = varargin{2};
			s.Numpoints=val;
		case 'points'
			val = varargin{2};
			s.points=val;
		case 'Numedgepoints'
			val = varargin{2};
			s.Numedgepoints=val;
		case 'edgepoints'
			val = varargin{2};
			s.edgepoints=val;
			s.Numedgepoints=length(val);
		case 'curvepointsi'
			val = varargin{2};
			s.curvepointsi=val;
		case 'curvepointso'
			val = varargin{2};
			s.curvepointso=val;
		case 'diskpointsi'
			val = varargin{2};
			s.diskpointsi=val;
		case 'diskpointso'
			val = varargin{2};
			s.diskpointso=val;
		case 'diskangle'
			val = varargin{2};
			s.diskangle=val;
		case 'curveangletop'
			val = varargin{2};
			s.curveangletop=val;
		case 'curveanglestarttop'
			val = varargin{2};
			s.curveanglestarttop=val;
		case 'curveanglebot'
			val = varargin{2};
			s.curveanglebot=val;
		case 'curveanglestartbot'
			val = varargin{2};
			s.curveanglestartbot=val;
		case 'edgelabels'
			val = varargin{2};
			s.edgelabels=val;
		case 'shapetype'
			val = varargin{2};
			s.shapetype=val;
		case 'label'
			val = varargin{2};
			s.label=val;
		case 'inflag'
			val = varargin{2};
			s.inflag=val;
		case 'material'
			val = varargin{2};
			s.material=val;
		otherwise
			warning('property not found');
	end
