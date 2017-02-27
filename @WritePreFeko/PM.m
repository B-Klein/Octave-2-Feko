function F = PM(F,pnts, msh, varargin)

	% F = PM(F,pnts, msh, [Npnts, ipnts, iNpnts LA]) 
	% F = PM(F,pnts, msh, [Npnts, LA])
	% As variables to arrays and vectors
	% or as cell arrays of points:
	% F = PM(F,pnts, msh, [LA]) 
	%
	% A surface mesh of triangles in the shape of a polygon is created by using this card. This card also
	% allows the specification of interior mesh points. This card should generally be used in favour of
	% other cards that create flat surface meshes with straight edges.
	%
	% F = PM(F,pnts, msh, Npnts, LA)
	% pnts : name of point array
	% msh : name of variable array
	% Npnts : number of points to use in array (optional)
	% LA : label (optional)
	%
	% F = PM(F,pnts, msh, ipnts, LA)
	% pnts : list of points, up to 13, {p1, p2 ...}
	% ipnts : internal points
	% msh  : associated list of meshed points (optional)
	% LA : label (optional)
	% [optional inputs]
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



	try, ind = size(F.PM)(2)+1; catch, ind=1; end

	if ~iscell(pnts),
		Npnts = varargin{1};
		if ~ischar(Npnts), Npnts = num2str(Npnts); else Npnts = ['#' Npnts]; end
		if length(varargin)<2,
			% F = PM(F,pnts, msh, [Npnts])
			if ~isempty(msh), msh = [' :  :  : #' msh]; else msh=[]; end
			F.PM{ind} = ['PM: -1 : ' pnts ' : ' Npnts msh];
		elseif length(varargin)<3
			% F = PM(F,pnts, msh, [Npnts, LA])
			LA = varargin{2};
			if exist('LA') && ~isempty(LA), F.PM{ind} = ['LA: ' LA]; ind=ind+1; end % adds a label
			if ~isempty(msh), msh = [' :  :  : #' msh]; else msh=[]; end
			F.PM{ind} = ['PM: -1 : ' pnts ' : ' Npnts msh];
		elseif length(varargin)<4
			% F = PM(F,pnts, msh, [Npnts, ipnts, iNpnts])
			ipnts = varargin{2};
			iNpnts = varargin{3}; 
			if ~ischar(iNpnts), iNpnts = num2str(iNpnts); else iNpnts = ['#' iNpnts]; end
			if ~isempty(msh), msh = [' : #' msh]; end
			ipnts = [' : ' ipnts ' : ' iNpnts msh];
			F.PM{ind} = ['PM: -1 : ' pnts ' : ' Npnts ipnts];
		else
			% F = PM(F,pnts, msh, [Npnts, ipnts, iNpnts, LA])
			LA = varargin{4};
			if exist('LA') && ~isempty(LA), F.PM{ind} = ['LA: ' LA]; ind=ind+1; end % adds a label

			ipnts = varargin{2};
			iNpnts = varargin{3}; 
			if ~ischar(iNpnts), iNpnts = num2str(iNpnts); else iNpnts = ['#' iNpnts]; end
			if ~isempty(msh), msh = [' : #' msh]; end
			ipnts = [' : ' ipnts ' : ' iNpnts msh];
			F.PM{ind} = ['PM: -1 : ' pnts ' : ' Npnts ipnts];
		end
		%%%
	else % F = PM(F,pnts, msh, [LA]) % put in ipntns sometime...
% 		disp('its a cell');
		if abs(2-length(varargin))<tol,
			% need to set the 5th point as 1 for some stupid reason
			indp=1;
			for n=1:length(pnts)
				if abs(n-5)<tol, pntstmp{n}='1'; indp=indp+1; end
				pntstmp{indp}=pnts{n}; indp=indp+1;
			end
			if length(pntstmp)<5,
				for n=length(pntstmp):5
					if abs(n-5)<tol,
						pntstmp{n}='1'; indp=indp+1; 
					else
						pntstmp{indp}=[]; indp=indp+1;
					end
				end
			end
			pnts=pntstmp;

			if exist('msh') && ~isempty(msh), pnts{14} = []; end
			 
			for n=1:length(pnts)
				if abs(n-1)<tol, PNTS = pnts{n}; else, PNTS = [PNTS ' : ' pnts{n}]; end
			end
			MSH=[];
			if exist('msh') && ~isempty(msh),
				for n=1:length(msh)
					if ~ischar(msh{n}), msh{n} = num2str(msh{n}); else msh{n} = ['#' msh{n}]; end
					MSH = [MSH ' : ' msh{n}];
				end
			end
			ipnts=varargin{1};
			for n=1:length(ipnts)
				if abs(n-1)<tol, IPNTS = ['  : ' ipnts{1}]; else, IPNTS = [IPNTS ' : ' ipnts{n}]; end
			end
			% try, ind = size(F.PM)(2)+1; catch, ind=1; end
			LA=varargin{2};
			if isempty(LA),
				F.PM{ind} = ['PM: ' PNTS MSH ]; ind=ind+1;
				F.PM{ind} = [IPNTS];ind=ind+1;
			else
				if exist('LA') && ~isempty(LA), F.PM{ind} = ['LA: ' LA]; ind=ind+1; end % adds a label
				F.PM{ind} = ['PM: ' PNTS MSH ];ind=ind+1; 
				F.PM{ind} = [IPNTS];ind=ind+1;
			end


		else
			orgpnts=length(pnts);
			if exist('msh') && ~isempty(msh), 
				if length(pnts)<5, 
					pnts{14} = []; 
				else
					pnts{13} = []; 
				end
			end
			for n=1:length(pnts)
				if abs(n-5)<tol && orgpnts>4, % disp(['here where n is : ' num2str(n)]);
					% If there are more than 4 points we need to put in a : : space for some unknown
					% reasons????
					PNTS = [PNTS ' : '];
				end
				if abs(n-1)<tol, PNTS = pnts{n}; else, PNTS = [PNTS ' : ' pnts{n}]; end
			end
			MSH=[];
			if exist('msh') && ~isempty(msh),
				for n=1:length(msh)
					if ~ischar(msh{n}), msh{n} = num2str(msh{n}); else msh{n} = ['#' msh{n}]; end
					MSH = [MSH ' : ' msh{n}];
				end
			end
			% try, ind = size(F.PM)(2)+1; catch, ind=1; end
			if isempty(varargin),
				F.PM{ind} = ['PM: ' PNTS MSH ];
			elseif length(varargin)<2
				LA = varargin{1};
				if exist('LA') && ~isempty(LA), F.PM{ind} = ['LA: ' LA]; ind=ind+1; end % adds a label
				F.PM{ind} = ['PM: ' PNTS MSH ];
			end
		end %if abs(2-length(varargin))<tol,

	end
