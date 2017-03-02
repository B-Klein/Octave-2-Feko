function [lineloops lln] = getlineloops(Gms,lines)

	lln=0;
	ind=1;
	for ns=1:length(Gms.gmsurfs)
		gms=Gms.gmsurfs{ns};
		cll=get(gms,'lineloops');
		for n=1:length(cll)
			lineloops{ind}=cll{n}+lines(ns);ind=ind+1;
		end
		lln=[lln lln(ns)+n];
	end
