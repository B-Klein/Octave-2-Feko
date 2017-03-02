## -*- texinfo -*-
## @deftypefn  {Function File} {} gmsh ()
## @deftypefnx {Function File} {} gmsh (@var{filename})
## @deftypefnx {Function File} {} gmsh (@var{filename}, @var{directory})
## Create a gmsh object, used to run method of moment code
##
## @example
## gmsh (filename)
## @end example
##
## @noindent
##
## @end deftypefn
function Gms = gmsh(name,gms) %typ, len, modes, %rad %a,b

	Gms.duplicatelines=[];

	if (nargin == 0)
		Gms.gmsurfs{1} = @gmshSurf ('name');
		Gms.name = 'name3d';
	elseif (nargin == 1)
		Gms.name = name; 
		Gms.gmsurfs = [];
	elseif (nargin == 2)
		Gms.name = name;
		if (isa (gms, "gmshSurf"))
			Gms.gmsurfs{1} = gms;
		else
			error ("gmsh: expecting gmsurfs as input argument");
		end
	else
		print_usage ();
	end
	Gms = class (Gms, "gmsh");
end
