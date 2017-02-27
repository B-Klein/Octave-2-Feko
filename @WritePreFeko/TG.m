function F = TG(F, numcopies, labelstr, labelend, incr, rot, tran, mirror, scale, includes)

	% F = TG(F, numcopies, labelstr, labelend, incr, rot, tran, mirror, scale, includes)
	%
	%		labelstr, labelend, incr : strings
	%		rot : cell of strings or vector of xyz (degrees)
	%		tran : cell of strings or vector of xyz (degrees)
	%		mirror : cell of strings or vector of xyz (degrees)
	%		scale : number or string
	% 
	% With this command the already entered geometric elements (triangles, segments, etc.) can be
	% translated, rotated, mirrored and/or scaled. It is also possible to duplicate structures.
	%
	% INPUT:
	% 
	% Number of copies: The number of copies to make, for example if set to 3 the selected elements
	% will be rotated, translated, mirrored and scaled 3 times such that there will be
	% a total of 4 structures. If set to 0, the existing elements, are rotated, translated,
	% mirrored, scaled and the number of elements remains the same.
	% Use label selection: If this option is not checked, then the TG card applies to all the previously
	% defined geometry. If this option is checked, then a label selective processing is
	% possible.
	% Copy structures starting from: together with ending at label can be used to apply the TG card only to
	% a selected part of the structure. The TG card is applied only to those elements
	% whose label lies within the range set here (see also LA and CB cards and also
	% the general discussion of label ranges (see section 10.4)). If the second field
	% is left empty, only structures with the label set in the first field are considered.
	% Note that certain element types on the specified label(s) can be excluded from
	% the selection lower in the card.
	% Label increment for the new structures: Each newly generated structure will be assigned a label that is
	% incremented by this value from that of the original structure. An exception is
	% the label 0 which is retained.
	% Include:
	% This group can be used to specify which element types (provided they satisfy
	% the label criterion) are rotated / translated.
	% Rotation around the x-axis: Angle of rotation α x around the x axis in degrees.
	% Rotation around the y-axis: Angle of rotation α y around the y axis in degrees.
	% Rotation around the z-axis: Angle of rotation αz around the z axis in degrees.
	% Translation along the x-axis: Translation ∆ x in the x direction in m (scaled by SF card).
	% Translation along the y-axis: Translation ∆ y in the y direction in m (scaled by SF card).
	% Translation along the z-axis: Translation ∆z in the z direction in m (scaled by SF card).
	% Mirror about plane at x equal to: The geometry is mirrored around a plane at x equal to a constant
	% specified. If no value is specified, no mirroring around the plane is performed.
	% Mirror about plane at y equal to: The geometry is mirrored around a plane at y equal to a constant
	% specified. If no value is specified, no mirroring around the plane is performed
	% Mirror about plane at z equal to: The geometry is mirrored around a plane at z equal to a constant
	% specified. If no value is specified, no mirroring around the plane is performed.
	% Scale factor:
	% The scaling factor γ, with which the structures must be scaled. (If left empty,
	% it defaults to 1.)
	% • For wire segments the wire radius is scaled as well as the coordinates of
	% the start and end points.
	% • The scaling factor γ is applied after the translations/rotations have been
	% conducted, i.e. the new coordinates after the translation/rotation will be
	% scaled. This means that the effective translation is the value specified at
	% the TG card multiplied by the scaling factor. (If this is not desired, then
	% two different TG cards may be used - the first 
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
	% When an SY card (symmetry) is used before the TG card, the TG card resets the symmetry if
	% the new structures invalidates the symmetry. Cases where the symmetry is not reset is when, for
	% example, the plane z = 0 is a symmetry plane and the TG card specifies rotation about the z axis
	% for a symmetrical selection of elements. In this case the symmetry is retained.
	% Translation, rotation, mirroring and scaling are performed as a single transformation. The order
	% is rotate, translate, scale and then mirror.
	% If more than one copy is made, successive points are generated from the previous point using the
	% same relation.
	% With a TG card the simultaneous rotation around multiple axes as well as translation in multiple
	% directions is possible. A point (x, y, z), for example the corner point of a triangle, is transformed
	% to a new point
	% 
	% Multiplication by the rotation matrix M effectively rotates a point first by an angle αz around
	% the z axis, then by an angle α y around the y axis and finally by an angle α x around x axis. It is
	% important to note that the second rotation around the y axis represents the global y axis. This
	% is also equivalent to rotating α x around the x axis, then rotating α y around the new y axis and
	% finally rotating αz around the new z axis.
	% The transformation angles as used by FEKO in this order are generally referred to as Kardan
	% angles as opposed to the also commonly used Euler angles. If the rotation shall be performed in
	% the other order (i.e. first around the x axis, then around the y axis and finally around the z axis),
	% then one can simply use multiple consecutive TG cards. But since the same rotation algorithm
	% is also used at other FEKO cards (for instance AC or AR) where one cannot use multiple cards,
	% a short PREFEKO code segment shall be given here which illustrates how the angles can be
	% converted:
	%

	% function F = TG(F, numcopies, labelstr, labelend, incr, rot, tran, mirror, scale, includes)

	if ~exist('incr'), incr=[]; end
	if ~exist('rot'), rot=[]; end
	if ~exist('tran'), tran=[]; end
	if ~exist('mirror'), mirror=[]; end
	if ~exist('scale'), scale=[]; end
	if ~exist('includes'), includes=0; end

	if iscell(rot), rotx=rot{1}; roty=rot{2}; rotz=rot{3}; elseif ~isempty(rot), rotx=rot(1); roty=rot(2); rotz=rot(3);	else,rotx=[]; roty=[]; rotz=[]; end
	if ~ischar(rotx) rotx = num2str(rotx); else, rotx = ['#' rotx]; end
	if ~ischar(roty) roty = num2str(roty); else, roty = ['#' roty]; end
	if ~ischar(rotz) rotz = num2str(rotz); else, rotz = ['#' rotz]; end

	if iscell(tran), tranx=tran{1}; trany=tran{2}; tranz=tran{3}; elseif ~isempty(tran), tranx=tran(1); trany=tran(2); tranz=tran(3);	else,tranx=[]; trany=[]; tranz=[]; end
	if ~ischar(tranx) tranx = num2str(tranx); else, tranx = ['#' tranx]; end
	if ~ischar(trany) trany = num2str(trany); else, trany = ['#' trany]; end
	if ~ischar(tranz) tranz = num2str(tranz); else, tranz = ['#' tranz]; end

	if iscell(mirror), mirrorx=mirror{1}; mirrory=mirror{2}; mirrorz=mirror{3}; elseif ~isempty(mirror), mirrorx=mirror(1); mirrory=mirror(2); mirrorz=mirror(3);	else,mirrorx=[]; mirrory=[]; mirrorz=[]; end
	if ~ischar(mirrorx) mirrorx = num2str(mirrorx); else, mirrorx = ['#' mirrorx]; end
	if ~ischar(mirrory) mirrory = num2str(mirrory); else, mirrory = ['#' mirrory]; end
	if ~ischar(mirrorz) mirrorz = num2str(mirrorz); else, mirrorz = ['#' mirrorz]; end

	if ~ischar(scale), scale = num2str(scale); elseif ~isempty(scale), scale = ['#' scale]; end
	if ~ischar(numcopies), numcopies = num2str(numcopies); elseif ~isempty(numcopies), numcopies = ['#' numcopies]; else numcopies =1; end
	if ~ischar(includes), includes = num2str(includes); elseif ~isempty(includes), includes = ['#' includes]; end

	if ~ischar(incr), incr = num2str(incr); elseif ~isempty(incr), incr = ['#' incr]; end

	try, ind = size(F.TG)(2)+1; catch, ind=1; end

	if isempty(mirrorx) && isempty(mirrorx) && isempty(mirrorx),
		F.TG{ind} = ['TG: ' numcopies ' : ' labelstr ' : ' labelend ' : ' incr ' : ' includes ' : ' rotx ' : ' roty ' : ' rotz ' : ' tranx ' : ' trany ' : ' tranz ' : ' scale];
	else
		F.TG{ind} = ['TG: ' numcopies ' : ' labelstr ' : ' labelend ' : ' incr ' : ' includes ' : ' rotx ' : ' roty ' : ' rotz ' : ' tranx ' : ' trany ' : ' tranz ' : ' scale ' : 7'];
		F.TG{ind+1} = ['  :  :  :  :  :  : ' mirrorx ' : ' mirrory ' : ' mirrorz];
	end
