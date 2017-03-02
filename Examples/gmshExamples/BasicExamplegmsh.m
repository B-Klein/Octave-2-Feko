% Script following gmshDocumention
clc;
clear;
% This will create files in the current directory

latex=1; % This creates a latex drawing, set this to 1 only if you have installed and
				 % tested the latex class function @OLine and @Octave2Dpic
linux=1; % Tested on linux, will attempt to work in windows

CurrentDirectory=pwd;
if linux, 
	dpath=[CurrentDirectory '/geofiles/' 'basicobjectgmsh.geo'];
	if latex, latexdirectory=[CurrentDirectory '/' 'texfiles']; end
else
	dpath=[CurrentDirectory '\geofiles\' 'basicobject.geo'];
	if latex, latexdirectory=[CurrentDirectory '\' 'texfiles']; end
end
disp(['writing to file: ' dpath]);
% disp(['Creating @gmshSurf object ''A'' with path : ' dpath]);
G=gmsh(dpath);
A=gmshSurf;
mshv=0.5; % Set the general mesh resolution for all points
mshvd=0.25; % Set the mesh resolution for point d
sqz=2;
a=[-sqz -sqz 0 mshv];
b=[-sqz  sqz 0 mshv];
c=[ sqz  sqz 0 mshv];
d=[ sqz -sqz 0 mshvd];
A=addpnts(A, [a; b; c; d]); % add multiple points
ltype='Line';
[A lna]=addlines(A,[1 2],ltype); % line 1
[A lnb]=addlines(A,[2 3],ltype); % line 2
[A lnc]=addlines(A,[3 4],ltype); % line 3
[A lnd]=addlines(A,[4 1],ltype); % line 4
[A lnloopa]=addlineloops(A,[lna lnb lnc lnd]); % lineloop 1
stype='Plane';
[A surfa]=addsurfaces(A,lnloopa,stype);
% Add surfaces A to the larger object
G=addsurface(G,A);

B=gmshSurf;
a=a+[2*sqz 0 0 -mshvd];
b=b+[2*sqz 0 0 0];
c=c+[2*sqz 0 0 0];
d=d+[2*sqz 0 0 mshvd];
B=addpnts(B, [a; b; c; d]); % add multiple points
ltype='Line';
[B lna]=addlines(B,[1 2],ltype); % line 1
[B lnb]=addlines(B,[2 3],ltype); % line 2
[B lnc]=addlines(B,[3 4],ltype); % line 3
[B lnd]=addlines(B,[4 1],ltype); % line 4
[B lnloopa]=addlineloops(B,[lna lnb lnc lnd]); % lineloop 1
stype='Plane';
[B surfa]=addsurfaces(B,lnloopa,stype);
% Add surfaces B to the larger object
G=addsurface(G,B);
% We can now write out the compisite object
write(G);
% We can now directly run GMSH
meshout=rungmsh(G);

if latex, 
	% Let write this out to a latex file
	name='basicsquareexample2.tex';
	op=Octave2Dpic(name(1:end-4));
	op=set(op,'texfile',name);
	op=set(op,'texpath',latexdirectory);
	op=set(op,'header',['% a simple square to demonstrate gmshSurf']);
	op=set(op,'footer',['% all done']);
	L=OLine('1st Line');
% 	label=['$Line_{\text{\scalebox{.8}{' num2str(2) '}}}$'];
% 	L=set(L,'label', {[],[],'yshift=-2.5,right=,font=\tiny,black', label}); 
% 	label=['$L_1$']; L=set(L,'label', {[],[],',left=,font=\tiny,black', label}); 
	L=set(L, 'cords', [a(1:2);b(1:2)]); op=addOLine(op,L);
% 	label=['$L_2$']; L=set(L,'label', {[],[],',above=,font=\tiny,black', label}); 
	L=set(L, 'cords', [b(1:2);c(1:2)]); op=addOLine(op,L);
% 	label=['$L_3$']; L=set(L,'label', {[],[],',right=,font=\tiny,black', label}); 
	L=set(L, 'cords', [c(1:2);d(1:2)]); op=addOLine(op,L);
% 	label=['$L_4$']; L=set(L,'label', {[],[],',below=,font=\tiny,black', label}); 
	L=set(L, 'cords', [d(1:2);a(1:2)]); op=addOLine(op,L);
	op=nodes2latex(op,meshout);
	write(op)
end





