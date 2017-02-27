function [F ind] = AW(F, varargin)% s1, s2, s3, s4, ns, as, lpt, medt, aptgeom, ecfm,tem, tm, temm, mind, nind, mag, ph, rotang,
	% mexp, pasp)

	% There are various ways to run this code, 
	%
	% Import modes from FEST3D file (*.fim) (test!)
	% 	function (F, sc, refp, filename, xrot, yrot, zrot);
	%
	% Specify a rectangular waveguide (test!)
	% 	function (F, 'rect', tri, med, sc,s1,s2,s3,mag, phase,mode, modesindx{m n}, modesindxmax{m n},	pponly)
	%
	% Specify a circular waveguide
	%		function (F, 'circ', tri, med, sc,s1,s2,s3,mag, phase, mode, rot, ang, rad, modesindxmax,pponly)
	%		ANG - M RAD - N
	%
  % Specify a coaxial waveguide
	% 	function (F, 'coax', 'tri', 'med', 'sc','s1','s2','s3','s4', 'mag','phase','FM', 'rot', 'ang', 'rad', {1 1}, pponly)
	%
	%  S3
	%  S1-S4-S2
	%
	% Specify the source in the *.pre file
	%
	% With this card a waveguide port excitation by an impressed mode on a rectangular, circular, or
	% coaxial waveguide can be modelled or the impressed travelling modes in all waveguides of a
	% multi-port network can be imported from a *.fim file.
	% Specify the source in the *.pre file
	% With this option a waveguide port excitation by means of an impressed mode on a rectangular,
	% circular, or coaxial waveguide, can be modelled.
	% 
	% INPUT
	%		sc (New source 0): A new excitation is defined which replaces all previously defined excitations.
	%		 			 (Add to sources 1): A new excitation is defined which is added to the previously defined excita-
	%															tions.
	%		tri (Label of the port triangles): Label of the triangular mesh elements in the mesh which represent the
	%			waveguide port. (If multiple solutions are defined in the same *.pre file, then
	%			the usage of the waveguide ports with respect to the label/s to which it/they
	%			are applied must be consistent for all solutions.)
	%		medt (Medium inside the triangles): The label of the medium inside the modelled waveguide.
	%		aptgeom (Apeture Geometry)
	%			rect (Rectangular): A rectangular waveguide cross section is used, which is defined by three points
	%				S1, S2, and S3 as follows: S1 is an arbitrary corner point, and S2 and S3 are
	%				two corner points which define the waveguide sides u1 (from S1 to S2) and
	%				u2 (from S1 to S3). The direction in which the mode is launched is given by
	%				u3 = u1 × u2.
	%				S3
	%				^
	%				u2
	%				S1--u1>---S2
	%			circ (Circular): A circular waveguide cross section is used. The point S1 denotes the centre
	%				of the circular port, and the point S2 specifies the radius and start point for
	%				the angular dependency. A further point S3 must be perpendicular above the
	%				centre of the circular plate, so that the direction from S1 to S3 indicates the
	%				direction in which the waveguide modes are launched.
	%				S1--->S2
	%				.S3
	%			coax (Coaxial): Here a feed of a coaxial waveguide with circular cross sections of both the inner
	%				and outer conductor can be specified. The point definitions are the same as for
	%				the circular waveguide, except that an additional point S4 must be defined
	%				between S1 and S2 which specifies the radius of the inner conductor.
	%				ecfm (Excite fundamental mode): Select this option to automatically excite the fundamental mode of the
	%				waveguide. When this option is selected, the mode type and its indices (m
	%				and n) can not be specified since they are determined automatically.
	%		tem (TE-mode): If this option is checked, a T Em,n mode (also referred to as H m,n ) is used as
	%			excitation. This option is only available when “Excite fundamental mode” has
	%			not been selected.
	%		tm (TM-mode): If this option is checked, a T Mm,n mode (also referred to as Em,n ) is used as
	%			excitation. This option is only available when “Excite fundamental mode” has
	%			not been selected.
	%		temm (TEM-mode): If this option is checked (only available for the coaxial waveguide since TEM
	%			modes don’t exist in rectangular/circular waveguides), a TEM mode is used as
	%			excitation. This option is only available when “Excite fundamental mode” has
	%			not been selected.
	%		mind (Mode index m): The index m of the T Em,n or T Mm,n mode which is impressed at the port. Note
	%			that for a rectangular waveguide the index m is related to the u1 direction (i.e.
	%			from point S1 to S2). For a circular/coaxial waveguide, m denotes the angular
	%			dependency. This option is only available when “Excite fundamental mode”
	%			has not been selected.
	%		nind (Mode index n): The index n of the T Em,n or T Mm,n , mode which is impressed at the port. Note
	%			that for a rectangular waveguide the index n is related to the u2 direction (i.e.
	%			from point S1 to S3). For a circular/coaxial waveguide, n denotes the radial
	%			dependency. This option is only available when “Excite fundamental mode”
	%			has not been selected.
	%		mag (Magnitude). . .: Absolute value of the complex amplitude of the impressed mode. For a TE-
	%			mode the unit is A/m, for a TM-mode the unit is V/m; for a TEM-mode the
	%			unit is V Note that an amplitude of zero can also be specified. In this case a
	%			waveguide port is acting purely as a passive port (e.g. as waveguide termina-
	%			tion), and no wave is launched.
	%		ph (Phase): The phase of the impressed mode in degrees.
	%		rotang (Rotation angle φ 0) : This option is available for circular and coaxial modes only and indicates the
	%			rotation angle in degrees by which a mode is rotated anti-clockwise with re-
	%			spect to the reference direction (point S2).
	%		mexp (Modal expansion): At a waveguide port a specific mode is used as impressed excitation. How-
	%			ever, due to discontinuities in the model, also higher order modes can result
	%			and will be propagating backwards through the port (applies to both active
	%			and passive ports). The maximum modal expansion indices taken into account
	%			during the calculation can be determined automatically by the kernel or speci-
	%			fied manually. The included modes must be sufficient to capture the resulting
	%			field distribution of the problem. Note that the mesh across the waveguide port
	%			must be fine enough to represent the potential rapid field variation of included
	%			higher order modes. Also note that an increased number of higher order modes
	%			included in the model may have a significant impact on the run-time. If speci-
	%			fied manually then the input values denote the maximum mode indices m and
	%			n which will be used to expand the backwards travelling waves. If determined
	%			automatically, then all propagating modes will be included, as well as evanes-
	%			cent modes that decay faster than 1/e at a tenth of a wavelength away from
	%			the waveguide port.
	%		pasp (Passive port only):The waveguide port can be marked as passive only so that it will not be consid-
	%			ered during S-parameter calculations. In this case the port is acting purely as
	%			a passive waveguide termination, and the coupling to and from this port will
	%			not be calculated.
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
	% ified by the last IP card prior to the AW card. Along the arcs, accurate modelling of the geometry
	% may require finer segmentation and the values Maximum edge length (bottom) and Maximum
	% edge length (top) specify the maximum edge length along the corresponding arcs. Maximum
	% edge length (top) is only used when a truncated cone is created. If either of these values is not
	% specified the length specified with the IP card will be used on the corresponding arc.

	% function F = AW(F, s1, s2, s3, s4, sctype, tri, medt, aptgeom, ecfm,tem, tm, temm, mind, nind, mag, ph, rotang,
	% mexp, pasp)

	try, ind = size(F.AW)(2)+1; catch, ind=1; end

	if(0) %abs(nargin-7)<tol) % running as importing a file
		% function (F, sc, refp, filename, xrot, yrot, zrot);
		whos
		sc = varargin{1}; 
		refp = varargin{2};
		filename = varargin{3}; 
		xrot = varargin{4};	yrot = varargin{5}; zrot = varargin{6};
		sc
		if ~ischar(sc), num2str(sc); end
		filename = ['"' filename '"'];
		if ~ischar(xrot), num2str(xrot); end
		if ~ischar(yrot), num2str(yrot); end
		if ~ischar(zrot), num2str(zrot); end
		F.AW{ind} = ['AW: ' sc ' :  :  :  :  :  :  : ' refp ' :  :  :  : 1 :  : ' filename '  :  :  :  :  :  : ' xrot ' : ' yrot ' : ' zrot];
		F.AW
	elseif(1)
		% Required variables
		type = varargin{1};

		switch type
			case{'rect'}
				% function (F, type, tri, med, sc,s1,s2,s3,mag, phase,mode,modesindx, modesindxmax, pponly)
				% AW(F, 'rect', 'tri', 'med', 'sc','s1','s2','s3','mag', 'phase',FM, [], [], passport)
				tri = varargin{2}; if ~ischar(tri), tri=num2str(tri); end
				med = varargin{3}; if ~ischar(med), med=num2str(med); end
				sc = varargin{4}; if ~ischar(sc), sc=num2str(sc); end
				s1 = varargin{5};
				s2 = varargin{6};
				s3 = varargin{7};
				mag = varargin{8}; if ~ischar(mag), mag=num2str(mag); end
				phase = varargin{9}; if ~ischar(phase), phase=num2str(phase); end
				modes = varargin{10};
				modesindx = varargin{11};
				modesindxmax = varargin{12};
				pponly = varargin{13}; if(~pponly) pponly=[]; else pponly=' 1'; end

				if isempty(modesindxmax), modeMaxM ='-1'; modeMaxN='-1'; 
				else, modeMaxM = num2str(modesindxmax{1}); modeMaxN = num2str(modesindxmax{2}); 
				end

				switch modes
					case{'TE', 'te'}, modes='1';	modeM = num2str(modesindx{1}); modeN = num2str(modesindx{2});
					case{'TM','tm'}, modes='2'; modeM = num2str(modesindx{1}); modeN = num2str(modesindx{2});
					case{'FUN','fun'}, modes='0'; modeM = '-1'; modeN = '-1';
				end
				line1 =  ['AW: ' sc ' : ' tri ' : 1 : ' med ' : ' pponly ' : ' mag ' : ' phase ' : ' s1 ' : ' s2 ' : ' s3];
				line2 =  ['  : ' modes ' :  ' modeMaxM ' : ' modeMaxN ' :  ' modeM ' : ' modeN];
				F.AW{ind} = [line1 "\n" line2];
			case{'circ'}
				type = '2';
				% function (F, type, tri, med, sc,s1,s2,s3,mag, phase, mode, rot, ang, rad, modesindxmax,pponly)
				% AW(F, 'circ', 'tri', 'med', 'sc','s1','s2','s3','mag','phase','FM', 'rot', 'ang', 'rad', {1 1}, 0)
				tri = varargin{2}; if ~ischar(tri), tri=num2str(tri); end
				med = varargin{3}; if ~ischar(med), med=num2str(med); end
				sc = varargin{4}; if ~ischar(sc), sc=num2str(sc); end
				s1 = varargin{5}; 
				s2 = varargin{6};
				s3 = varargin{7};
				mag = varargin{8}; if ~ischar(mag), mag=num2str(mag); end
				phase = varargin{9}; if ~ischar(phase), phase=num2str(phase); end
				modes = varargin{10};
				rot = varargin{11};if ~ischar(rot), rot=num2str(rot); end
				ang = varargin{12};if ~ischar(ang), ang=num2str(ang); end
				rad = varargin{13};if ~ischar(rad), rad=num2str(rad); end
				modesindxmax = varargin{14};
