function [sa sb] = minusshapes(s, sn, pnts,res)

	% function [sa sb] = minusshapes(s, sn, pnts,res)
	%  
	% minus shape sn from s, and return resulting shapes sa sb.
	% pnts is a matrix of positive point 1 2 and negative points 1 2
	% pnts = [pp1; pp2; np1; np2];
	% point pp1 is closest to point np1
	% These are the lines along which the shape is cut out from. Theoretically only one
	% cut is required but two work better in practice, not sure why...
	%
	% res is a two valued vector the resolution between pp1->np1 and pp2->np2, if a single
	% value assumes the same value for both values
	%
	% Orientation of the shapes must be the SAME, so if s's points are clockwise, then so
	% must sn's points.
	%
	% If too many matching points or none, use DPAxyz to diagnose the problem.

	% 15/01/2013 Added handelling of disk shapes
	%
	sa = []; sb  = [];	
	% pn
	if length(res)<2, res(2)=res(1); end

	pp = pnts(1:2,:);
	
	switch get(s,'shapetype')
		case{'plate'}
			sp = get(s, 'edgepoints');
		case{'disk'}
			sp = get(s,'diskpointso');
	end
	indA = ismember(sp, pp(1,:), 'rows'); indA = find(indA==1);
	indB = ismember(sp, pp(2,:), 'rows'); indB = find(indB==1);

	if abs(length(indA)-1)>tol, error('too many matching points in positive shape'); end
	if abs(length(indA)-1)>tol, error('too many matching points in positive shape'); end
	if abs(length(indB))<tol, error('no matching points in positive shape'); end
	if abs(length(indB))<tol, error('no matching points in positive shape'); end

	np = pnts(3:4,:);

	switch get(sn,'shapetype')
		case{'plate'}
			sn = get(sn, 'edgepoints');
		case{'disk'}
			sn = get(sn,'diskpointso');
	end
	indnA = ismember(sn, np(1,:), 'rows'); indnA = find(indnA==1);
	indnB = ismember(sn, np(2,:), 'rows'); indnB = find(indnB==1);

	if abs(length(indnA)-1)>tol, error('too many matching points in negative shape'); end
	if abs(length(indnA)-1)>tol, error('too many matching points in negative shape'); end
	if abs(length(indnB))<tol, error('no matching points in negative shape'); 
	end
	if abs(length(indnB))<tol, error('no matching points in negative shape'); end

	N = round(abs(norm(pp(1,:)-np(1,:)))/res(1));
	xyzC1 = [linspace(pp(1,1),np(1,1),N)' linspace(pp(1,2),np(1,2),N)' linspace(pp(1,3),np(1,3),N)'];
	N = round(abs(norm(pp(2,:)-np(2,:)))/res(2));
	xyzC2 = [linspace(np(2,1),pp(2,1),N)' linspace(np(2,2),pp(2,2),N)' linspace(np(2,3),pp(2,3),N)'];

	% create Object A and B
	ind = indA:indB;
	spA = 	sp(ind,:);
	ind = [1:(indA) (indB):length(sp)];
	ind = [(indB):length(sp) 1:(indA)]; %ind = ind(end:-1:1); 
	% ind
	spB =  sp(ind,:);

	% Get negative points
	indn = indnA:indnB;
	sn1 = 	sn(indn,:);
	indn = [1:(indnA) (indnB):length(sn)];
	indn = [(indnB):length(sn) 1:(indnA)]; indn = indn(end:-1:1); 
	sn2 =  sn(indn,:);

	% Determine which negative object attaches to object A

	meansA = [mean(spA(:,1)) mean(spA(:,2)) mean(spA(:,3))];
	meansn1 = [mean(sn1(:,1)) mean(sn1(:,2)) mean(sn1(:,3))];
	meansn2 = [mean(sn2(:,1)) mean(sn2(:,2)) mean(sn2(:,3))];

	diff1 = sum(abs(meansA-meansn1));
	diff2 = sum(abs(meansA-meansn2));

	if diff2 > diff1 % attach spA with sn1

		tmp = [xyzC1; sn1; xyzC2];
		xyz  = [spA(end:-1:1,:); tmp];
		xyz = removeduplicatesxyz(xyz);
		sa = FekoShapes([get(s,'shapename') 'A']);
		sa = edgepoints(sa,	xyz);

		tmp = [xyzC1; sn2; xyzC2];
		% spB
		% xyzC1
		% sn2
		% xyzC2
		xyz  = [spB; tmp];
		xyz = removeduplicatesxyz(xyz);
		sb = FekoShapes([get(s,'shapename') 'B']);
		sb = edgepoints(sb,	xyz);



	else % attach spA with sn2
	end







	return
	sa = FekoShapes([get(s,'shapename') 'A']);
	xyz = [sp(indA:indB,:);sn(indnB:-1:indnA,:)];
	sa = edgepoints(sa,	xyz);

	sb = FekoShapes([get(s,'shapename') 'B']);
	ind = [1:(indA) (indB):length(sp)];
	xyz = [sp(ind,:)];
	sb = edgepoints(sb,	xyz);

