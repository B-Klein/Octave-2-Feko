function F = LE(F, Mode, varargin)

	% INPUT
	%
	%	Mode : 	'regions' 'Regions' 'R' 'r'
	%					'edge' 'Edge' 'E' 'e'
	%					'micro' 'Micro' 'M' 'm'
	%
	% 'Regions':
	% LE(F, 'r', Negsides, Possides, ZI)
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
	% ified by the last IP card prior to the LE card. Along the arcs, accurate modelling of the geometry
	% may require finer segmentation and the values Maximum edge length (bottom) and Maximum
	% edge length (top) specify the maximum edge length along the corresponding arcs. Maximum
	% edge length (top) is only used when a truncated cone is created. If either of these values is not
	% specified the length specified with the IP card will be used on the corresponding arc.


	try, ind = size(F.LE)(2)+1; catch, ind=1; ind
	end


		 % if ~ischar(s1), s1 = num2str(s1,writepr()); end
	switch Mode
		case {'regions' 'Regions' 'R' 'r'}	% LE(F, 'r', Negsides, Possides, Zr, ZI)

			Negside = varargin{1};
			Posside = varargin{2};
			Zr = varargin{3};
			if ~ischar(Zr), Zr = num2str(Zr,writepr()); end
			Zi = varargin{4};
			if ~ischar(Zi), Zi = num2str(Zi,writepr()); end
		
			Nelements = length(Negside);
 
			LEstr = ['LE: ' Negside{1} ' : ' Posside{1} ' : 0 :  : ' num2str(Nelements) ' : ' Zr ' : ' Zi];
			for n=2:Nelements
				neg = Negside{n};
				if ~ischar(neg), neg = num2str(neg,writepr()); end
				pos = Posside{n};
				if ~ischar(pos), pos = num2str(pos,writepr()); end

				LEstr = [LEstr "\n" '  : ' neg ' : ' pos];
			end
	
			case {'edge' 'Edge' 'E' 'e'} % LE(F, 'e', Negsides, Zr, ZI)

			Negside = varargin{1};
			Zr = varargin{2};
			if ~ischar(Zr), Zr = num2str(Zr,writepr()); end
			Zi = varargin{3};
			if ~ischar(Zi), Zi = num2str(Zi,writepr()); end
		
			Nelements = length(Negside);

			LEstr = ['LE: ' Negside{1} ' : ' [] ' : 2 :  : ' num2str(Nelements) ' : ' Zr ' : ' Zi];

			for n=2:Nelements
				neg = Negside{n};
				if ~ischar(neg), neg = num2str(neg,writepr()); end
				LEstr = [LEstr "\n" '  : ' neg];
			end

		case{'micro' 'Micro' 'M' 'm'}
			error('not implemented yet');

		otherwise
			error('unrecognised mode in LE card');
	end
	%

	% 
	% if exist('LA'), F.LE{ind} = ['LA: ' LA]; ind=ind+1; end % adds a label
	F.LE{ind} = LEstr; 

