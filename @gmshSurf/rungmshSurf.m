function [meshout]=rungmshSurf(gms)

% Runs on gmsh

% Assumes that this has been written! 
nodes=[];
vrb=0;
namegeo=getgmshSurf(gms,'dpath');
namemsh=[namegeo(1:(end-3)) 'msh'];

% Creates a feko object from a gmsh object
options=[];
%options=[options " -algo delquad"];%Select mesh algorithm (meshadapt, del2d, front2d, delquad, del3d, front3d, mmg3d, pack)  
% Select output mesh format (auto (default), msh, msh1, msh2, unv, vrml, ply2, stl, mesh, bdf, cgns, p3d, diff, med, ...) 
options=[options " -format mesh"]; 
%options=[options " -order 5"];%Set mesh order (1, ..., 5)  
%options=[options " -optimize_ho"];
options=[options " "]; 
%options=[options " "]; 
runstring=['gmsh -2 ' namegeo options ' -o ' namemsh ';'];
if(vrb),disp(runstring);disp(pwd); end
try
		[cmd, output] = system(runstring, 1); 
		if(vrb) disp(output); end
catch, disp("that didn't work"); end
%system(['cp ' name '.msh' ' test2.msh']);
meshout=readmsh(gms,'mesh');
%meshout=readmsh(gms);%,'mesh');
%nodes=meshout.v(:,1:3);



