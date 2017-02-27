function F = writefekoshape(F, s, allpnts)

	% writes a feko shape to a writefekoobject

	% for n = 1:

	% Write out all the points in the object
	% get(s, 'edgepoints')

	switch get(s,'shapetype')
		case{'plate'}
			F = DPAxyz(F, get(s,'shapename'), get(s, 'edgepoints'));
			PNTS = get(s,'shapename');
			F = PM(F,PNTS, [],get(s,'Numedgepoints'),get(s,'label')); %msh, [LA]) 

			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CURVE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		case{'curve'}
			if isempty(get(s,'curveanglestartbot')), set(s,'curveanglestartbot', 0); end
			if isempty(get(s,'curveanglestarttop')), set(s,'curveanglestarttop', 0); end
			% s = rtheta

			maxlengthi =abs(norm(get(s,'edgepoints')(3,:)-get(s,'edgepoints')(1,:)))*...
				(deg2rad(get(s,'curveanglebot')-get(s,'curveanglestartbot'))/(size(get(s,'curvepointsi'))(1)-1));

			maxlengtho =abs(norm(get(s,'edgepoints')(4,:)-get(s,'edgepoints')(2,:)))*...
				(deg2rad(get(s,'curveangletop')-get(s,'curveanglestarttop'))/(size(get(s,'curvepointso'))(1)-1));

			F = DPAxyz(F, [get(s,'shapename') 'spnts'], get(s,'edgepoints'));

			F = KK(F, [get(s,'shapename') 'spnts[1]'],[get(s,'shapename') 'spnts[2]'],[get(s,'shapename') 'spnts[3]'],[get(s,'shapename') 'spnts[4]'],get(s,'curveanglestartbot'),get(s,'curveanglebot'),get(s,'curveanglestarttop'), get(s,'curveangletop'),maxlengtho,maxlengthi,	get(s,'inflag'), [], get(s,'label'),get(s,'material'));

			if exist('allpnts') && allpnts>tol, F = DPAxyz(F, [get(s,'shapename') 'copnts'], get(s,'curvepointso')); end
			if exist('allpnts') && allpnts>tol, F = DPAxyz(F, [get(s,'shapename') 'cipnts'], get(s,'curvepointsi')); end

			%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DISK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		case{'disk'}
			maxlengtho =abs(norm(get(s,'edgepoints')(3,:)-get(s,'edgepoints')(1,:)))*...
				(deg2rad(get(s,'diskangle'))/(size(get(s,'diskpointso'))(1)-1));

			F = DPAxyz(F, [get(s,'shapename') 'spnts'], get(s,'edgepoints'));

			if abs(size(get(s,'edgepoints'))(1)-4)<tol,
				maxlengthi =abs(norm(get(s,'edgepoints')(4,:)-get(s,'edgepoints')(1,:)))*...
					(deg2rad(get(s,'diskangle'))/(size(get(s,'diskpointsi'))(1)-1));

				F = KR(F, [get(s,'shapename') 'spnts[1]'],[get(s,'shapename') 'spnts[2]'],[get(s,'shapename') 'spnts[3]'],[get(s,'shapename') 'spnts[4]'],get(s,'diskangle'),maxlengtho,maxlengthi,[],get(s,'label'),get(s,'material')); 
				if exist('allpnts') && allpnts>tol, F = DPAxyz(F, [get(s,'shapename') 'dipnts'], get(s,'diskpointsi')); end
			else
				F = KR(F, [get(s,'shapename') 'spnts[1]'],[get(s,'shapename') 'spnts[2]'],[get(s,'shapename') 'spnts[3]'],[],get(s,'diskangle'),maxlengtho,maxlengtho,[],get(s,'label'),get(s,'material')); 
			end

			if exist('allpnts') && allpnts>tol, F = DPAxyz(F, [get(s,'shapename') 'dopnts'], get(s,'diskpointso')); end
		case{'port'}
			% Special case so just ignore this object type
		otherwise
			error('shape type unknown in writefekoshape');
	end



	% for n=1:get(s,'Numedgepoints')
	% pnts{n} = [get(s,'shapename') '[' num2str(n) ']'];
	% end

	% F = PM(F,pnts, []); %msh, [LA]) 


