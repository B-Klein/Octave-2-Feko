function F = BP(F, s1,s2,s3,s4,msha,mshb,La)

  % F = BP(F, s1,s2,s3,s4,msha,mshb,La)
	%
	% INPUT
	% 	A mesh of surface triangles in the shape of a flat parallelogram can be created with this card. In
	% general, this card is replaced by the PM card. This card should only be used when the user wants
	% to force the very regular meshing that this card produces.
	%
	%  S3  mshb  S4 
	% msha      msha
	%  S4  mshb  S1
	%
	% 	Parameters:
	% S1, S2, S3, S4:
	% The points S1 to S4 are the four corner points of the parallelogram. These
	% points should have been defined previously with DP cards.
	% Specify non-uniform . . .: Normally a parallelogram is segmented according to the edge length specified
	% with the IP card. Wwhen creating small microstrip lines, it may be desirable to
	% use a finer segmentation in one direction. Check this item if a finer segmenta-
	% tion is required in one direction. The mesh sizes are in m and are scaled by the
	% SF card.
	% Mesh size along sides a and c: Edges S1–S2 and S3–S4.
	% Mesh size along sides b and d: Edges S2–S3 and S4–S1.
	% The points are connected in the order that they appear in the BP card. Thus the user has to
	% ensure that the points describe a parallelogram. If this is not the case, then PREFEKO will abort
	% with the appropriate error message.
	% The direction of the normal vector (ˆ
	% n ) of the subdivided triangles is determined by the right hand
	% rule, through all the corners. This direction is only important when used with the Physical Optics
	% — PO card (see Section 13.40) — or with dielectrics — ME card (see Section 13.33) or with the
	% CFIE — CF card (see Section 14.27).
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
	
	if exist('msha')
		if ~ischar(msha), msha = num2str(msha,writepr()); end
	else, msha=[]; end
	if exist('mshb')
		if ~ischar(mshb), mshb = num2str(mshb,writepr()); end
	else, mshb=[]; end

	try, ind = size(F.BP)(2)+1; catch, ind=1; end
	
	if exist('La'), F.BP{ind}=['LA: ' La]; ind=ind+1; end % adds a label

	F.BP{ind} = ['BP: ' s1 ' : ' s2 ' : ' s3 ' : ' s4 ' :  : ' msha ' : ' mshb];
