function s = edgelabels(s, xyzl, pnt)

	% function s = edgelabels(s, xyz,pnt)
	%
	% Add labels to specific points for ease of references later on
	
	ind = 1;
	for n=pnt
		s.edgelabels{n} = xyzl{ind}; ind=ind+1;
	end