% 				modesindx = varargin{11};

% 				pponly = varargin{15}; if(~pponly) pponly=[]; else pponly=' 1'; end
				pponly = varargin{15}; if(~pponly) pponly=' 0'; else pponly=' 1'; end

				if isempty(modesindxmax), modeMaxM ='-1'; modeMaxN='-1'; 
				else, modeMaxM = num2str(modesindxmax{1}); modeMaxN = num2str(modesindxmax{2}); 
				end
% 
				% if length(modesindxmax)>3,
					% modeM = num2str(modesindxmax{3}); modeN = num2str(modesindxmax{4}); 
				% end

				switch modes
					case{'TE', 'te'}, modes='1'; endv = [ang ' : ' rad ' : ' rot];
					case{'TM','tm'}, modes='2'; endv = [ang ' : ' rad ' : ' rot];
					case{'FUN','fun'}, modes='0'; endv = ['-1 : -1 : ' rot ' : 0']; % Ang = '-1'; Rad = '-1'; 
				end

				line1 =  ['AW: ' sc ' : ' tri ' : 2 : ' med ' :'  pponly ' : ' mag ' : ' phase ' : ' s1 ' : ' s2 ' : ' s3];
				line2 =  ['  : ' modes ' :  ' modeMaxM ' : ' modeMaxN ' :  ' endv]; % Ang ' : ' Rad ' : ' rot];
				F.AW{ind} = [line1 "\n" line2];
			case{'coax'}
				type = '3'; % varargin{1} = type
				% AW(F, 'coax', 'tri', 'med', 'sc','s1','s2','s3','s4', 'mag','phase','FM', 'rot', 'ang', 'rad', {1 1}, 0)
				lenv = length(varargin);
				tri = varargin{2}; 
				med = varargin{3}; 
				sc = varargin{4}; if ~ischar(sc), sc=num2str(sc); end
				s1 = varargin{5};  
				s2 = varargin{6}; 
				s3 = varargin{7};
				s4 = varargin{8};
				mag = varargin{9}; if ~ischar(mag), mag=num2str(mag); end
				phase = varargin{10}; if ~ischar(phase), phase=num2str(phase); end
				modes = varargin{11};
				rot = varargin{12};if ~ischar(rot), rot=num2str(rot); end
				if lenv<13, ang=[]; else, ang = varargin{13}; if ~ischar(ang), ang=num2str(ang); end, end
				if lenv<14, rad=[]; else, rad = varargin{14}; if ~ischar(rad), rad=num2str(rad); end, end
				if lenv<15, modesindxmax=[]; else modesindxmax = varargin{15}; end
				if lenv<16, pponly=[]; else, pponly = varargin{16}; if(~pponly) pponly=[]; else pponly=' 1'; end, end 

				if isempty(modesindxmax), modeMaxM ='-1'; modeMaxN='-1'; 
				else, modeMaxM = num2str(modesindxmax{1}); modeMaxN = num2str(modesindxmax{2}); 
				end

				switch modes
					case{'TE', 'te'}, modes='1'; endv = [ang ' : ' rad ' : ' rot];
					case{'TM','tm'}, modes='2'; endv = [ang ' : ' rad ' : ' rot];
					case{'TEM','tem'}, modes='3'; endv = [ang ' : ' rad ' : ' rot];
					case{'FUN','fun'}, modes='0'; endv = ['-1 : -1 : ' rot ' : 0']; % Ang = '-1'; Rad = '-1'; 
				end
				% sc
				% tri 
				% med
				% pponly
				% mag
				% phase
				% s1
				% s2
				% s3
				% s4
 			line1 =  ['AW: ' sc ' : ' tri ' : 3 : ' med ' :'  pponly ' : ' mag ' : ' phase ' : ' s1 ' : ' s2 ' : ' s3 ' : ' s4];
				line2 =  ['  : ' modes ' :  ' modeMaxM ' : ' modeMaxN ' :  ' endv]; % Ang ' : ' Rad ' : ' rot];
				F.AW{ind} = [line1 "\n" line2];
			case{'circ2'}
				type = '2';
				% function (F, type, tri, med, sc,s1,s2,s3,mag, phase, mode, rot, ang, rad,modesindx, modesindxmax,pponly)
				% AW(F, 'circ', 'tri', 'med', 'sc','s1','s2','s3','mag','phase','FM', 'rot', 'ang', 'rad', {1 1}, 0)
				tri = varargin{2}; if ~ischar(tri), tri=num2str(tri); end
				med = varargin{3}; if ~ischar(med), med=num2str(med); end
				sc = varargin{4}; if ~ischar(sc), sc=num2str(sc); end
				s1 = varargin{5}; 
				s2 = varargin{6};
				s3 = varargin{7};
				mag = varargin{8}; if ~ischar(mag), mag=num2str(mag); end
				phase = varargin{9}; if ~ischar(phase), phase=num2str(phase); end
				modes = varargin{10};
				rot = varargin{11};if ~ischar(rot), rot=num2str(rot); end
				ang = varargin{12};if ~ischar(ang), ang=num2str(ang); end %M
				rad = varargin{13};if ~ischar(rad), rad=num2str(rad); end %N
				modesindx = varargin{14};
				modesindxmax = varargin{15};
