## -*- texinfo -*-
## @deftypefn  {Function File} {} OLine ()
## @deftypefnx {Function File} {} OLine (@var{linename})
% ## @deftypefnx {Function File} {} OLine (@var{filename}, @var{directory})
## Create a OLine object to give to writeprefeko
##
## @example
## OLine (linename)
## @end example
##
## @noindent
## 
## @end deftypefn
function L = OLine(linename)
	switch nargin
		case{0}
			L.linename = ''; %Set to blank 
		case{1}
			L.linename = linename; 
		otherwise
			print_usage ();
	end
	% Set default fields
	L.typ = 'straight';
	L.cords = [];
	L.label = [];
	L.options = [];

	L = class (L, "OLine");
end
