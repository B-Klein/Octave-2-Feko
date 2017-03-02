function [surfaces] = getsurfaces(Gms,lineloops)

	surfs=[];
	Nl=0;
	surftmps=0;
	for ns=1:length(Gms.gmsurfs)
		pnt=lineloops(ns);
		gms=Gms.gmsurfs{ns};
		tmp=get(gms,'surfaces');
		tmp=tmp{1,:};
		surfstmp=[];
		for n=1:length(tmp)
			surfs{n}=tmp+pnt; % {1,n}; surfstmp=[surfstmp; surfs+pnt];
		end
		surfaces{ns}=surfs;
%		surftmps=[surftmps surftmps(ns)+length(surftmp)];
%		surfs=[surfs; surftmp];
	end
