function F = PB(F, s1,s2,s3,s4,subang,maxtri,LA,MEkr)


% This card can be used to generate a section of a parabolic reflector as shown in the figure on the
% card.
% Parameters:
% S1: The centre of the paraboloid.
% S2: A point perpendicular to the base plane and at any distance above the centre
% point.
% S3: A point on the outer edge of the paraboloid, but on the base plane.
% S4: A point in the plane S2–S1–S3, directly above S3 on the edge of the paraboloid.
% Subtended angle φ: The angle subtended by the arc of the parabolic reflector in degrees.
% Maximum triangle edge length: Maximal edge length of the triangles along the outer edge of the arc in
% m (is scaled by the SF card). If this parameter is left empty, the value specified
% with the IP card is used.
% The radius R of the paraboloid is derived from the distance between the points S1 and S3, as can
% be seen in the figure in the card. The height is determined by the distance between points S3 and
% S4. 
% The focal point f is determined by:
% f = R^2/4h% .
% User’s Manual
% Suite 6.1.1
% December 2011
% Copyright 1998 – 2011: EM Software & Systems-S.A. (Pty) Ltd
% 32 Techno Avenue, Technopark, Stellenbosch, 7600, South Africa
% Tel: +27-21-880-1880, Fax: +27-21-880-1936
% E-Mail: feko@emss.co.za
% WWW: http://www.feko.info

	if ~ischar(s1), s1 = num2str(s1,writepr()); end
	if ~ischar(s2), s2 = num2str(s2,writepr()); end
	if ~ischar(s3), s3 = num2str(s3,writepr()); end
	if ~ischar(s4), s4 = num2str(s4,writepr()); end
	if ~ischar(subang), subang = num2str(subang,writepr()); else subang = ['#' subang]; end
	if exist('maxtri') && ~isempty(maxtri),
		if ~ischar(maxtri), maxtri = num2str(maxtri,writepr()); else maxtri = ['#' maxtri]; end
	else
		maxtri=[];
	end

	try, ind = size(F.PB)(2)+1; catch, ind=1; end

	if exist('MEkr') && ~isempty(MEkr), F.PB{ind} = ME(MEkr); ind=ind+1; end % adds a MEkrdium property
	if exist('LA') && ~isempty(LA), F.PB{ind} = ['LA: ' LA]; ind=ind+1; end % adds a label

	F.PB{ind} = ['PB: ' s1 ' : ' s2 ' : ' s3 ' : ' s4 ' :  : ' subang ' : ' maxtri];
	
