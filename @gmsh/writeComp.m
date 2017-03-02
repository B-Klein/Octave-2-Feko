function write(Gms,compound)
	
	if abs(nargin-1)<tol, compound=0; end

	name=get(Gms,'name');
	%if abs(fid+1)<tol, error('failed to open file'); end
	runstring=['cat '];
	currpnts=lines=lineloops=surfaces=0;
	surfs=[];
	for ns=1:length(Gms.gmsurfs)
		gms=Gms.gmsurfs{ns};
	%	if isempty(get(gms,'surfaces')), nsurfaces=surfaces; else...
	%	nsurfaces=surfaces+length(get(gms,'surfaces')(1,:)); end
	
		if !isempty(get(gms,'surfaces')), surfs=[surfs surfaces+length(get(gms,'surfaces')(1,:))]; end
		write(gms,[currpnts lines lineloops surfaces]);
		
		fname=get(gms,'dpath');
		runstring=[runstring fname ' '];
		%fname=['"' fname '"'];
		
		if !isempty(get(gms,'pnts')),	currpnts=currpnts+length(get(gms,'pnts')(:,1)); end
		if !isempty(get(gms,'lines')),lines=lines+length(get(gms,'lines')(1,:)); end
		if !isempty(get(gms,'lineloops')),lineloops=lineloops+length(get(gms,'lineloops')(1,:)); end
		if !isempty(get(gms,'surfaces')),surfaces=surfaces+length(get(gms,'surfaces')(1,:)); end
%		if !isempty(get(gms,'pnts')),	surfaces=surfaces+length(get(gms,'surfaces')(1,:));
	end

%	fputs (fid, ["Compound Surface(" num2str(max(surfs)+1) ")={"fname "; \n"]); 
	runstring=[runstring '> ' name];
	vrb=1;
	try
		[cmd, output] = system(runstring, 1); 
		if(vrb) disp(output); end
	catch, disp("that didn't work"); end
	
	fid=fopen(name, "a+");
	if(compound)
		str=["Compound Surface(" num2str(max(surfs)+1) ")={"];
		for n=1:(length(surfs)-1), str=[str num2str(surfs(n)) ", "];	 end
		str=[str num2str(surfs(end)) "}; \n"]; 
		fputs (fid,str);
		fputs (fid,['Mesh.RemeshAlgorithm=1;' " \n"]);
	end

	for n=1:length(Gms.duplicatelines)
		tmp=Gms.duplicatelines(n,:);
		str=['Periodic Line{' num2str(tmp(1)) '}={' num2str(tmp(2)) '};' " \n"];
		fputs (fid,str);
	end




	fputs (fid,['Geometry.MatchGeomAndMesh=1;' " \n"]);
	fputs (fid,['Coherence Mesh;' " \n"]);
	fclose(fid);
% 	unlink (canonicalize_file_name (name));
