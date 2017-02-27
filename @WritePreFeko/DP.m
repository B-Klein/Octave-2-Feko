function F = DP(F, name, x, y, z, NurbW)

% INPUT
	% 	name 	: Name of the point.
	%		x,y,z	:  Cartesian coordinates of the point in m (is scaled by the SF card).
	%	  NurbW	: The weight of the control point when this point is used with the NU card
	% (NURBS surfaces). If the field is empty, it defaults to 1."
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
	% "With this card points in space are defined. These points are used to define the extent and orien-
	% tation of other geometric entities and to locate excitations.
	% To avoid ambiguity each point is assigned a name (a 5 character string if column based format is
	% used). In the other cards (e.g. BL card) the points are referred to by their names.
	% Parameters:
	% Point name: Name of the point.
	% X, Y, Z coordinate: Cartesian coordinates of the point in m (is scaled by the SF card).
	% Nurb control point weight: The weight of the control point when this point is used with the NU card
	% (NURBS surfaces). If the field is empty, it defaults to 1."

	if ~ischar(x), x = num2str(x,writepr()); else x = ['#' x]; end
	if ~ischar(y), y = num2str(y,writepr()); else y = ['#' y]; end
	if ~ischar(z), z = num2str(z,writepr()); else z = ['#' z]; end
	if ~exist('NurbW'), NurbW=[];elseif ~ischar(NurbW), NurbW = num2str(NurbW); else NurbW = ['#' NurbW]; end

	if length(F.DP), ind = size(F.DP)(2)+1; else ind =1; end

	% F.IP = ['IP:  :  :  :  :  : ' Wr ' : ' Tl ' : ' Ws ' : ' Cbl ' : ' Ttl];
	F.DP{ind} = ['DP: ' name ' :  :  :  :  : ' x ' : ' y ' : ' z ' : ' NurbW];
