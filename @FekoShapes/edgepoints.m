function s = edgepoints(s, xyz)

	% function s = edgepoint(s, xyz)
	n = length(s.edgepoints); 
	s.edgepoints((n+1):(n+length(xyz)),:) = xyz;
	s = Numedgepoints(s, length(xyz));

	if(0) % adds edge points as cell

	try n = length(s.edgepoints); catch, n=0 end
		% Add matrix handelling, uses recusion to add multiple points
		if abs(size(xyz)(1)-1)>tol 
			for n=1:size(xyz)(1), s = edgepoints(s, xyz(n,:)); end 
		else
			s.edgepoints{n+1} = xyz;
			s = Numedgepoints(s, n+1);
		end
	end
