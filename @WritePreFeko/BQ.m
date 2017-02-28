function F = BQ(F,s1,s2,s3,s4,LA, varargin)
	
	% F = BQ(F,s1,s2,s3,s4, [LA, a, b, c, d])
	% [optional inputs]
	%
	% A mesh of surface triangles in the shape of a flat quadrangle can be created with
	% this card. Models constructed using the BQ card can generally be simplified by using
	% the PM card.
	%
	% INPUT
	%			/S2
	% 	b   |
	% S3	  a
	% c		  |
	% S4 _d_S1
	%
	% S1, S2, S3, S4:
	% The points S1 to S4 are the four corner points of the quadrangle. These points
	% should have been defined previously with the DP card.
	% Specify non-uniform . . .: Normally a quadrangle is segmented according to the edge length specified
	% with the IP card. In some cases, e.g. when creating small microstrip lines, it
	% may be desirable to use a finer segmentation in one direction. Check this item
	% if finer segmentation is required along any edge. The mesh sizes are in m and
	% are scaled by the SF card.
	% Mesh size along side a: Edge S1–S2.
	% Mesh size along side b: Edge S2–S3.
	% Mesh size along side c: Edge S3–S4.
	% Mesh size along side d: Edge S4–S1.
	% The points have to be predefined using DP cards prior to the BQ card and are connected in the
	% order that they appear in the BQ card.
	% In principal the BQ card can create all types of quadrangles, including parallelograms. The
	% difference is that the BP card creates a regular subdivision.
	% The direction of the normal vector (ˆ) of the subdivided triangles is determined by the right hand
	% n
	% rule through all the corners. This direction is only important when used with the Physical Optics
	% (PO card) or with dielectrics (ME card) or for the CFIE (CF card).

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

	if ~ischar(s1), s1 = num2str(s1); end
	if ~ischar(s2), s2 = num2str(s2); end
	if ~ischar(s3), s3 = num2str(s3); end
	if ~ischar(s4), s4 = num2str(s4); end
	if length(varargin)>tol,
		a = cell2mat(varargin(1));
		if length(varargin)>1, b=cell2mat(varargin(2)); else b=[]; end 
		if length(varargin)>2, c=cell2mat(varargin(3)); else c=[]; end 
		if length(varargin)>3, d=cell2mat(varargin(4)); else d=[];end 
		if ~isempty(a), if ~ischar(a), a = num2str(a); else a = ['#' a]; end; end
		if ~isempty(b), if ~ischar(b), b = num2str(b); else b = ['#' b]; end; end
		if ~isempty(c), if ~ischar(c), c = num2str(c); else c = ['#' c]; end; end
		if ~isempty(d), if ~ischar(d), d = num2str(d); else d = ['#' d]; end; end
% 		if ~ischar(b), b = num2str(b); else b = ['#' b]; end
% 		if ~ischar(c), c = num2str(c); else c = ['#' c]; end
% 		if ~ischar(d), d = num2str(d); else d = ['#' d]; end
		endvec = [' :  : ' a ' : ' b ' : ' c ' : ' d];
	else
		endvec = '';
	end

	try, ind = size(F.BQ)(2)+1; catch, ind=1; end

	if ~exist('LA') && ~isempty(LA), F.BQ{ind} = ['LA: ' LA]; ind=ind+1; end % adds a label
	F.BQ{ind} = ['BQ: ' s1 ' : ' s2 ' : ' s3 ' : ' s4 endvec];
