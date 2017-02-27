function [y] = read(F,typ)

	% reads in data from file
	% F - @WritePrePeko object
	% typ - type of data

	switch typ
		case{'farfields', 'ff','FF','ffe'}
			filetoread=[F.filename(1:end-3) 'ffe'];
			dirtoread=[F.directory];
			
			f=fopen([dirtoread filetoread]); if (f-1)<tol, error('@WritePreFeko error: unable to open file for reading'); end
			% A DA card will already be filled so this should be used


			d=dlmread(f);
			D=d(13:end,1:9);
			#       "Theta"             "Phi"           "Re(Etheta)"       "Im(Etheta)"        "Re(Ephi)"         "Im(Ephi)"   "Directivity(Theta)" "Directivity(Phi)" "Directivity(Total)"
			clear d;
			d.theta=D(:,1)';
			d.phi=D(:,2)';
			d.EthetaR=D(:,3)';
			d.EthetaI=D(:,4)';
			d.EphiR=D(:,5)';
			d.EphiI=D(:,6)';
			d.Dtheta=D(:,7)';
			d.Dphi=D(:,8)';
			d.Dtot=D(:,9)';
			y=d;



% 			[A, del, hed]=importdata([dirtoread filetoread],'   ', 13); 
% 			size(A.data)
% 			for n=1:15
% 			A.data(2,n)
% 			end
		otherwise
			error('@WritePreFeko function error: unknown or unimplemented option');
	end

