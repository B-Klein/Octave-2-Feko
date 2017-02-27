function F = SY(F,xyz,label)

	% F = SY(F,xyz,label)
	% 
	% Here symmetry can be used to generate the geometry and to reduce computation time.
	% xyz : none 'n' | geometric 'g' | electrical 'e' | magnetic 'm'
	%
	%		Select symmetry for the plane x = 0: The type of symmetry, if any, in the yz-plane.  Select
	%		symmetry for the plane y = 0: The type of symmetry, if any, in the xz-plane.  Select symmetry
	%		for the plane z = 0: The type of symmetry, if any, in the x y-plane.
	%
	% Label : increment for the new structures: After they are mirrored, the labels of the new elements are
	%	 incremented with the value specified in this field. Label 0 is, however, not incremented. The
	%	 corresponding new elements will also have label 0. If this field is empty or set to 0, the labels
	%	 are not incremented, i.e. the new elements will have the same label as the one they were created
	%	 from.
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
	% All the conducting and/or dielectric triangles, segments, cuboids, tetrahedral volume elements,
	% wedges, edges, Fock regions and polygonal plates that have been declared before the SY card,
	% are mirrored. Furthermore, the second and third corners of the triangles are swapped, so that
	% the direction of the normal vector is retained. Likewise the corners of image polygonal plates are
	% rearranged to retain the normal direction. (The first corner point of the original polygon becomes
	% the last corner of the mirror image.)
	% Sources are not mirrored. If, for example, a Hertzian dipole is placed on one side of the symmetry
	% plane, the user must also place the correct image on the opposite side of the symmetry plane.
	% Multiple SY cards can be used and it is possible to mirror around more than one plane at once.
	% A detailed description of the different types of symmetry (geometric, electric and magnetic sym-
	% metry) is given in FEKO User Manual (section 23.1).
	%
	x = xyz(1); y = xyz(2); z = xyz(3);
	switch x, case{'none', 'n'}, x='0'; case{'geometric','g'}, x='1'; case{'electrical','e'}, x='2'; case{'magnetic','m'}, x='3'; end
	switch y, case{'none', 'n'}, y='0'; case{'geometric','g'}, y='1'; case{'electrical','e'}, y='2'; case{'magnetic','m'}, y='3'; end
	switch z, case{'none', 'n'}, z='0'; case{'geometric','g'}, z='1'; case{'electrical','e'}, z='2'; case{'magnetic','m'}, z='3'; end
	% x,y,z : 'geometric', 'g' | 'electrical', 'e' | 'magnetic', 'm'

	if exist('label') && ~isempty(label), label = [' : ' label]; else, label=[]; end

	try, ind = size(F.SY)(2)+1; catch, ind=1; end
	
	if ~isempty(label), 
		F.SY{ind}=['SY: 1 : ' x ' : ' y ' : ' z label];
	else
		F.SY{ind}=['SY: 1 : ' x ' : ' y ' : ' z];
	end
