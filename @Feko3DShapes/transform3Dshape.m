function s3dt = transform3Dshape(s3d,tran1,tran2,name)

% function s3d = transform3Dshape(s3d,tran1,tran2,name)
%
% transforms every shape in a 3d object and appends the name 'name' to the front
%

	s3dt = Feko3DShapes([name get(s3d,'name')]);
	s = get(s3d, 'fekoshapes');
	for n = 1:length(s)
		st = transformshape(s{n},tran1,tran2,name);
		s3dt = addshape(s3dt, st);
	end


