function F = LA(F,string, ind)
	

% INPUT
%	 string:	Label for following . . .: The label assigned to all segments, triangles, etc. defined in
%						cards following this one.
%	 ind :		ind of point after which to put the label call DP with ind back to get the value 
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
% 
% With this card, labels are assigned to segments, triangles, polygonal plates, cuboids, UTD cylin-
% ders and points.
% In order to select the position of the feed (Ax cards)16 , the location of impedance loading (LD, LS,
% LP and LZ cards) or structures on which to apply the skin effect (SK cards), each segment, trian-
% gle, etc. is assigned a label. Other applications include the selective transformation or copying of
% parts of geometry (TG card), and outputting of currents on selected elements (OS card). Labels
% are also used to define triangles on which to apply physical optics (PO card (see section 11.37)).
% All elements, etc. that are created after the LA card (e.g. by a BP card), are assigned the value
% specified in the dialog as label. A different label is only assigned by a new LA card. All structures
% created before the first LA card (or if no LA card is present), is assigned the default label which
% is 0 (number zero).
% Label names (see section 10.4) can be an arbitrary string using the characters A-Z, the digits 0-9
% or also the underscore _. Labels may be manipulated using label increments (see section 10.4)
% and referenced using label ranges (see section 10.4).
% 

if ~exist('ind'), ind=1; end
% try, ind = size(F.LA)(2)+1; catch, ind=1; end
F.LA{ind} = ['LA: ' string];
