function display(a)

	disp('shapename:')
	disp(a.shapename)

	try, 
		if ~isempty(a.Numpoints)
			disp('Numpoints:');
			disp(a.Numpoints);
		end
	catch, end %disp('no Numpoints'); 

	try, 
		if ~isempty(a.Numedgepoints)
			disp('Numedgepoints:');
			disp(a.Numedgepoints);
		end
	catch, end %disp('no Numedgepoints'); 

	try, 
		if ~isempty(a.edgepoints)
			disp('edgepoints:')
			disp(a.edgepoints)
		end
	catch, end %disp('no edgepoints'); 

	try, 
		if ~isempty(a.diskpointso)
			disp('diskpointso:')
			disp(a.diskpointso)
		end
	catch, end %disp('no edgepoints'); 

	try, 
		if ~isempty(a.diskpointsi)
			disp('diskpointsi:')
			disp(a.diskpointsi)
		end
	catch, end %disp('no edgepoints'); 

	try, 
		if ~isempty(a.diskangle)
			disp('diskangle:')
			disp(a.diskangle)
		end
	catch, end %disp('no edgepoints'); 

	try, 
		if ~isempty(a.curvepointsi)
			disp('curvepointsi:')
			disp(a.curvepointsi)
		end
	catch, end %disp('no edgepoints'); 

	try, 
		if ~isempty(a.curvepointso)
			disp('curvepointso:')
			disp(a.curvepointso)
		end
	catch, end %disp('no edgepoints'); 

	try, 
		if ~isempty(a.curveangletop)
			disp('curveangletop:')
			disp(a.curveangletop)
		end
	catch, end %disp('no edgepoints'); 

	try, 
		if ~isempty(a.curveanglestarttop)
			disp('curveanglestarttop:')
			disp(a.curveanglestarttop)
		end
	catch, end %disp('no edgepoints'); 

	try, 
		if ~isempty(a.curveanglebot)
			disp('curveanglebot:')
			disp(a.curveanglebot)
		end
	catch, end %disp('no edgepoints'); 

	try, 
		if ~isempty(a.curveanglestartbot)
			disp('curveanglestartbot:')
			disp(a.curveanglestartbot)
		end
	catch, end %disp('no edgepoints'); 


	try,
		if ~isempty(a.edgelabels)
			disp('edgelabels:')
			disp(a.edgelabels)
		end
	catch, end %disp('no edgelabels'); 

	try,
		if ~isempty(a.points)
			disp('points:')
			disp(a.points)
		end
	catch, end %disp('no points'); 

	try,
		if ~isempty(a.shapetype)
			disp('shapetype:')
			disp(a.shapetype)
		end
	catch, end %disp('no edgelabels'); 

	try,
		if ~isempty(a.label)
			disp('label:')
			disp(a.label)
		end
	catch, end %disp('no edgelabels'); 

	try,
		if ~isempty(a.inflag)
			disp('inflag:')
			disp(a.inflag)
		end
	catch, end %disp('no edgelabels'); 

	try,
		if ~isempty(a.material)
			disp('material:')
			disp(a.material)
		end
	catch, end %disp('no edgelabels'); 
	% try, a.notes;
	% disp('notes:')
	% disp(a.notes)
	% catch, end %disp('no notes'); 
