## -*- texinfo -*-
## @deftypefn  {Function File} {} gmshSurf ()
## @deftypefnx {Function File} {} gmshSurf (@var{filename})
## @deftypefnx {Function File} {} gmshSurf (@var{filename}, @var{directory})
## Create a gmshSurf object, used to run method of moment code
##
## @example
## gmshSurf (filename, directory)
## @end example
##
## @noindent
##
## @end deftypefn
function gms = gmshSurf(varargin) %surface

	nvarargin=length(varargin);
	if nvarargin<1  || isempty(varargin{1,1}), dpath=tmpnam; else, dpath=varargin{1,1}; end

	% Set default fields
	gms.dpath=dpath; % full path and filename /home/user/test.geo
	gms.pnts=[];
	gms.pntsC={};
	gms.pN=0;
	gms.pNC=0;
	gms.lines=[];
	gms.lineloops=[];
	gms.surfaces=[];
	gms.surfaceloops=[];
	gms.volume=[];
	gms.physicalline={};
	gms.physicalsurface={};
	gms.physicalvolume={};
	gms.comments=[];
	% gms.compoundvolume=[];
	gms.pointINsurfaces=[];
	gms.periodicpoints=[];
	%	gms.spline=[];
	%	gms.bspline=[];
	
	% Set default fields
	% gms.dpath=dpath;
	%	gms.pnts;
	%	gms.pN=0;
	%	gms.lines=[];
	% gms.lineloops=[];
	% gms.surfaces=[];
	%	gms.spline=[];
	%	gms.bspline=[];

	gms = class (gms, "gmshSurf");
end