% 				modesindx = varargin{11};

				pponly = varargin{16}; if(~pponly) pponly=[]; else pponly=' 1'; end

				if isempty(modesindxmax), modeMaxM ='-1'; modeMaxN='-1'; 
				else, modeMaxM = num2str(modesindxmax{1}); modeMaxN = num2str(modesindxmax{2}); 
				end
% 
				% if length(modesindxmax)>3,
					% modeM = num2str(modesindxmax{3}); modeN = num2str(modesindxmax{4}); 
				% end

				switch modes
					case{'TE', 'te'}, modes='1'; endv = [ang ' : ' rad ' : ' rot];
					case{'TM','tm'}, modes='2'; endv = [ang ' : ' rad ' : ' rot];
					case{'FUN','fun'}, modes='0'; endv = ['-1 : -1 : ' rot ' : 0']; % Ang = '-1'; Rad = '-1'; 
				end

				line1 =  ['AW: ' sc ' : ' tri ' : 2 : ' med ' :'  pponly ' : ' mag ' : ' phase ' : ' s1 ' : ' s2 ' : ' s3];
				line2 =  ['  : ' modes ' :  ' modeMaxM ' : ' modeMaxN ' :  ' endv]; % Ang ' : ' Rad ' : ' rot];
				F.AW{ind} = [line1 "\n" line2];
			otherwise
				error('unrecognised waveguide type');
		end
	end

	ind=ind+1;
