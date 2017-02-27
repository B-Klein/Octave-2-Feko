function F = BT(F, s1,s2,s3,a,b,c,La)

	% F = BT(F, s1,s2,s3,a,b,c,LA)
	%
	% A mesh of surface triangles in the shape of a flat triangle can be created with this card. In general,
	% this card is replaced by the PM card.
	%
	% INPUT
	%
	% S2 
	%  b  a
	% S3 c  S1
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

	if ~ischar(a), a = num2str(a); else a = ['#' a]; end
	if ~ischar(b), b = num2str(b); else b = ['#' b]; end
	if ~ischar(c), c = num2str(c); else c = ['#' c]; end

	try, ind = size(F.BT)(2)+1; catch, ind=1; end
	
	if exist('La'), F.BT{ind}=['LA: ' La]; ind=ind+1; end % adds a label

	F.BT{ind} = ['BT: ' s1 ' : ' s2 ' : ' s3 ' :  :  : ' a ' : ' b ' : ' c];
