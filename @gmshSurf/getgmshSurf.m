function gms = getgmshSurf(gms,prop);

	switch prop
	case 'dpath'
			gms=gms.dpath;
	case 'pN'
			gms=gms.pN;
	case 'pNC'
			gms=gms.pNC;
	case 'pnts'
			gms=gms.pnts;
	case 'pntsC'
			gms=gms.pntsC;
	case {'lines', 'line'}
			gms=gms.lines;
	case {'lineloops', 'lineloop'}
			gms=gms.lineloops;
	case 'volume'
			gms=gms.volume;
	case {'surfaceloops', 'surfaceloop'}
			gms=gms.surfaceloops;
	case {'surfaces', 'surface'}
			gms=gms.surfaces;
	case {'pointINsurface','pIs'}
			gms=gms.pointINsurfaces;
	case {'periodicpoints','prps'}
			gms=gms.periodicpoints;
	case 'physicalsurface'
			gms=gms.physicalsurface;
	case 'physicalvolume'
			gms=gms.physicalvolume;
	case 'comments'
			gms=gms.comments;
	otherwise
			warning(['property: ' prop ' not found']);
			gms=[];
	end
