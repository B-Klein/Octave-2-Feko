## -*- texinfo -*-
## @deftypefn  {Function File} {} Feko3DShapes ()
## @deftypefnx {Function File} {} Feko3DShapes (@var{s})
## Create a 3DFekoShape made up of fekoshapes @var{s} as coefficient vector.
## @end deftypefn

function s3d = Feko3DShapes (s,name)

	if (nargin == 0)
		s3d.fekoshapes{1} = @FekoShapes ('name');
		s3d.name = 'name3d';
	elseif (nargin == 1)
		s3d.name = 'name3d';
		if (isa (s, "FekoShapes"))
			s3d.fekoshapes{1} = s;
		elseif(ischar(s))
			s3d.name = s;
			s3d.fekoshapes = [];
		else% 
			error ("Feko3DShapes: expecting fekoshapes or name as input argument");
		end
	elseif (nargin == 2)
		s3d.name = name;
		if (isa (s, "FekoShapes"))
			s3d.fekoshapes{1} = s;
		else
			error ("Feko3DShapes: expecting fekoshapes as input argument");
		end
	else
		print_usage ();
	end
	s3d = class (s3d, "Feko3DShapes");
endfunction
