function mesh=readmsh(Gms,form)

if abs(nargin-1)<tol, form='stand'; end

filename=[Gms.name(1:end-4) '.msh'];
fid = fopen (filename, "rt"); 
if abs(fid+1)<tol, error('could not open file'); end  % checks the -1 fid condition and throws and error

switch form
case{'stand','msh'}%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Looks for string 'FREQ = ' symbol, exits when found, use grep to speed the process up
	Nodestr = "Nodes";

	[sysflag fstpnt] = system (['grep ' Nodestr ' ' filename ' -m 1 -b']);
	if abs(sysflag)>tol, error('could not grep string'); end

	p=findstr(fstpnt, ':');
	bytindex = str2num(fstpnt(1:p-1));
	
	fseek(fid, bytindex);
	str=fgets(fid); % This is the nodes value
	str=fgets(fid);
	numTRI=str2num(str);

	for N=1:numTRI
		str=fgets(fid);
		TRI=str2num(str);
		xyz(TRI(1),:)=TRI(2:end);
	end

	mesh.x=xyz(:,1); mesh.y=xyz(:,2); mesh.z=xyz(:,3);

	Elementstr = "Elements";

	[sysflag fstpnt] = system (['grep ' Elementstr ' ' filename ' -m 1 -b']);
	if abs(sysflag)>tol, error('could not grep string'); end

	p=findstr(fstpnt, ':');
	bytindex = str2num(fstpnt(1:p-1));

	fseek(fid, bytindex);
	str=fgets(fid);% This is the elements value
	str=fgets(fid);
	numELE=str2num(str);

	for N=1:numELE
		str=fgets(fid);
		ELE=str2num(str);

		for n=1:length(ELE)
			ele(ELE(1),n)=ELE(n);
		end
	end
	mesh.e=ele;

case{'mesh'}%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	Vertstr = "Vertices";

	[sysflag fstpnt] = system (['grep ' Vertstr ' ' filename ' -m 1 -b']);
	if abs(sysflag)>tol, error('could not grep string'); end

	p=findstr(fstpnt, ':');
	bytindex = str2num(fstpnt(1:p-1));
	
	fseek(fid, bytindex);
	str=fgets(fid); % This is the nodes value
	str=fgets(fid);
	numVER=str2num(str);

	for N=1:numVER
		str=fgets(fid);
		VER=str2num(str);
		vert(N,1:4)=VER;
	end
	mesh.v=vert;
	
	Edgestr = "Edges";
	[sysflag fstpnt] = system (['grep ' Edgestr ' ' filename ' -m 1 -b']);
	if abs(sysflag)>tol, error('could not grep string'); end

	p=findstr(fstpnt, ':');
	bytindex = str2num(fstpnt(1:p-1));

	fseek(fid, bytindex);
	str=fgets(fid);% This is the elements value
	str=fgets(fid);
	numEDG=str2num(str);

	for N=1:numEDG
		str=fgets(fid);
		EDG=str2num(str);
		edg(N,1:3)=EDG;
	end
	mesh.ed=edg;

	Trianglestr = "Triangles";
	[sysflag fstpnt] = system (['grep ' Trianglestr ' ' filename ' -m 1 -b']);
	if abs(sysflag)>tol, error('could not grep string'); end

	p=findstr(fstpnt, ':');
	bytindex = str2num(fstpnt(1:p-1));

	fseek(fid, bytindex);
	str=fgets(fid);% This is the elements value
	str=fgets(fid);
	numTRI=str2num(str);

	for N=1:numTRI
		str=fgets(fid);
		TRI=str2num(str);
		tri(N,1:4)=TRI;
	end
	mesh.tr=tri;

otherwise%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	warning("don't know how to read this yet, giving up :(");mesh=[];
end

fclose(fid);
