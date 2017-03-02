function display(L)

	try, 
		if ~isempty(L.linename)
			disp('linename:');
			disp(L.linename);
		end
	catch, end %disp('no tmpf'); 
	try, 
		if ~isempty(L.typ)
			disp('typ:');
			disp(L.typ);
		end
	catch, end %disp('no tmpf'); 
	try, 
		if ~isempty(L.cords)
			disp('cords:');
			disp(L.cords);
		end
	catch, end %disp('no tmpf'); 
	try, 
		if ~isempty(L.label)
			disp('label:');
			disp(L.label);
		end
	catch, end %disp('no tmpf'); 
	try, 
		if ~isempty(L.tmpf)
			disp('tmpf:');
			disp(L.tmpf);
		end
	catch, end %disp('no tmpf'); 
	if(0)
	try, 
		if ~isempty(L.tmpf)
			disp('tmpf:');
			disp(L.tmpf);
		end
	catch, end %disp('no tmpf'); 
end
