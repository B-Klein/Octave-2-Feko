function [F] = DPA(F, name, x, y, z, NurbW)

	% function [F] = DPA(F, name, x, y, z, NurbW)
	%
	% Creates an array of points with index x(k) y(k) z(k)
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
	 Point name: Name of the point.
	% X, Y, Z coordinate: Cartesian coordinates of the point in m (is scaled by the SF card).
	% Nurb control point weight: The weight of the control point when this point is used with the NU card
	% (NURBS surfaces). If the field is empty, it defaults to 1."
	
	for n=1:length(x)
		% if ~ischar(x(n)), x(n) = num2str(x(n)); else x(n) = ['#' x(n)]; end
		% if ~ischar(y(n)), y(n) = num2str(y(n)); else y(n) = ['#' y(n)]; end
		% if ~ischar(z(n)), z(n) = num2str(z(n)); else z(n) = ['#' z(n)]; end
		if ~exist('NurbW'),
			F = DP(F, [name '[' num2str(n) ']'], x(n), y(n), z(n), []);
		else
			if ~ischar(NurbW(n)), NurbW(n) = num2str(NurbW(n)); else NurbW(n) = ['#' NurbW(n)]; end
			F = DP(F, [name '[' num2str(n) ']'], x(n), y(n), z(n), NurbW(n));
		end

	end
	% F = DP(ch, 

	% if length(F.DPA), ind = size(F.DPA)(2)+1; else ind =1; end

	% F.IP = ['IP:  :  :  :  :  : ' Wr ' : ' Tl ' : ' Ws ' : ' Cbl ' : ' Ttl];
	% F.DPA{ind} = ['DPA: ' name ' :  :  :  :  : ' x ' : ' y ' : ' z ' : ' NurbW];
	% 
	% end
