function F = writefaster(s3d,F)

	% function PF = write(s3d,PF,WPNTS)
	%
	% writes all the Fekoshape objects in Feko3dshapes object s3d to PreFeko object PF and
	% returns the PF object now with all the fields such that write(PF) will write out a
	% prefeko file. 
	% WPTS is an optional vector to write all descriptive pnts to the prefeko file. A 0
	% will ignore the points, while a 1 writes out the points. If it is a scalar all Wpnts
	% are assumed to be the same value. For example if there are 3 shapes in the 3D object
	% Wpnts might be [1 0 0], which will write out the descriptive points for the first
	% shape only. If not given, defaults to 0.

	sn = get(s3d, 'fekoshapes');
	
	firstplate = 1;

	for n = 1:length(sn)
		s = sn{n};
		shapename = get(s,'shapename');

		switch get(s,'shapetype')
			case{'plate'}
				F = DPAxyzfaster(F, shapename, get(s, 'edgepoints'),firstplate);
				F = PMfaster(F,s,firstplate);
				firstplate=0;

			case{'curve'}
				if isempty(get(s,'curveanglestartbot')), set(s,'curveanglestartbot', 0); end
				if isempty(get(s,'curveanglestarttop')), set(s,'curveanglestarttop', 0); end
				
				edgepoints = get(s,'edgepoints');
				curveangletop = get(s,'curveangletop');
				curveanglestarttop = get(s,'curveanglestarttop');
				curveanglebot = get(s,'curveanglebot');
				curveanglestartbot = get(s,'curveanglestartbot');
				curvepointsi = get(s,'curvepointsi');
				curvepointso = get(s,'curvepointso');

				maxlengthi =abs(norm(edgepoints(3,:)-edgepoints(1,:)))*...
					(deg2rad(curveanglebot-curveanglestartbot)/(size(curvepointsi)(1)-1));
				maxlengtho =abs(norm(edgepoints(4,:)-edgepoints(2,:)))*...
					(deg2rad(curveangletop-curveanglestarttop)/(size(curvepointso)(1)-1));
				% F = DPAxyz(F, [shapename 'spnts'], edgepoints);
				F = DPAxyzfaster(F,[shapename 'spnts'], edgepoints,1);

				F = KK(F, [shapename 'spnts[1]'],[shapename 'spnts[2]'],[shapename 'spnts[3]'],[shapename 'spnts[4]'],curveanglestartbot,curveanglebot,curveanglestarttop, curveangletop,maxlengtho,maxlengthi,	get(s,'inflag'), [], get(s,'label'),get(s,'material'));

			case{'disk'}

				edgepoints = get(s,'edgepoints');
				diskangle = get(s,'diskangle');
				diskpointsi = get(s,'diskpointsi');
				diskpointso = get(s,'diskpointso');

				maxlengtho =abs(norm(edgepoints(3,:)-edgepoints(1,:)))*...
					(deg2rad(diskangle)/(size(diskpointso)(1)-1));

				% F = DPAxyz(F, [shapename 'spnts'], edgepoints);
				F = DPAxyzfaster(F,[shapename 'spnts'], edgepoints,1);

				if abs(size(edgepoints)(1)-4)<tol,
					maxlengthi =abs(norm(edgepoints(4,:)-edgepoints(1,:)))*...
						(deg2rad(diskangle)/(size(diskpointsi)(1)-1));

					F = KR(F, [shapename 'spnts[1]'],[shapename 'spnts[2]'],[shapename 'spnts[3]'],[shapename 'spnts[4]'],get(s,'diskangle'),maxlengtho,maxlengthi,[],get(s,'label'),get(s,'material')); 
				else
					F = KR(F, [shapename 'spnts[1]'],[shapename 'spnts[2]'],[shapename 'spnts[3]'],[],diskangle,maxlengtho,maxlengtho,[],get(s,'label'),get(s,'material')); 
				end

			case{'port'}
				% Special case so just ignore this object type
			otherwise
				error('shape type unknown in writefekoshape');
		end


	end

