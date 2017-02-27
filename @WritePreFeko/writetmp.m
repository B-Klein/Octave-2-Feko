function writetmp(F)

	% Writes out F.filename file to F.directory
	%
	% Warning : overwrites any existing files!
	% 

	fpath = [F.directory '/' F.filename];
	fid = fopen (fpath, "w");
	if abs(fid+1)<tol, error('failed to open file'); end

	fputs (fid, [F.header, "\n\n"]);

	indendV = 1;
	try 	
		for n = 1:size(F.notes)(1)
			if abs(n-1)<tol, fputs (fid, "** NOTES\n"); end
			fputs (fid, ['** ' F.notes(n,:) "\n"]);
		end
		fputs (fid, "** END OF NOTES\n\n");
	catch, end

	try 	
		for n = 1:size(F.vars)(1)
			% F.vars{n,1}
			if abs(n-1)<tol, fputs (fid, "** Variables\n"); end
			fputs (fid, [F.vars{n,1} '=' num2str(F.vars{n,2}) "\n"]);
		end
		fputs(fid, "\n");
	catch, end

	try 	
		for n = 1:size(F.varsA)(1)
			% F.varsA{n,1}
			if abs(n-1)<tol, fputs (fid, "** arrays\n"); end
			array = F.varsA{n,2};
			for nn = 1:length(array);
				fputs (fid, [F.varsA{n,1} '[' num2str(nn) ']=' num2str(array(nn)) "\n"]);
			end
		end
		fputs(fid, "\n");
	catch, end

	try 	
		for n = 1:size(F.FM)(1)
			if abs(n-1)<tol, fputs (fid, "** Multilevel Fast Multipole Method (MLFMM) Settings\n"); end
			fputs (fid, [F.FM(n,:) "\n"]);
		end
		fputs(fid, "\n");
	catch, end


	try 	
		for n = 1:size(F.IP)(1)
			if abs(n-1)<tol, fputs (fid, "** Mesh parameters\n"); end
			fputs (fid, [F.IP(n,:) "\n"]);
		end
		fputs(fid, "\n");
	catch, end

	try 	
		for n = 1:size(F.DP)(2)
			if abs(n-1)<tol, fputs (fid, "** Define points\n"); end
			% [F.DP{n} "\n"]
			% a = F.DP{n};
			% a
			fputs (fid, [F.DP{n} "\n"]);
		end
		fputs(fid, "\n");
	catch, end
	
	try 	
		for n = 1:size(F.RM)(2)
			if abs(n-1)<tol, fputs (fid, "** Re-Mesh parameters\n"); end
			fputs (fid, [F.RM{n} "\n"]);
		end
		fputs(fid, "\n");
	catch, end

	if(0) % old ZY card change to KR ME card types
	try 	
		for n = 1:size(F.ZY)(2)
			if abs(n-1)<tol, fputs (fid, "** Cylindical segments\n"); end
			fputs (fid, [F.ZY{n} "\n"]);
		end
		fputs(fid, "\n");
	catch, end
	end

	try 	
		for n = 1:size(F.ZY)(2)
			if abs(n-1)<tol, fputs (fid, "** Cylindrical region\n"); end
			% if ~isempty(F.ZY{n}), fputs (fid, [F.ZY{n} "\n"]); end
			if ~isempty(F.ZY{n}),
				if strcmp(F.ZY{n}(1:2),'ME'),

					if ~exist('beenhere'),fputs (fid, "** moved some ZY cards to ME section \n"); beenhere=1; end
					if strcmp(F.ZY{n+1}(1:2),'LA')
						endV{indendV} = F.ZY{n}; indendV=indendV+1;
						endV{indendV} = F.ZY{n+1}; indendV=indendV+1;
						endV{indendV} = F.ZY{n+2}; indendV=indendV+1;
						F.ZY{n+2}=[];
					else
						endV{indendV} = F.ZY{n}; indendV=indendV+1;
						endV{indendV} = F.ZY{n+1}; indendV=indendV+1;
					end
						
					F.ZY{n+1}=[];
				else
					fputs (fid, [F.ZY{n} "\n"]); 
				end
			end
		end
		clear beenhere;
		fputs(fid, "\n");
	catch, end




	try 	
		for n = 1:size(F.KR)(2)
			if abs(n-1)<tol, fputs (fid, "** Circular region\n"); end
			% if ~isempty(F.KR{n}), fputs (fid, [F.KR{n} "\n"]); end
			if ~isempty(F.KR{n}),
				if strcmp(F.KR{n}(1:2),'ME'),

					if ~exist('beenhere'),fputs (fid, "** moved some KR cards to ME section \n"); beenhere=1; end
					if strcmp(F.KR{n+1}(1:2),'LA')
						endV{indendV} = F.KR{n}; indendV=indendV+1;
						endV{indendV} = F.KR{n+1}; indendV=indendV+1;
						endV{indendV} = F.KR{n+2}; indendV=indendV+1;
						F.KR{n+2}=[];
					else
						endV{indendV} = F.KR{n}; indendV=indendV+1;
						endV{indendV} = F.KR{n+1}; indendV=indendV+1;
					end
						
					F.KR{n+1}=[];
				else
					fputs (fid, [F.KR{n} "\n"]); 
				end
			end
		end
		clear beenhere;
		fputs(fid, "\n");
	catch, end

	try 	
		for n = 1:size(F.KK)(2)
			if abs(n-1)<tol, fputs (fid, "** Conical sections\n"); end
			% if ~isempty(F.KK{n}), fputs (fid, [F.KK{n} "\n"]); end
			if ~isempty(F.KK{n}),
				if strcmp(F.KK{n}(1:2),'ME'),
					if ~exist('beenhere'),fputs (fid, "** moved some KK cards to ME section \n"); beenhere=1; end

					if strcmp(F.KK{n+1}(1:2),'LA')
						endV{indendV} = F.KK{n}; indendV=indendV+1;
						endV{indendV} = F.KK{n+1}; indendV=indendV+1;
						endV{indendV} = F.KK{n+2}; indendV=indendV+1;
						F.KK{n+2}=[];
					else
						endV{indendV} = F.KK{n}; indendV=indendV+1;
						endV{indendV} = F.KK{n+1}; indendV=indendV+1;
					end


					% endV{indendV} = F.KK{n}; indendV=indendV+1;
					% endV{indendV} = F.KK{n+1}; indendV=indendV+1;
					F.KK{n+1}=[];
				else
					fputs (fid, [F.KK{n} "\n"]); 
				end
			end
		end
		clear beenhere
		fputs(fid, "\n");
	catch, end

	try 	
		for n = 1:size(F.PB)(2)
			if abs(n-1)<tol, fputs (fid, "** parabolic sections\n"); end
			% if ~isempty(F.PB{n}), fputs (fid, [F.PB{n} "\n"]); end
			if ~isempty(F.PB{n}),
				if strcmp(F.PB{n}(1:2),'ME'),
					if ~exist('beenhere'),fputs (fid, "** moved some PB cards to ME section \n"); beenhere=1; end

					if strcmp(F.PB{n+1}(1:2),'LA')
						endV{indendV} = F.PB{n}; indendV=indendV+1;
						endV{indendV} = F.PB{n+1}; indendV=indendV+1;
						endV{indendV} = F.PB{n+2}; indendV=indendV+1;
						F.PB{n+2}=[];
					else
						endV{indendV} = F.PB{n}; indendV=indendV+1;
						endV{indendV} = F.PB{n+1}; indendV=indendV+1;
					end


					% endV{indendV} = F.PB{n}; indendV=indendV+1;
					% endV{indendV} = F.PB{n+1}; indendV=indendV+1;
					F.PB{n+1}=[];
				else
					fputs (fid, [F.PB{n} "\n"]); 
				end
			end
		end
		clear beenhere
		fputs(fid, "\n");
	catch, end

	try 	
		for n = 1:size(F.BQ)(2)
			if abs(n-1)<tol, fputs (fid, "** Quadrangle sections\n"); end
			if ~isempty(F.BQ{n}), fputs (fid, [F.BQ{n} "\n"]); end
			% fputs (fid, [F.BQ{n} "\n"]);
		end
		fputs(fid, "\n");
	catch, end

	try 	
		for n = 1:size(F.BT)(2)
			if abs(n-1)<tol, fputs (fid, "** Triangle sections\n"); end
			if ~isempty(F.BT{n}), fputs (fid, [F.BT{n} "\n"]); end
		end
		fputs(fid, "\n");
	catch, end
	
	try 	
		for n = 1:size(F.BP)(2)
			if abs(n-1)<tol, fputs (fid, "** Parallelogram sections\n"); end
			if ~isempty(F.BP{n}), fputs (fid, [F.BP{n} "\n"]); end
		end
		fputs(fid, "\n");
	catch, end

	try 	
		for n = 1:size(F.PM)(2)
			if abs(n-1)<tol, fputs (fid, "** General Polygon sections\n"); end
			if ~isempty(F.PM{n}), fputs (fid, [F.PM{n} "\n"]); end
			% fputs (fid, [F.PM{n} "\n"]);
		end
		fputs(fid, "\n");
	catch, end

	try 	
		for n = 1:size(F.DZ)(2)
			if abs(n-1)<tol, fputs (fid, "** Dielectric cone sections\n"); end
			if ~isempty(F.DZ{n}), fputs (fid, [F.DZ{n} "\n"]); end
			% fputs (fid, [F.DZ{n} "\n"]);
		end
		fputs(fid, "\n");
	catch, end

	try 	
		for n = 1:size(F.PH)(2)
			if abs(n-1)<tol, fputs (fid, "** Plate with hole sections\n"); end
			fputs (fid, [F.PH{n} "\n"]);
		end
		fputs(fid, "\n");
	catch, end

	% Need to put all the ME carded geometries here *deep deep sigh* stupid f)(& edit feko
	try 	
		for n = 1:size(endV)(2)
			if abs(n-1)<tol, fputs (fid, "** ME section, put here to stop inteference with other cards \n"); end
			fputs (fid, [endV{n} "\n"]);
		end
		fputs(fid, "\n");
	catch, end

	try 	
		for n = 1:size(F.SY)(2)
			if abs(n-1)<tol, fputs (fid, "** Symmetries\n"); end
			fputs (fid, [F.SY{n} "\n"]);
		end
		fputs(fid, "\n");
	catch, end

	try 	
		for n = 1:size(F.TG)(2)
			if abs(n-1)<tol, fputs (fid, "** Define Rotations\n"); end
			fputs (fid, [F.TG{n} "\n"]);
		end
		fputs(fid, "\n");
	catch, end

	try 	
		for n = 1:size(F.SF)(1)
			if abs(n-1)<tol, fputs (fid, "** Scaling factors \n"); end
			fputs (fid, [F.SF{n} "\n"]);
		end
		fputs(fid, "\n");
	catch, end
	
	try 	
		for n = 1:size(F.MB)(2)
			if abs(n-1)<tol, fputs (fid, "** Modal Boundry Ports\n"); end
			fputs (fid, [F.MB{n} "\n"]);
		end
		fputs(fid, "\n");
	catch, end

	%%% END GEOMETRY
	fputs(fid, "** End Geometry\nEG\n\n");


	try 	
		for n = 1:size(F.DI)(1)
			if abs(n-1)<tol, fputs (fid, "** Medium parameters\n"); end
			fputs (fid, [F.DI{n} "\n"]);
		end
		fputs(fid, "\n");
	catch, end


	try 	
		for n = 1:size(F.FR)(2)
			if abs(n-1)<tol, fputs (fid, "** Define Frequency Range in Hz\n"); end
			fputs (fid, [F.FR{n} "\n"]);
		end
		fputs(fid, "\n");
	catch, end

	try 	
		for n = 1:size(F.PW)(2)
			if abs(n-1)<tol, fputs (fid, "** Define Power Source\n"); end
			fputs (fid, [F.PW{n} "\n"]);
		end
		fputs(fid, "\n");
	catch, end

	try 	
		for n = 1:size(F.AW)(2)
			if abs(n-1)<tol, fputs (fid, "** Waveguide Excitations\n"); end
			fputs (fid, [F.AW{n} "\n"]);
		end
		fputs(fid, "\n");
	catch, end

	try 	
		for n = 1:size(F.LE)(2)
			if abs(n-1)<tol, fputs (fid, "** Loads \n"); end
			fputs (fid, [F.LE{n} "\n"]);
		end
		fputs(fid, "\n");
	catch, end


	% Solutions 
	% try 	
	% for n = 1:size(F.DA)(2)
	% if abs(n-1)<tol, fputs (fid, "** Control Output variables\n"); end
	% fputs (fid, [F.DA{n} "\n"]);
	% end
	% fputs(fid, "\n");
	% catch, end

	try 	
		for n = 1:size(F.FF)(2)
			if abs(n-1)<tol, fputs (fid, "** Farfield Calculations\n"); end
			if ~isempty(F.DA{n}),fputs (fid, "** (control output variables)\n"); fputs (fid, [F.DA{n} "\n"]); F.DA{n}=[];end
			if ~isempty(F.FF{n}),fputs (fid, [F.FF{n} "\n"]);end
		end
		fputs(fid, "\n");
	catch, end

	try 	
		for n = 1:size(F.FE)(2)
			if abs(n-1)<tol, fputs (fid, "** Near field Calculations\n"); end
			if ~isempty(F.DA{n}),fputs (fid, "** (control output variables)\n"); fputs (fid, [F.DA{n} "\n"]); F.DA{n}=[];end
			if ~isempty(F.FE{n}),fputs (fid, [F.FE{n} "\n"]);end
		end
		fputs(fid, "\n");
	catch, end

	try 	
		for n = 1:size(F.OS)(2)
			if abs(n-1)<tol, fputs (fid, "** Current Calculations\n"); end
			if ~isempty(F.DA{n}),fputs (fid, "** (control output variables)\n"); fputs (fid, [F.DA{n} "\n"]); F.DA{n}=[];end
			if ~isempty(F.OS{n}),fputs (fid, [F.OS{n} "\n"]);end
		end
		fputs(fid, "\n");
	catch, end

	try 	
		for n = 1:size(F.SP)(2)

			if abs(n-1)<tol, fputs (fid, "** S-parameters Calculations\n"); end
			% here=0
			% F.DA
			% n
			if ~isempty(F.DA{n}),fputs (fid, "** (control output variables)\n"); 
				% here=1;
				fputs (fid, [F.DA{n} "\n"]); F.DA{n}=[];
			end
			if ~isempty(F.SP{n}),fputs (fid, [F.SP{n} "\n"]);end
		end
		fputs(fid, "\n");
	catch, end

	fputs(fid, "** End\nEN\n");

	fclose(fid);
