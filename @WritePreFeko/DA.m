function [F ind] = DA(F,Eopt, Hopt, FFopt, Copt, files, ind)
	
	% INPUT
	% Eopt 'fo' | 'f' | 'o' | ' '
	% 	Write electric fields to: The electric field strength can be exported into a *.efe file. The output of this
	% 	result type to the *.out file can also be deactivated here.
	% Hopt 'fo' | 'f' | 'o' | ' '
	%		Write magnetic fields to: The magnetic field strength can be exported into a *.hfe file. The output of
	%		this result type to the *.out file can also be deactivated here.
	% FFopt 'fo' | 'f' | 'o' | ' '
	%		Write far fields to: The far field can be exported into a *.ffe file. The output of this result
	%		type to the *.out file can also be deactivated here.
	% Copt 'fo' | 'f' | 'o' | ' '
	%		Write currents/charges to: The currents can be exported into a *.os/*.ol file. The output of this
	%		result type to the *.out file can also be deactivated here.
	%
	% files 'rstcof' | 'rstco' | 'rstcf' ... | 'f' | ' '
	% r - Write residue . . .:
	% 		The residue from the iterative algorithm used to solve the matrix equation is
	% 		stored in a *.cgm file.
	% s - Write S-parameters . . .: The S-parameters (see the SP card) are written to a file in Touchstone *.snp
	% 		format (v1.0). The n here gives the number of ports.
	% t - Write spherical wave expansion . . .: A spherical wave expansion of the far field as computed by FEKO is
	% 		exported to an SWE file (extension *.sph) which can be imported into GRASP
	% 		from TICRA (code for reflector antenna modelling). Note that the far field
	% 		computation with spherical wave expansion must be requested subsequently	(FF card (see section 12.38)).
	% c - Write near fields to SEMCAD *.dat file: The near fields can be exported into a SEMCAD *.dat file. The
	% 		output of this result type to the SEMCAD *.dat file can also be deactivated here.
	% o - Write error estimates to the *.out file: The error estimates can be exported to the *.out file.
	% f - Write generalised S-parameter matrix to FEST3D *.chr file: The generalised S-parameter matrix (GSM)
	% 		for waveguide ports are exported to a FEST3D *.chr file.
	%
	% ind - which simulation to to apply this too
	%
	% December 2011
	% FEKO User’s Manual
	% CONTROL CARDS
	% 12-90
	%
% More than one DA card is allowed in one input file. Thus, using the following sequence of control
	% cards, with the appropriate options only certain blocks will be saved to the data files:
	% DA
	% FE
	% DA
	% FE
	% ...
	% ...
	% ...
	% ...
	% ** Write near fields on
	% ** Write near fields off
	% With this sequence, the electric fields calculated with the first FE card can be written to the *.efe
	% file, but not those of the second FE card.
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
	% With this card some data like near fields or S-parameters can be exported to additional ASCII
	% files. The card allows to switch this export on and off, and affects only cards for the computation
	% of, for example, near fields or S-parameters that follow the DA card. By default no such export
	% files are created.
	% Furthermore, normally FEKO writes all the results to the ASCII *.out file. For large datasets
	% (e.g. full far field patterns at many frequency points) this *.out file can become very large. In
	% order to display results in POSTFEKO only the binary output file (*.bof file) is required, and
	% therefore to reduce the size of the *.out file it is possible to switch off certain results in that file
	% (a header is still written so that one knows what type of computations were requested).

	% F = DA(F,Eop, Hopt, FFopt, Copt)
	if isempty(Eopt), Eopt='o'; end
	switch Eopt, case{'o'}, Eopt='0'; case{'fo'}; Eopt='1';case{' '}, Eopt='2'; case{'f'}, Eopt='3';otherwise, error('Unrecognised input in DA card'); end
	if isempty(Hopt), Hopt='o'; end
	switch Hopt, case{'o'}, Hopt='0'; case{'fo'}; Hopt='1';case{' '}, Hopt='2'; case{'f'}, Hopt='3';otherwise, error('Unrecognised input in DA card'); end
	if isempty(FFopt), FFopt='o'; end
	switch FFopt, case{'o'}, FFopt='0'; case{'fo'}; FFopt='1';case{' '}, FFopt='2'; case{'f'}, FFopt='3';otherwise, error('Unrecognised input in DA card'); end
	if isempty(Copt), Copt='o'; end
	switch Copt, case{'o'}, Copt='0'; case{'fo'}; Copt='1';case{' '}, Copt='2'; case{'f'}, Copt='3';otherwise, error('Unrecognised input in DA card'); end

	r='0'; s='0'; t='0'; c='0'; o='2'; f='0';
	for n = 1:length(files)
		switch files(n)
			case{'r', 'R'}, r='1';
			case{'s', 's'}, s='1';
			case{'t', 't'}, t='1';
			case{'c', 'c'}, c='1';
			case{'o', 'o'}, o='0';
			case{'f', 'f'}, f='1';
			otherwise, error('unknown option in DA file');
		end
	end

	
	F.DA{ind} = ['DA   ' Eopt '    ' Hopt '    ' FFopt '    ' Copt '    ' r '    ' s '         ' t '         ' c '         ' o '         ' f];
	ind = ind+1;
