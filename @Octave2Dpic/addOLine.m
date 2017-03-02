function Op = addOLine(Op, L)

	%	function Op = addOLine(Op, L)
	%	adds OLine L to Octave2Dpic Op

	Op.OLines{length(Op.OLines)+1} = L;
