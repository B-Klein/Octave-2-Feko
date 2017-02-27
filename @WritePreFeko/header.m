function F = header(F, header, ign)

	% Writes the header for the file
	%
	% INPUT
	%		ign : do not add a standard header can be anything
	%		header : header to put at top of the file
	%		F : WritePreFeko object

	if exist('ign'), 	F.header = header; return; end
	
	D = clock(date);
	TimeAdate = [ num2str(D(1)) '-' num2str(D(2)) '-' num2str(D(3)) ...
		' @ ' num2str(D(4)) ':' num2str(D(5)) ':' num2str(round(D(6)))]; 

	if(exist('header'))
		F.header = ['** PREFEKO input file generated in Octave on: '  TimeAdate ' ' header];
	else
		F.header = ['** PREFEKO input file generated in Octave on: '  TimeAdate];
	end
