function sv = get(s, prop)

	switch prop
		case 'shapename'
			sv = s.shapename;
		case 'Numpoints'
			sv = s.Numpoints;
		case 'points'
			sv = s.points;
		case 'Numedgepoints'
			sv = s.Numedgepoints;
		case 'edgepoints'
				sv = s.edgepoints;
		case 'diskpointso'
			sv = s.diskpointso;
		case 'diskpointsi'
			sv = s.diskpointsi;
		case 'diskangle'
			sv = s.diskangle;
		case 'curvepointso'
			sv = s.curvepointso;
		case 'curvepointsi'
			sv = s.curvepointsi;
		case 'curveangletop'
			sv = s.curveangletop;
		case 'curveanglestarttop'
			sv = s.curveanglestarttop;
		case 'curveanglebot'
			sv = s.curveanglebot;
		case 'curveanglestartbot'
			sv = s.curveanglestartbot;
		case 'edgelabels'
			sv = s.edgelabels;
		case 'shapetype'
			sv = s.shapetype;
		case 'inflag'
			sv = s.inflag;
		case 'label'
			sv = s.label;
		case 'material'
			sv = s.material;
		otherwise
			warning(['property: ' prop ' not found']);
			sv =[];
	end
