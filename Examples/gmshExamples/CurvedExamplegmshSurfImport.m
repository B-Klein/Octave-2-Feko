% Script following gmshDocumention
clc;
clear;
% This will create files in the current directory

latex=0; % This creates a latex drawing, set this to 1 only if you have installed and
				 % tested the latex class function @OLine and @Octave2Dpic
linux=1; % Tested on linux, will attempt to work in windows

CurrentDirectory=pwd;
if linux, 
	dpath=[CurrentDirectory '/geofiles/' 'curvedobjectimport.geo'];
	if latex, latexdirectory=[CurrentDirectory '/' 'texfiles']; end
else
	dpath=[CurrentDirectory '\geofiles\' 'basicobject.geo'];
	if latex, latexdirectory=[CurrentDirectory '\' 'texfiles']; end
end

disp(['writing to file: ' dpath]);
disp(['Creating @gmshSurf object ''A'' with path : ' dpath]);
A=gmshSurf(dpath);
% Let's create a curved surface y=y0*sin^2(x/x0) x: 0 -> x0*pi/2
mshv=0.5; % Set the general mesh resolution for all points
N=20;
y0=4;
x0=5;
x=linspace(0,x0*pi/2,N);
y=y0*sin(x/x0).^2;
pnts=[x' y' zeros(length(x),1) mshv*ones(length(x),1)];
A=addpnts(A, pnts);
endpnt=[x(end) y(1) 0 mshv];
[A pN]=addpnts(A, endpnt);
ltype='lines';
lnum=1;
for n=2:pN, A=set(A,ltype,lnum,[n-1 n],'l');lnum=lnum+1; end; 
A=set(A,'lines',lnum,[n 1],'l');lnum=lnum+1; % put in the last point
A=set(A,'lineloops',1:(lnum-1));
snum=1;
A=set(A,'surfaces',0,1,'p');snum=snum+1;
write(A);
meshout=rungmshSurf(A);

% First we get the nodes out of the mesh
nodes=readmsh(A,'mesh');
filename=[ 'curvedobjectimport.pre'];
C=WritePreFeko(filename, [CurrentDirectory '/geofiles/']);
C=header(C, 'Testing gmsh to feko'); 
C=notes(C, 'Testing of gmsh to feko');
% Convert the nodes to triangles, and add them to the FEKO object
C=nodes2tri(C,nodes,'test',1,'PEC');
disp('finished converting gmsh object to feko object'); 
C=IP(C,[],1,[],[],[]);
write(C);



if latex, 
	% Let write this out to a latex file
	name='curvedexample1.tex';
	op=Octave2Dpic(name(1:end-4));
	op=set(op,'texfile',name);
	op=set(op,'texpath',latexdirectory);
	op=set(op,'header',['% a simple square to demonstrate gmshSurf']);
	op=set(op,'footer',['% all done']);
% 	L=OLine('1st Line');
% 	label=['$Line_{\text{\scalebox{.8}{' num2str(2) '}}}$'];
% 	L=set(L,'label', {[],[],'yshift=-2.5,right=,font=\tiny,black', label}); 
% 	label=['$L_1$']; L=set(L,'label', {[],[],',left=,font=\tiny,black', label}); 
% 	L=set(L, 'cords', [a(1:2);b(1:2)]); op=addOLine(op,L);
% 	label=['$L_2$']; L=set(L,'label', {[],[],',above=,font=\tiny,black', label}); 
% 	L=set(L, 'cords', [b(1:2);c(1:2)]); op=addOLine(op,L);
% 	label=['$L_3$']; L=set(L,'label', {[],[],',right=,font=\tiny,black', label}); 
% 	L=set(L, 'cords', [c(1:2);d(1:2)]); op=addOLine(op,L);
% 	label=['$L_4$']; L=set(L,'label', {[],[],',below=,font=\tiny,black', label}); 
% 	L=set(L, 'cords', [d(1:2);a(1:2)]); op=addOLine(op,L);
	op=nodes2latex(op,meshout);
	write(op)
end








