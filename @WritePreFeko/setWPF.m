function F = setWPF(F,varargin)


prop=varargin{1};
switch prop
	case 'filename'
  	val=varargin{2};
		F.filename=val;
	otherwise
		warning('property not found');
end
