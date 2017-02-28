function N = findshape(s3d,name)

	% function n = findshape(s3d,name)
	%
	% Finds the number of a paticular shape based on a name identifier
	%
	
	% tmp = s3d.fekoshapes{1};
	% tmp = set(tmp, "shapename",'roger');
	% tmp
	% tmp.name
	N=[];
	for n = 1:length(s3d.fekoshapes)
		namec = get(s3d.fekoshapes{n}, 'shapename');
		if strcmp(name, namec), 
			N=n;
		end
	end

	if isempty(N), warning(['No shape ' name ' found']); end
