function F = DZ(F, s1,s2,s3,s4,ang, maxarc, med, LA, varargin) 

	% F = DZ(F, s1,s2,s3,s4,ang, maxarc, medium, LA) 
	% F = DZ(F, s1,s2,s3,s4,ang, maxarc, 'd', LA, relpermitivity, conductivity, density, tanalpha) 
	% F = DZ(F, s1,s2,s3,s4,ang, maxarc, 'm', LA, relpermability, tanalphau) 
	% 
	% This card is used to create a cylindrical shell, meshed into cuboidal elements, for solutions using
	% the volume equivalence principle in the MoM. The meshing parameters as set at the IP card are
	% used, and the medium as set at the ME card is assigned to all created cuboidal elements.
	%
	% INPUT
	% S2--- |	|
	% |		  | |
	% S1---S3 S4
	%
	% S1, S2: The start and end points, respectively, of the cylinder axis.
	% S3, S4: Points on the inside and outside, respectively, of the shell.
	% ang (The angle φ): The angle of the cylindrical segment in degrees.
	% maxarc (Maximum cuboid edge length on arc): Maximum edge length of the cuboids along the arc in m
	% 	(is scaled by the SF card). If this parameter is left empty, the value specified
	% 	with the IP card is used.
	% med : | 'dielectric' 'd' | 'magnetic' 'm' | 'both' 'b' |
	%		Choose the medium: Select here whether the cylindrical shell is dielectric or magnetic or both
	%		(this is always with respect to the environment, e.g. if the relative permittivity r of the cuboid
	% 	material differs from the environment, then this is a dielectric
	% 	cylinder).
	% 
	% Old format (with medium parameters): For a detailed description of this parameter please see the QU
	% card (see section 11.40).
	%
	% Dielectric bodies treated with the volume equivalence principle (using cuboids) cannot be used
	% simultaneously with dielectric bodies treated with the surface equivalence principle or the FEM
	% or with special Green’s functions.
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

	if ~ischar(s1), s1 = num2str(s1); end
	if ~ischar(s2), s2 = num2str(s2); end
	if ~ischar(s3), s3 = num2str(s3); end
	if ~ischar(s4), s4 = num2str(s4); end
	if ~ischar(ang), ang = num2str(ang); else ang = ['#' ang]; end
	if ~ischar(maxarc), maxarc = num2str(maxarc); else maxarc = ['#' maxarc]; end

	switch med, case{'dielectric', 'd'}, med=1; case{'magnetic', 'm'},med=2; case{'both', 'b'}, med=3; otherwise, med=[];end
	
	try, ind = size(F.DZ)(2)+1; catch, ind=1; end

	if exist('LA'), F.DZ{ind} = ['LA: ' LA]; ind=ind+1; end % adds a label

	if isempty(varargin),
		F.DZ{ind} = ['DZ: ' s1 ' : ' s2 ' : ' s3 ' : ' s4 ' : ' num2str(med) ' : ' ang ' : ' maxarc];
	elseif abs(med-1)<tol,
		perm = varargin{1};
		condu = varargin{2};
		dens =varargin{3};
		tana = varargin{4};
		if ~ischar(perm), perm = num2str(perm); else perm = ['#' perm]; end
		if ~ischar(condu), condu = num2str(condu); else condu = ['#' condu]; end
		if ~ischar(dens), dens = num2str(dens); else dens = ['#' dens]; end
		if ~ischar(tana), tana = num2str(tana); else tana = ['#' tana]; end

		F.DZ{ind} = ['DZ: ' s1 ' : ' s2 ' : ' s3 ' : ' s4 ' :  : ' ang ' : ' maxarc ' : ' perm '  : ' condu ' : ' dens ' :  :  : ' tana];
	elseif abs(med-2)<tol,
		perm = varargin{1};
		tanau = varargin{2};
		if ~ischar(perm), perm = num2str(perm); else perm = ['#' perm]; end
		if ~ischar(tanau), tanau = num2str(tanau); else tanau = ['#' tanau]; end

		F.DZ{ind} = ['DZ: ' s1 ' : ' s2 ' : ' s3 ' : ' s4 ' :  : ' ang ' : ' maxarc ' :  :  :  : ' perm ' : ' tanau];
	else
		error('incorrect usage of DZ card');
	end


