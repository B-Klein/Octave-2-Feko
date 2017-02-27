function F = DI(F, varargin) %, s1,s2,s3,s4,angBotStrt,angBotEnd,angTopStrt,angTopEnd,edgelenBot,edgelenTop,	inflag, scale, LA)

	% INPUT
	%
	%	This card can be used to define the frequency dependent or independent material characteristics
	% of a dielectric medium, metallic medium or an impedance sheet. The DI card is used for the
	% MoM/MLFMM when using the surface current or volume current methods, or also for the FEM.
	% Parameters:
	% Material label:
	% Label of the material to be defined.
	% Define dielectric medium: A dielectric medium can be defined by specifying frequency independent
	% parameters, a frequency dependent dielectric model or loading points from a
	% file.
	% Define metallic medium: A metallic medium can be defined by specifying frequency independent pa-
	% rameters or loading points from a file.
	% Define impedance sheet: An impedance sheet can be defined by specifying the frequency independent
	% real and imaginary part or loading points from a file.
	% Source:
	% The medium is defined by means of a wideband model or loading points from
	% a file (see section 3.3.2).
	%
	%
	% Case 1:
	%
	%	function F = DI(F, materiallabel, 'dielectric', WidebandModel [0;1], 'Const', er, 'loss'   ) 
	%
	% The following paragraph is taken (and corresponding previous information) from :
	%
	% User’s Manual
	% Suite 6.1.1
	% December 2011
	% Copyright 1998 – 2011: EM Software & Systems-S.A. (Pty) Ltd
	% 32 Techno Avenue, Technopark, Stellenbosch, 7600, South Africa
	% Tel: +27-21-880-1880, Fax: +27-21-880-1936
	% E-Mail: feko@emss.co.za
	% WWW: http://www.feko.info
	% 
	% A mesh of surface triangles in the shape of a conical section can be created with this card. The
	% cone can also be distorted to have an elliptical cross section. Cones or conical sections with
	% included angles that vary from the top to the bottom, or that do not start in a specified plane,
	% can also be created.
	% ...
	% The fineness of the mesh on the shell’s surface is determined by the maximum edge length spec-
	% ified by the last IP card prior to the DI card. Along the arcs, accurate modelling of the geometry
	% may require finer segmentation and the values Maximum edge length (bottom) and Maximum
	% edge length (top) specify the maximum edge length along the corresponding arcs. Maximum
	% edge length (top) is only used when a truncated cone is created. If either of these values is not
	% specified the length specified with the IP card will be used on the corresponding arc.

	label = varargin{1};
	medium = varargin{2};
  
	try, ind = size(F.DI)(2)+1; catch, ind=1; end

	switch medium
		case{'Dielectric' 'dielectric' 'Diel' 'diel' 'd' 'D'}
 		% DI(F, materiallabel, 'dielectric', WidebandModel [0;1], permitivity er, DImodel, DImodelParameters, Magmodel, MagmodelParameters, massDensity) 
		wdband = varargin{3};
		if(~wdband) error('not implemented'); else

		permi=varargin{4}; if ~ischar(permi), permi = num2str(permi,writepr()); end
		DImodel = varargin{5};
		DImodelParameters = varargin{6};
		Magmodel = varargin{7};
		MagmodelParameters = varargin{8};
		massD = varargin{9}; if ~ischar(massD), massD = num2str(massD,writepr()); end

		switch DImodel
			case{'Constant' 'const' 'c'}
				tanD = DImodelParameters{1}; if ~ischar(tanD), tanD = num2str(tanD,writepr()); end
				conD = DImodelParameters{2}; if ~ischar(conD), conD = num2str(conD,writepr()); end
			otherwise
				error('unknown dielectric model called from DI.m')
		end

		switch Magmodel
			case{'None' 'none' 'n'};
			case{'Constant' 'const' 'c'}
				% tanD = MagmodelParameters{1};
				% conD = MagmodelParameters{2};
				warning('not implemented const mag model, falling back onto none');
			otherwise
				error('unknown dielectric model called from DI.m')
		end
				
			
	F.DI{ind} = ['DI: ' label ' : 0 : -1 :  :  : ' permi ' :  : ' conD ' : ' tanD ' :  : ' massD];
		% ' : ' edgelenBot ' :  : ' scale ' : ' angTopEnd ' : ' angBotStrt ' : ' angTopStrt];

		end
		

		otherwise
			error('unrecognised medium type in DI function');
	end


	% if ~ischar(s1), s1 = num2str(s1); end
	% if ~ischar(s2), s2 = num2str(s2); end
	% if ~ischar(s3), s3 = num2str(s3); end
	% if ~ischar(s4), s4 = num2str(s4); end
	% if ~ischar(angBotStrt), angBotStrt = num2str(angBotStrt,writepr()); else angBotStrt = ['#' angBotStrt]; end
	% if ~ischar(angBotEnd), angBotEnd = num2str(angBotEnd,writepr()); else angBotEnd = ['#' angBotEnd]; end
	% if ~ischar(angTopStrt), angTopStrt = num2str(angTopStrt,writepr()); else angTopStrt = ['#' angTopStrt]; end
	% if ~ischar(angTopEnd), angTopEnd = num2str(angTopEnd,writepr()); else angTopEnd = ['#' angTopEnd]; end
	% if ~ischar(edgelenBot), edgelenBot = num2str(edgelenBot,writepr()); else edgelenBot = ['#' edgelenBot]; end
	% if ~ischar(edgelenTop), edgelenTop = num2str(edgelenTop,writepr()); else edgelenTop = ['#' edgelenTop]; end
	% if ~exist('inflag'), inflag=[]; end
	% if ~ischar(inflag), inflag = num2str(inflag); else inflag = ['#' inflag]; end
	% if ~exist('scale'), scale=[]; end
	% if ~ischar(scale), scale = num2str(scale); else scale = ['#' scale]; end
% 
	% try, ind = size(F.DI)(2)+1; catch, ind=1; end
% 
	% if exist('LA'), F.DI{ind} = ['LA: ' LA]; ind=ind+1; end % adds a label
	% F.DI{ind} = ['DI: ' s1 ' : ' s2 ' : ' s3 ' : ' s4 ' : ' inflag ' : ' angBotEnd ' : ' edgelenTop...
		% ' : ' edgelenBot ' :  : ' scale ' : ' angTopEnd ' : ' angBotStrt ' : ' angTopStrt];
% 
