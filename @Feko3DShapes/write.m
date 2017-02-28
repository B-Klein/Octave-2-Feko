function F = write(s3d,F,npnts)

	% function PF = write(s3d,PF,WPNTS)
	%
	% writes all the Fekoshape objects in Feko3dshapes object s3d to PreFeko object PF and
	% returns the PF object now with all the fields such that write(PF) will write out a
	% prefeko file. 
	% WPTS is an optional vector to write all descriptive pnts to the prefeko file. A 0
	% will ignore the points, while a 1 writes out the points. If it is a scalar all Wpnts
	% are assumed to be the same value. For example if there are 3 shapes in the 3D object
	% Wpnts might be [1 0 0], which will write out the descriptive points for the first
	% shape only. If not given, defaults to 0.

	s = get(s3d, 'fekoshapes');
	if ~exist('npnts'), npnts=0; end
	if abs(length(npnts)-1)<tol, npnts=npnts.*ones(1,length(s)); end
	for n = 1:length(s)
		% npnts(n);
		F = writefekoshape(F, s{n},npnts(n));
	end
