function Op = scale(Op, f)

	Lines = Op.OLines;
	for n=1:length(Lines)
		L = Lines{n};
		xy = get(L, 'cords'); 
		xy = f*xy;
		L = set(L,'cords',xy);
		Lines{n} = L;
	end
	Op = set(Op, 'OLines', Lines);
