function s = transformshape(s,tran1,tran2,name)

	s = set(s,'shapename', [name get(s,'shapename')]);
	edp = get(s,'edgepoints');
	edpT = edp;

	switch tran1
		case{'x'}, t1=1; t1s=1; case{'-x'},  t1=1; t1s=-1;
		case{'y'}, t1=2; t1s=1; case{'-y'},  t1=2; t1s=-1;
		case{'z'}, t1=3; t1s=1; case{'-z'},  t1=3; t1s=-1;
		otherwise
			error{'unknown transform option'};
	end
	switch tran2
		case{'x'}, t2=1; t2s=1; case{'-x'},  t2=1; t2s=-1;
		case{'y'}, t2=2; t2s=1; case{'-y'},  t2=2; t2s=-1;
		case{'z'}, t2=3; t2s=1; case{'-z'},  t2=3; t2s=-1;
		otherwise
			error{'unknown transform option'};
	end

	edp(:,t2)= t1s*edpT(:,t1);
	edp(:,t1)= t2s*edpT(:,t2);
	s = set(s,'edgepoints', edp);
