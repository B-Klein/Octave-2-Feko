function F = SF(F, scale) 

	% With this card the scaling of the geometric data is possible. This is useful for
	% specifying models in a convenient unit (e.g. cm) and specifying a scaling factor
	% once, since internally FEKO uses all dimension related values in metres.
	%
	% Parameters: Modify all dimension related values: If this item is checked all geometrical
	% dimensions are scaled. If unchecked some coordinate values are not scaled (for example
	% the positions of near field calculations, see the list below). This should only be
	% unchecked for backwards compatibility with old input files.  Multiply dimensions with:
	% The scale factor. For example, if this is set to 0.001, all dimensions are entered in
	% mm.  Only one SF card is allowed in the input file. This is global and can be positioned
	% anywhere.  (However, since it is a geometry card it must be before the EG card.)
	% The preceding paragraph is taken (and corresponding previous information) from :
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

	if ~ischar(scale), scale = num2str(scale,writepr()); else scale = ['#' scale]; end

	try, ind = size(F.SF)(2)+1; catch, ind=1; end

	F.SF{ind} = ['SF: 1 :  :  :  :  : ' scale];

