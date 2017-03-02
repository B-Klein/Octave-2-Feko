function sv = get(L, prL)

	switch prL
		case 'linename'
			sv = L.linename;
		case 'type'
			sv = L.type;
		case 'cords'
			sv = L.cords;
		case 'label'
			sv = L.label;
		case 'tmpf'
			sv = L.tmpf;
		otherwise
			warning('property not found in OLines');
			sv =[];
	end
