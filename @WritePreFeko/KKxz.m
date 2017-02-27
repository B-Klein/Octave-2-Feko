function [ch ind] = KKxz(ch, xzS, xzE, xR, y, angV, mshC,ind, La)

	%			S3
	% S4	 |	 
	% S2 __S1

	%Generate 4 points
	s1 = ['s1Gen_' num2str(ind)];
	s2 = ['s2Gen_' num2str(ind)];
	s3 = ['s3Gen_' num2str(ind)];
	s4 = ['s4Gen_' num2str(ind)];

	% ch=DP(ch,s1,xzS(1)-xzR(1),y,xzE(2),[]);
	% ch=DP(ch,s2,xzS(1)-xzR(1),y,xzS(2)-xzR(2),[]);
	ch=DP(ch,s1,xR,y,xzE(2),[]);
	ch=DP(ch,s2,xR,y,xzS(2),[]);
	ch=DP(ch,s3,xzE(1),y,xzE(2),[]);
	ch=DP(ch,s4,xzS(1),y,xzS(2),[]);

	if exist('La') 
		ch=KK(ch,s1,s2,s3,s4,0,angV(1),0,angV(2),mshC{1},mshC{2},[],[], La);
	else
		ch=KK(ch,s1,s2,s3,s4,0,angV(1),0,angV(2),mshC{1},mshC{2},[],[]);
	end

	ind = ind+1;
