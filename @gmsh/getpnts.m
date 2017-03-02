function [xyz pnts] = getpnts(Gms)

	xyz=[];
	pnts=0;
	N=0;
	for ns=1:length(Gms.gmsurfs)
		gms=Gms.gmsurfs{ns};
		tmp=get(gms,'pnts');
		xyz=[xyz; tmp];
		N=length(tmp);
		pnts=[pnts N+pnts(ns)];
	end
