function F = ZY(F, s1,s2,s3,ang,edgelen,scale,inflag,LA,MEzy)
	
	% INPUT
	%   S2
	%   S1 __ S3
	% 	s1: The start point of the axis.
	% 	s2: The end point of the axis.
	% 	s3: A point on the corner of the cylindrical segment.
	% 	Normal vector directed: The triangles can be created so that the normal vector is points Outward or
	% 	Inward.
	% 	ang : The angle in degrees, which is subtended by the cylindrical arc.
	% 	Maximum edge length on arc: Maximum edge length of the triangles along the curved side in m (is
	% 	scaled by the SF card). If this parameter is left empty, the value specified with
	% 	the IP card is used.
	% 	scale: If this parameter is empty or is set to 1, a circular cylinder is created. If set to b
	% 	b/a, an elliptical cylinder is created. Here a gives the ratio of the two half axes,
	%	 where a is the distance S1–S3. It is not recommended to generate elliptical
	% 	cylinder with extremely small or extremely large axial ratios with a CAD system
	% 	as the distortion formulation used in PREFEKO may fail in these cases.	
	% 	inflag : set to 0 for outward facing vector, 1 for inward
	%
	% 	The following paragraph is taken (and corresponding previous information) from :
	% User’s Manual
	% Suite 6.1.1
	% December 2011
	% Copyright 1998 – 2011: EM Software & Systems-S.A. (Pty) Ltd
	% 32 Techno Avenue, Technopark, Stellenbosch, 7600, South Africa
	% Tel: +27-21-880-1880, Fax: +27-21-880-1936
	% E-Mail: feko@emss.co.za
	% WWW: http://www.feko.info
	%
	% With this card a surface mesh in the form of a cylindrical segment can be generated.
	%  ...
	% For an orthogonal cylinder (i.e. the lines S1–S2 and S1–S3 are perpendicular), the segmented
	% area (shaded in the figure of the cylinder) is obtained by rotating the point S3 around the axis
	% S1–S2 through φ. For φ=360◦ a full cylinder is obtained.
	% An oblique cylinder (i.e. the circular or elliptical rim is not perpendicular to the axis) can also
	% be created. Then S1–S2 still represents the axis, but the top and bottom planes of the rims are
	% defined by planes perpendicular to the plane defined by the three points S1, S2, S3, and parallel
	% to the line S1–S3.

	if ~ischar(s1), s1 = num2str(s1,writepr()); end
	if ~ischar(s2), s2 = num2str(s2,writepr()); end
	if ~ischar(s3), s3 = num2str(s3,writepr()); end
	if ~ischar(ang), ang = num2str(ang,writepr()); else ang = ['#' ang]; end
	if ~ischar(edgelen), edgelen = num2str(edgelen,writepr()); else edgelen = ['#' edgelen]; end
	if ~exist('scale'), scale = []; end
	if ~ischar(scale), scale = num2str(scale); else scale = ['#' scale]; end
	if ~exist('inflag'), inflag = []; end
	if ~ischar(inflag), inflag = num2str(inflag); else inflag = ['#' inflag]; end

	if length(F.ZY), ind = size(F.ZY)(2)+1; else ind =1; end
	if exist('MEzy'), F.ZY{ind} = ME(MEzy); ind=ind+1; end % adds a MEzydium property
	if exist('LA') && ~isempty(LA), F.ZY{ind} = ['LA: ' LA]; ind=ind+1; end % adds a label

	if isempty(inflag), inflag=''; end
	if isempty(ang), ang=''; end
	if isempty(edgelen), edgelen=''; end
	if isempty(scale), scale=''; end

	F.ZY{ind} = ['ZY: ' s1 ' : ' s2 ' : ' s3 ' : ' inflag ' :  : ' ang ' : ' edgelen ' : ' scale ];
