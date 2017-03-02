function [lines linenums] = getlines(Gms,pnts)

	lines=[];
	Nl=0;
	linenums=0;
	for ns=1:length(Gms.gmsurfs)
		pnt=pnts(ns);
		gms=Gms.gmsurfs{ns};
		tmp=get(gms,'lines');
		linetmp=[];
		for n=1:length(tmp)
			line=tmp{1,n};
		%	if abs(length(line)-2)<tol
			linetmp=[linetmp; line+pnt];
		%	end
		end
		linenums=[linenums linenums(ns)+length(linetmp)];
		lines=[lines; linetmp];
	end
