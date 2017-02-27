function F = KK(F, s1,s2,s3,s4,angBotStrt,angBotEnd,angTopStrt,angTopEnd,edgelenBot,edgelenTop,	inflag, scale, La, MEkr)

% INPUT
%			S3
% 	/  |
% S4	 |	 
% |		 |
% S2 __S1
%
% s1: The start point of the axis of the cone (the centre of the base).
% s2: The end point of the axis (the tip of the cone, or the centre point of the circle	when creating a conical section.
% s3: A point on the radius of the base.
% s4: If this parameter is defined, the cone is cut off at the top; if not the cone has a	sharp tip. This point must be in the plane given by S1, S2 and S3.
%	angBotStrt: The angle φ from the plane S2–S1–S3 at which the bottom of the cone	should start.
% angBotEnd : The angle φ from the plane S2–S1–S3 at which the bottom of the cone	should end.
% angTopStrt: The angle φ from the plane S2–S1–S3 at which the top of the cone should	start.
% angTopEnd:The angle φ from the plane S2–S1–S3 at which the top of the cone should end.
% edgelenBot: The maximum edge length of the triangles along the base arc — in	the plane containing S1 — of the cone. (This value is in m and is scaled by the	SF card). If this parameter is left empty, the value specified with the IP card is	used.
% edgelenTop: This value only applies if S4 is specified and gives the maximum edge	length of the triangles along the top arc — in the plane containing S2 — of the	cone. (This value is in m and is scaled by the SF card). If this parameter is left empty, the value specified with the IP card is used.
% inflag:The triangles can be created so that the normal vector points Outward (away from the axis) or Inward (to the inside of the cone).
% scale: If this parameter is empty or is set to 1, a cone with a circular cross section is created. If set to b/a , a cone with an elliptical cross section is created. Here b/a	gives the ratio of the two half axes, where a is the distance S1–S3. It is recommended to generate elliptical cones with extremely small or extremely large	axial ratios with a CAD system as the distortion formulation used in PREFEKO
% 	may fail in these cases.inflag : set to [] for outward facing vector, 1 for inward
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
% ified by the last IP card prior to the KK card. Along the arcs, accurate modelling of the geometry
% may require finer segmentation and the values Maximum edge length (bottom) and Maximum
% edge length (top) specify the maximum edge length along the corresponding arcs. Maximum
% edge length (top) is only used when a truncated cone is created. If either of these values is not
% specified the length specified with the IP card will be used on the corresponding arc.

	if ~ischar(s1), s1 = num2str(s1,writepr()); end
	if ~ischar(s2), s2 = num2str(s2,writepr()); end
	if ~ischar(s3), s3 = num2str(s3,writepr()); end
	if ~ischar(s4), s4 = num2str(s4,writepr()); end
	if ~ischar(angBotStrt), angBotStrt = num2str(angBotStrt,writepr()); else angBotStrt = ['#' angBotStrt]; end
	if ~ischar(angBotEnd), angBotEnd = num2str(angBotEnd,writepr()); else angBotEnd = ['#' angBotEnd]; end
	if ~ischar(angTopStrt), angTopStrt = num2str(angTopStrt,writepr()); else angTopStrt = ['#' angTopStrt]; end
	if ~ischar(angTopEnd), angTopEnd = num2str(angTopEnd,writepr()); else angTopEnd = ['#' angTopEnd]; end
	if ~ischar(edgelenBot), edgelenBot = num2str(edgelenBot,writepr()); else edgelenBot = ['#' edgelenBot]; end
	if ~ischar(edgelenTop), edgelenTop = num2str(edgelenTop,writepr()); else edgelenTop = ['#' edgelenTop]; end
	if ~exist('inflag'), inflag=[]; end
	if ~ischar(inflag), inflag = num2str(inflag); else inflag = ['#' inflag]; end
	if ~exist('scale'), scale=[]; end
	if ~ischar(scale), scale = num2str(scale); else scale = ['#' scale]; end

	try, ind = size(F.KK)(2)+1; catch, ind=1; end

	if exist('MEkr') && ~isempty(MEkr), F.KK{ind} = ME(MEkr); ind=ind+1; end % adds a MEkrdium property
	if exist('La') && ~isempty(La), F.KK{ind} = ['LA: ' La]; ind=ind+1; end % adds a label

	if isempty(inflag), inflag=''; end
	if isempty(angBotEnd), angBotEnd=''; end
	if isempty(edgelenTop), edgelenTop=''; end
	if isempty(edgelenBot), edgelenBot=''; end
	if isempty(scale), scale=''; end
	if isempty(angBotStrt), angBotStrt=''; end
	if isempty(angTopStrt), angTopStrt=''; end

	F.KK{ind} = ['KK: ' s1 ' : ' s2 ' : ' s3 ' : ' s4 ' : ' inflag ' : ' angBotEnd ' : ' edgelenTop...
		' : ' edgelenBot ' :  : ' scale ' : ' angTopEnd ' : ' angBotStrt ' : ' angTopStrt];
