%  Creates a simple square object

% You should have added the @WritePreFeko directory to your path, you might need to add
% if from the base directory otherwise you might get class errors.

% Let get the current directory and 
CurrentDirectory=pwd;

Filename='SimpleSquare.pre';
Directory=[CurrentDirectory '/PreFiles'];

% Create the WritePreFeko Object with a filename and directory where we wish to save the
% .pre file
F=WritePreFeko(Filename, Directory)
% Let's put in a comment including time stamping the file.
F=header(F, 'Simple Square example');

% In order to create the square we need to define the edge points first.
%
%   d ------SqL------- c 
%   |                  |
%   |                  |
%   |                  |
%   |                  |
%   |                  |
%   |                  |
%   |                  |
%   a ---------------- b

SqL=1;
% We must now define the points, the most basic way is to define the points
% individually, in x y and z, use DPA and DPxyz for adding more points.
F=DP(F, 'a', 0, 0, 0);
F=DP(F, 'b', SqL, 0, 0);
F=DP(F, 'c', SqL, SqL, 0);
F=DP(F, 'd', 0, SqL, 0);

% Let's create the square using the BQ quadrangle card
F=BQ(F,'a','b','c','d');

% Let's now add the meshing rules, we only need to add the maximum triangle edge length.
TriLength=SqL/10;
F=IP(F,[],TriLength,[],[],[]);

% We are now ready to create the square
write(F);


