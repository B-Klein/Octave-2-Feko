function F = PH(F, s1,s2,s3,s4,s5, maxedge, scale, LA)

	% F = PH(F, s1,s2,s3,s4,s5, maxedge, scale, LA)
	% 
	% This card creates a triangular or quadrangular plate with a circular or elliptical hole as shown in
	% the card.
	%
	% INPUT
	%
	% (S3)     S4
	% S1 -S5-- S2
	% 
	% S1: The corner where the hole is located (also the hole’s centre).
	% S2: The second corner of the plate.
	% S3: The third corner of the plate. If this field is left empty, a triangular plate is
	% created.
	% S4: The fourth corner of the plate.
	% S5: A point on the line S1–S2 that forms the starting point of the circle or ellipse
	% bordering the hole. The special case where S5 is identical to S2 is supported,
	% but due to the resulting geometry yields triangles with very small angles
	% Max. edge length on curve: The maximum edge length of the triangles along the edge of the hole in m
	% (is scaled by the SF card). If this parameter is left empty, the value specified
	% with the IP card is used.
	% b
	% Scale second half axis: If this parameter is empty or is set to 1, a circular hole is created. If set to a , an
	% b
	% elliptical hole is created. Here a gives the ratio of the two half axes, where a
	% is the distance S1–S3. It is not recommended to generate the plate with a CAD
	% system if the elliptical hole has an extremely small or extremely large axial
	% ratio as the distortion formulation used in PREFEKO may fail for such cases.
	% scale: If this parameter is empty or is set to 1, a cone with a circular cross section is 
	% 	created. If set to b/a , a cone with an elliptical cross section is created. Here b/a
	% 	gives the ratio of the two half axes, where a is the distance S1–S3. It is recom-
	% 	mended to generate elliptical cones with extremely small or extremely large
	% 	axial ratios with a CAD system as the distortion formulation used in PREFEKO
	% 	may fail in these cases.
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
	if ~ischar(s5), s5 = num2str(s5); end
	if ~ischar(maxedge), maxedge = num2str(maxedge); else maxedge = ['#' maxedge]; end
	if ~exist('scale'), scale=[]; elseif ~ischar(scale), scale = num2str(scale); else scale = ['#' scale]; end

	try, ind = size(F.PH)(2)+1; catch, ind=1; end

	if exist('LA'), F.PH{ind} = ['LA: ' LA]; ind=ind+1; end % adds a label

	F.PH{ind} = ['PH: ' s1 ' : ' s2 ' : ' s3 ' : ' s4 ' : ' s5 ' :  : ' maxedge ' :  : ' scale];
