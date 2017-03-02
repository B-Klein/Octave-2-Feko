function write(gms,initvalues)

	prec=15;
	if abs(nargin-1)<tol, 
		icurrpnts=ilines=ilineloops=isurfaces=isurfaceloops=ivolumes=iphysicalsurfaces=iphysicalline=0;
	else 
		icurrpnts=initvalues(1);
		ilines=initvalues(2);
		ilineloops=initvalues(3); 
		isurfaces=initvalues(4);
		isurfaceloops=initvalues(5);
		ivolumes=initvalues(6);
		iphysicalsurfaces=initvalues(7);
		iphysicalline=initvalues(8);
	end

	dpath = getgmshSurf(gms,'dpath');
	fid = fopen (dpath, "w");
	if abs(fid+1)<tol, error('failed to open file'); end


	
	try 	
		if ~isempty(gms.comments),
		flago=fputs (fid, "// Comments\n"); 
		flago=fputs (fid, gms.comments);
		fputs(fid, "\n");
		end
	catch, end
%	indendV = 1;
	try 	
		for n = 1:length(gms.pnts(:,1))
			if abs(n-1)<tol, fputs (fid, "// Variables\n"); end
			fputs (fid, ['Point(' num2str(n+icurrpnts) ')={'...
				num2str(gms.pnts(n,1),prec) ',' num2str(gms.pnts(n,2),prec) ',' num2str(gms.pnts(n,3),prec)...
				',' num2str(gms.pnts(n,4),prec) '};' "\n"]);
		end
		fputs(fid, "\n");
	catch, end


	try 	
		for n = 1:size(gms.lines)(2)
			if abs(n-1)<tol, fputs (fid, "// Lines, Splines, BSplines, Circles and Ellipses\n"); end
			type=gms.lines{2,n};
		 	switch type
				case{'line','l','Line','L'}
					strtmp=['Line(' num2str(n+ilines) ')={' ];
				case{'spline','s','Spline','S'}
					strtmp=['Spline(' num2str(n+ilines) ')={' ];
				case{'bspline','b','BSpline','B'}
					strtmp=['BSpline(' num2str(n+ilines) ')={' ];
				case{'compound','c','Compound','C'}
					strtmp=['Compound Line(' num2str(n+ilines) ')={' ];
				case{'ellipse','e','Ellipse','E'}
					strtmp=['Ellipse(' num2str(n+ilines) ')={' ];
				case{'circle','cr','Circle','Cr'}
					strtmp=['Circle(' num2str(n+ilines) ')={' ];
				otherwise
				warning(['unknown case:' type]);
			end
			for nn=1:(length(gms.lines{1,n})-1)
				strtmp=[strtmp num2str(gms.lines{1,n}(nn)+sign(gms.lines{1,n}(nn)).*icurrpnts) ','];
			end
			strtmp=[strtmp num2str(gms.lines{1,n}(nn+1)+sign(gms.lines{1,n}(nn+1)).*icurrpnts) '};' "\n"];
			fputs(fid,strtmp);
		end
		fputs(fid, "\n");
	catch, end

	try 	
		for n = 1:length(gms.lineloops)
			if abs(n-1)<tol, fputs (fid, "// Line Loops\n"); end
			strtmp=['Line Loop(' num2str(n+ilineloops) ')={'];
			strtmp=[strtmp num2str(gms.lineloops{n}(1)+sign(gms.lineloops{n}(1)).*ilines)];
			for nn=2:length(gms.lineloops{n})
				strtmp=[strtmp ' ,' num2str(gms.lineloops{n}(nn)+sign(gms.lineloops{n}(nn)).*ilines)];
			end
			strtmp=[strtmp '};' "\n"];
			fputs(fid,strtmp);
		end
		fputs(fid, "\n");
	catch, end

	try 	
		for n = 1:size(gms.surfaces)(2)
			if abs(n-1)<tol, fputs (fid, "// Surfaces\n"); end
			type=gms.surfaces{2,n};
		 	switch type
				case{'Plane','plane','P','p'}
					strtmp=['Plane Surface(' num2str(n+isurfaces) ')={' ];
				case{'Ruled','ruled','R','r'}
					strtmp=['Ruled Surface(' num2str(n+isurfaces) ')={' ];
				case{'Compound', 'compound','c','C'}
					strtmp=['Compound Surface(' num2str(n+isurfaces) ')={' ];
				case{'Physical', 'physical','ph','PH'}
					strtmp=['Physical Surface(' num2str(n+isurfaces) ')={' ];
				otherwise
				warning(['unknown case: ' type]);
			end
			%for nn=1:(length(gms.lines{1,n})-1)
			strtmp=[strtmp num2str(gms.surfaces{1,n}(1)+sign(gms.surfaces{1,n}(1)).*ilineloops)];
			for nn=2:length(gms.surfaces{1,n})
				strtmp=[strtmp ' ,' num2str(gms.surfaces{1,n}(nn)+sign(gms.surfaces{1,n}(nn)).*ilineloops)];
			end
			strtmp=[strtmp '};' "\n"];
			fputs(fid,strtmp);
		end
		fputs(fid, "\n");
	catch, end

	try 	
		for n = 1:length(gms.surfaceloops)
			if abs(n-1)<tol, fputs (fid, "// Surface Loops\n"); end
			strtmp=['Surface Loop(' num2str(n+isurfaceloops) ')={'];
			strtmp=[strtmp num2str(gms.surfaceloops{n}(1)+sign(gms.surfaceloops{n}(1)).*ilines)];
			for nn=2:length(gms.surfaceloops{n})
				strtmp=[strtmp ' ,' num2str(gms.surfaceloops{n}(nn)+sign(gms.surfaceloops{n}(nn)).*isurfaces)];
			end
			strtmp=[strtmp '};' "\n"];
			fputs(fid,strtmp);
		end
		fputs(fid, "\n");
	catch, end

	try 	
		for n = 1:size(gms.volume)(2)
			if abs(n-1)<tol, fputs (fid, "// Volumes\n"); end
			type='V'; %gms.volume{2,n};
		 	switch type
				case{'Volume','volume','V','v'}
					strtmp=['Volume (' num2str(n+ivolumes) ')={' ];
				case{'CompoundVolume', 'compoundvolume','cv','CV'} % probably shouldn't be here
					strtmp=['Compound Volume(' num2str(n+ivolumes) ')={' ];
				otherwise
				warning(['unknown case: ' type]);
			end
			here=1
			%for nn=1:(length(gms.lines{1,n})-1)
			strtmp=[strtmp num2str(gms.volume{1,n}(1)+sign(gms.volume{1,n}(1)).*isurfaceloops)];
			for nn=2:length(gms.volume{1,n})
				strtmp=[strtmp ' ,'
				num2str(gms.volume{1,n}(nn)+sign(gms.volume{1,n}(nn)).*isurfaceloops)];
			end
			strtmp=[strtmp '};' "\n"];
			fputs(fid,strtmp);
		end
		fputs(fid, "\n");
	catch, end




	try 	
		for n = 1:length(gms.pointINsurfaces)
			if abs(n-1)<tol, fputs (fid, "// Points in Surfaces\n"); end
			 strtmp = ['Point{' num2str(gms.pointINsurfaces{n}(1)+icurrpnts) '} In Surface {'...
			 num2str(gms.pointINsurfaces{n}(2)+sign(gms.pointINsurfaces{n}(2)).*isurfaces) '};' "\n"];
			fputs (fid, strtmp);
		end
		fputs(fid, "\n");
	catch, end

	try 	
		for n = 1:length(gms.periodicpoints)
			if abs(n-1)<tol, fputs (fid, "// Periodic Lines\n"); end
			fputs (fid, ['Periodic Line(' num2str(gms.periodicpoints{n}(1)+ilineloops) ')=('...
				num2str(gms.periodicpoints{n}(2)+ilineloops,prec) ');' "\n"]);
		end
		fputs(fid, "\n");
	catch, end
	
	try 	
		for n = 1:length(gms.physicalsurface)
			if abs(n-1)<tol, flago=fputs (fid, "// Physical Surfaces\n"); end
