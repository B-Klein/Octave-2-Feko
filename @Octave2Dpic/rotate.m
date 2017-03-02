function Opr = rotate(Op, ang)


	Opr = Op;
	Opr = set(Opr, 'name', ['r' num2str(ang) get(Op,'name')]);
	lines = get(Op, 'OLines');
	for n=1:length(lines)
		L = lines{n};
		xy = get(L, 'cords');
		R = [cos(ang) -sin(ang); sin(ang) cos(ang)];
		xyr(1,:) = R*xy(1,:)';
		xyr(2,:) = R*xy(2,:)';
		xyr = round(xyr*(1/tol))*tol; % prevents -e16 issues
		L = set(L, 'cords', xyr);
		linesr{n} = L;
	end


		Opr = set(Opr, 'OLines', linesr); 
