## -*- texinfo -*-
## @deftypefn  {Function File} {} FekoShapes ()
## @deftypefnx {Function File} {} FekoShapes (@var{shapename})
% ## @deftypefnx {Function File} {} FekoShapes (@var{filename}, @var{directory})
## Create a FekoShapes object to give to writeprefeko
##
## @example
## FekoShapes (shapename)
## @end example
##
## @noindent
## 
## @end deftypefn
function S = FekoShapes(shapename)
	switch nargin
		case{0}
			S.shapename = getfilename('DefaultShapename'); 
		case{1}
			S.shapename = shapename; 
		otherwise
			print_usage ();
	end
	% Set default fields
	S.Numpoints=[];
	S.points=[];
	S.Numedgepoints=[];
	S.edgepoints=[];
	S.curvepointsi=[];
	S.curvepointso=[];
	S.diskpointsi=[];
	S.diskpointso=[];
	S.diskangle=[];
	S.curveanglestarttop=[];%0;
	S.curveangletop=[];
	S.curveanglestartbot=[];%0;
	S.curveanglebot=[];
	S.label=[];
	S.inflag=[]; % set 1 for inward!
	S.material=[];

	S.edgelabels=[];
	S.shapetype='plate'; % possible to use curve, or disk as well


	S = class (S, "FekoShapes");
end
