function Gms = translateGmsh(Gms,vect)

	%Gms=addsurface(Gms,gms2);
	for ns=1:length(Gms.gmsurfs)
		gms=Gms.gmsurfs{ns};
		gmsn=translateSurf(gms,vect);
		Gms=addsurface(Gms,gmsn);
	end
