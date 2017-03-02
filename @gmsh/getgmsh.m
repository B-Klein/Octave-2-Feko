function sv = getgmsh(Gms, prop)

	switch prop
		case 'name'
			sv=Gms.name;
		case 'gmshsurfs'
			sv=Gms.gmshsurfs;
		case 'duplicatelines'
			sv=Gms.duplicatelines;
		otherwise
			warning('property not found in gmsh object');
			sv =[];
	end
