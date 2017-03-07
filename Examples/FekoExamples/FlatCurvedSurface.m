%  Creates a flat curved surface object

% You should have added the @WritePreFeko directory to your path, you might need to add
% it from the base directory otherwise you might get class errors.

% RUN THIS FROM THE Examples/FekoExamples/ directory
% Otherwise set the Directory variable to the desired directory

% Let get the current directory and 
CurrentDirectory=pwd;
Filename='FlatCurvedSurface.pre';
Directory=[CurrentDirectory '/PreFiles'];

% Create the WritePreFeko Object with a filename and directory where we wish to save the
% .pre file
F=WritePreFeko(Filename, Directory);
% Let's put in a comment including time stamping the file.
F=header(F, 'Flat curved surface example');

% We can now demonstrate how to create a curved surface
%
%   							b 
%             ___/|
%          __/    |
%        _/       |
%      /          |
%     /           |
%    /            |
%   a ------------c
%
SqL=1;

% Define the points
a=[0 0 0];
b=[SqL SqL 0];
c=[SqL 0 0];

% Let's generate the points from a->b
N=20;

x=linspace(a(1),b(1),N);
y=sin(x*(pi/2)/max(x));
y=y.*(b(2))/max(y);
ab=[x' y' linspace(a(3),b(3),N)'];

% adding in the last point
pnts=[ab; c];

% We can add all these points as an array
F=DPAxyz(F,'pnts',pnts);
% And add them all as a polynomial object using the PM card
F=PM(F,'pnts',[],size(pnts)(1));

% We need to set the meshing rules
TriLength=SqL/10;
F=IP(F,[],TriLength,[],[],[]);

write(F);




