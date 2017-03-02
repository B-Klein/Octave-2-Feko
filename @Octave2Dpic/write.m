function write(Op)

	% Writes out F.filename file to F.directory
	%
	% Warning : overwrites any existing files!
	% 

	pathtex=[Op.texpath '/' Op.texfile];
	fid = fopen (pathtex, "w");
	if abs(fid+1)<tol, error('failed to open file'); end
	fputs (fid, [Op.header, "\n"]);
	% Draw out all the lines
	%
	for n=1:length(Op.OLines)
		L = Op.OLines{n};
		write(L,fid);
	end


	% try 	
		% for n = 1:size(F.notes)(1)
			% if abs(n-1)<tol, fputs (fid, "** NOTES\n"); end
			% fputs (fid, ['** ' F.notes(n,:) "\n"]);
		% end
		% fputs (fid, "** END OF NOTES\n\n");
	% catch, end

	fputs (fid, [Op.footer, "\n"]);

	fclose(fid);
