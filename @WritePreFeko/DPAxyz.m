function [F] = DPAxyz(F, name, xyz, NurbW)

	% function [F] = DPAxyz(F, name, xyz, NurbW)
	%
	% Creates an array of points with index xyz(k,:)
	%
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
	%
	
	if iscell(xyz),
		for n=1:size(xyz)(1)
			% if ~ischar(xyz{n,1}), x = num2str(xyz{n,1}); else x = ['#' xyz{n,1}]; end
			if ~exist('NurbW'),
				F = DP(F, [name '[' num2str(n,writepr()) ']'], xyz{n,1}, xyz{n,2}, xyz{n,3}, []);
			else
				if ~ischar(NurbW(n)), NurbW(n) = num2str(NurbW(n),writepr()); else NurbW(n) = ['#' NurbW(n)]; end
				F = DP(F, [name '[' num2str(n,writepr()) ']'], xyz{n,1}, xyz{n,2}, xyz{n,3}, NurbW(n));
			end
		end
	else
		for n=1:size(xyz)(1)
			if ~exist('NurbW'),
				F = DP(F, [name '[' num2str(n,writepr()) ']'], xyz(n,1), xyz(n,2), xyz(n,3), []);
			else
				if ~ischar(NurbW(n)), NurbW(n) = num2str(NurbW(n), writepr()); else NurbW(n) = ['#' NurbW(n)]; end
				F = DP(F, [name '[' num2str(n,writepr()) ']'], xyz(n,1), xyz(n,2), xyz(n,3), NurbW(n));
			end

		end
	end
