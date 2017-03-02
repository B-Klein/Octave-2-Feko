function Gms = set(Gms, varargin)

prop=varargin{1};
switch prop
	case 'name'
  	val = varargin{2};
		Gms.name=val;
	case 'duplicatelines'
  	val = varargin{2};
		Gms.duplicatelines=val;
	otherwise
		warning('property not found');
end
