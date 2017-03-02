function Gms=addgmsh(Gms,Gmsa)


	for ns=1:length(Gmsa.gmsurfs)
		Gms=addsurface(Gms,Gmsa.gmsurfs{ns});
	end
