function gms = setgmshSurf(gms,varargin)

prop=varargin{1};
switch prop
	case 'dpath'
  	val = varargin{2};
		gms.dpath=val;
	case 'pN'
  	val = varargin{2};
		gms.pN=val;
	case 'pNC'
  	val = varargin{2};
		gms.pNC=val;
	case 'pnts'
  	val = varargin{2};
		gms.pnts=val;
	case 'pntsC'
  	val = varargin{2};
		gms.pntsC=val;
	case {'lines', 'line'}
  	val1=varargin{2}; % number
  	val2=varargin{3}; % pnts
  	val3=varargin{4}; % type
		gms.lines{1,val1}=val2;
		gms.lines{2,val1}=val3;
	case {'surfaces', 'surface'}
		val1=varargin{2}; % number;
		if !val1 % doesn't work for 1st value
			val1=size(gms.surfaces)(2)+1;
		end
  	val2=varargin{3}; % pnts
  	val3=varargin{4}; % type
		gms.surfaces{1,val1}=val2;
		gms.surfaces{2,val1}=val3;
	case {'lineloops', 'lineloop'}
  	val = varargin{2};
		ln=length(gms.lineloops);
		gms.lineloops{ln+1}=val;
	case {'volume'}
  	val = varargin{2};
		ln=length(gms.volume);
		gms.volume{ln+1}=val;
	case {'surfaceloops', 'surfaceloop'}
  	val = varargin{2};
		ln=length(gms.surfaceloops);
		gms.surfaceloops{ln+1}=val;
	case {'pointINsurfaces','pIs'}
		val = varargin{2};
		ln=length(gms.pointINsurfaces);
		gms.pointINsurfaces{ln+1}=val;
	case {'periodicpoints','prps'}
		val = varargin{2};
		ln=length(gms.periodicpoints);
		gms.periodicpoints{ln+1}=val;
	case 'physicalline'
  	num = varargin{2};
  	val = varargin{3};
		gms.physicalline{num}=val;
	case 'physicalsurface'
  	num = varargin{2};
  	val = varargin{3};
		gms.physicalsurface{num}=val;
	case 'physicalvolume'
  	num = varargin{2};
  	val = varargin{3};
		gms.physicalvolume{num}=val;
	case 'comments'
  	val = varargin{2};
		gms.comments=val;
	otherwise
		warning('property not found');
end
