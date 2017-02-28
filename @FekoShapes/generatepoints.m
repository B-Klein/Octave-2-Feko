function s = generatepoints(s,res)

	% function s = generatepoints(s,res)
	%
	% generates a linear set of points between each edge and creates a point vector, the
	% edges must be consistent!


	for n=1:(s.Numedgepoints-1)
		len = norm(s.edgepoints{n}-s.edgepoints{n+1}); 
		Np = round(len/res)+1;
		x = linspace(s.edgepoints{n}(1), s.edgepoints{n+1}(1),Np);
		y = linspace(s.edgepoints{n}(2), s.edgepoints{n+1}(2),Np);
		z = linspace(s.edgepoints{n}(3), s.edgepoints{n+1}(3),Np);
		s = points(s, [x' y' z']);
	end

	% Last point to join the object 
	n = s.Numedgepoints;
	len = norm(s.edgepoints{n}-s.edgepoints{1}); 
	Np = round(len/res)+1;
	x = linspace(s.edgepoints{n}(1), s.edgepoints{1}(1),Np);
	y = linspace(s.edgepoints{n}(2), s.edgepoints{1}(2),Np);
	z = linspace(s.edgepoints{n}(3), s.edgepoints{1}(3),Np);
	s = points(s, [x' y' z']);
