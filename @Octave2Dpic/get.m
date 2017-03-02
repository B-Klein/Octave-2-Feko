function sv = get(Op, prop)

	switch prop
		case 'name'
			sv = Op.name;
		case 'texfile'
			sv = Op.texfile;
		case 'texpath'
			sv = Op.texpath;
		case 'header'
			sv = Op.header;
		case 'footer'
			sv = Op.footer;
		case 'OLines'
			sv = Op.OLines;
		case 'tmpf'
			sv = Op.tmpf;
		otherwise
			warning('property not found in Octave2Dpic');
			sv =[];
	end
