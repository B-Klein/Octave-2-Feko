function F = IP(F, Wr, Tl, Ws, Cbl, Ttl)

	% function F = IP(F,[Wr Tl]); 
	%
	% Sets the meshing parameters
	%
	% INPUT
	% 	Wr 	: Radius of wire segment
	%		Tl 	: Maximum triangle edge length
	%		Ws 	: Maximum wire segment length
	%   Cbl : Maximum cuboid edge length 
	%	  Ttl	: Maximum tetrahedral edge length
	%
	% The following paragraph is taken (and corresponding previous information) from :
	% User’s Manual
	% Suite 6.1.1
	% December 2011
	% Copyright 1998 – 2011: EM Software & Systems-S.A. (Pty) Ltd
	% 32 Techno Avenue, Technopark, Stellenbosch, 7600, South Africa
	% Tel: +27-21-880-1880, Fax: +27-21-880-1936
	% E-Mail: feko@emss.co.za
	% WWW: http://www.feko.info
	%
	% "With this card a number of parameters that define the meshing parameters or also the wire radius
	% are set.
	% Parameters:
	% Radius of wire segment: Segment radius in m (it is scaled by the SF card if used).
	% Maximum triangle edge length: Maximum edge length of triangular elements in m (it is scaled by the
	% SF card).
	% Maximum wire segment length: Maximum segment length for wire segments in m (it is scaled by the
	% SF card).
	% Maximum cuboid edge length: Maximum edge length of cuboidal volume elements for dielectrics (vol-
	% ume equivalence principle of the MoM) in m (it is scaled by the SF card).
	% Maximum tetrahedral edge length: Maximum edge length of tetrahedral volume elements (FEM) in m
	% (it is scaled by the SF card).
	% The IP card only affects the commands following it, i.e. it has to be declared prior to the cards
	% that define segments, triangles or cuboids.
	% It is possible to use more than one IP card in a file. This is necessary when a finer mesh is
	% required in certain parts or when different radii occur in the geometry. For any command (e.g.
	% the BL card) the previous IP card is applicable.
	% Regarding the meshing, certain rules apply relating the element size (see section 13.2.2) to the
	% wavelength etc."
	%
	%
	if ~ischar(Wr), Wr = num2str(Wr); else Wr = ['#' Wr]; end
	if ~ischar(Tl), Tl = num2str(Tl); else Tl = ['#' Tl]; end
	if ~ischar(Ws), Ws = num2str(Ws); else Ws = ['#' Ws];end
	if ~ischar(Cbl), Cbl = num2str(Cbl); else Cbl = ['#' Wr];end
	if ~ischar(Ttl), Ttl = num2str(Ttl); else Ttl = ['#' Wr];end

	F.IP = ['IP:  :  :  :  :  : ' Wr ' : ' Tl ' : ' Ws ' : ' Cbl ' : ' Ttl];
	% F.IP = ['IP                            ' num2str(Wr) '      ' num2str(Tl) '       ' num2str(Ws) '       ' num2str(Cbl) '       ' num2str(Ttl)];