% 			fputs (fid, ['Physical Surface(' cell2mat(gms.physicalsurface{n}(1)) ')={'...
% 			num2str(cell2mat(gms.physicalsurface{n}(2))) ...
% 				  '};' "\n"]);
			str = ['Physical Surface(' cell2mat(gms.physicalsurface{n}(1)) ')={'];
			pntsPV = cell2mat(gms.physicalsurface{n}(2));
			nnl=0;
			for nnl=1:(length(pntsPV)-1)
				str = [str num2str(pntsPV(nnl)) ','];
			end
			str = [str num2str(pntsPV(nnl+1)) '};' "\n"];
			fputs (fid, str);
		end
		fputs(fid, "\n");
	catch, end

	try 	
		for n = 1:length(gms.physicalline)
			if abs(n-1)<tol, flago=fputs (fid, "// Physical Line\n"); end
			str = ['Physical Line(' cell2mat(gms.physicalline{n}(1)) ')={'];
			pntsPV = cell2mat(gms.physicalline{n}(2));
			nnl=0;
			for nnl=1:(length(pntsPV)-1)
				str = [str num2str(pntsPV(nnl)) ','];
			end
			str = [str num2str(pntsPV(nnl+1)) '};' "\n"];
			fputs (fid, str);
		end
		fputs(fid, "\n");
	catch, end

	
	
	fclose(fid);
% 	unlink (canonicalize_file_name (dpath));
