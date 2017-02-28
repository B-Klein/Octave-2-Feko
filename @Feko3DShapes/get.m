function sv = get(s3d, prop)

	switch prop
		case 'name'
			sv = s3d.name;
		case 'fekoshapes'
			sv = s3d.fekoshapes;
		otherwise
			warning('property not found in Feko3Dobject');
			sv =[];
	end
