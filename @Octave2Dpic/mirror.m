function Opm = mirror(Op, Axis)

	switch Axis
		case 'x'
			Opm = Octave2Dpic(['mx' get(Op,'name')]);
			lines = get(Op, 'OLines');
			for n=1:length(lines)
				L = lines{n};
				xy = get(L, 'cords');
				xym = [-xy(1,1) xy(1,2); -xy(2,1) xy(2,2)];
				L = set(L, 'cords', xym);
				L = set(L, 'linename', ['mx' get(L, 'linename')]);
				L = set(L,'label',[]);
				Opm = addOLine(Opm,L);
			end
		case 'y'
			Opm = Octave2Dpic(['my' get(Op,'name')]);
			lines = get(Op, 'OLines');
			for n=1:length(lines)
				L = lines{n};
				xy = get(L, 'cords');
				xym = [xy(1,1) -xy(1,2); xy(2,1) -xy(2,2)];
				L = set(L, 'cords', xym);
				L = set(L, 'linename', ['my' get(L, 'linename')]);
				L = set(L,'label',[]);
				Opm = addOLine(Opm,L);
			end

	
		otherwise
			warning('Octave2dpic mirroring case is not implemeneted yet, sorry');
			Opm = [];
	end


