function Op = addOct2Dpic(Op, Opa)

	% Adds all lines from Opa to Op object
	%
	
	lines = get(Opa, 'OLines');
	for n=1:length(lines)
		Op = addOLine(Op,lines{n});
	end
