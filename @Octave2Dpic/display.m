function display(Op)

	try, 
		if ~isempty(Op.name)
			disp('name:');
			disp(Op.name);
		end
	catch, end %disp('no tmpf'); 
	try, 
		if ~isempty(Op.texfile)
			disp('texfile:');
			disp(Op.texfile);
		end
	catch, end %disp('no tmpf'); 
	try, 
		if ~isempty(Op.texpath)
			disp('texpath:');
			disp(Op.texpath);
		end
	catch, end %disp('no tmpf'); 
	try, 
		if ~isempty(Op.header)
			disp('header:');
			disp(Op.header);
		end
	catch, end %disp('no tmpf'); 
	try, 
		if ~isempty(Op.footer)
			disp('footer:');
			disp(Op.footer);
		end
	catch, end %disp('no tmpf'); 
	try, 
		if ~isempty(Op.tmpf)
			disp('tmpf:');
			disp(Op.tmpf);
		end
	catch, end %disp('no tmpf'); 

	for n=1:length(Op.OLines)
		disp(['Octave line ' num2str(n) ':']);
		display(Op.OLines{n});
	end
