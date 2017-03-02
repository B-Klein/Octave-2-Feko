## -*- texinfo -*-
## @deftypefn  {Function File} {} Octave2Dpic ()
## @deftypefnx {Function File} {} Octave2Dpic (@var{L})
## Create a 3DFekoShape made up of OLine @var{s} as coefficient vector.
## @end deftypefn

function Op = Octave2Dpic (L,name)

	if (nargin == 0)
		Op.OLines{1} = @OLine ('name');
		Op.name = 'pic2d';
	elseif (nargin == 1)
		Op.name = 'pic2d';
		if (isa (L, "OLine"))
			Op.OLines{1} = L;
		elseif(ischar(L))
			Op.name = L;
			Op.OLines = [];
		else% 
			error ("Octave2Dpic: expecting OLine or name as input argument");
		end
	elseif (nargin == 2)
		Op.name = name;
		if (isa (L, "OLine"))
			Op.OLines{1} = L;
		else
			error ("Octave2Dpic: expecting OLine as input argument");
		end
	else
		print_usage ();
	end
	Op.texfile=[];
	Op.texpath=[];
	Op.header = '';
	Op.footer = '';

	Op = class (Op, "Octave2Dpic");
endfunction
