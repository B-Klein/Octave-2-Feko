// Variables
Point(1)={-2,-2,0,0.5};
Point(2)={-2,2,0,0.5};
Point(3)={2,2,0,0.5};
Point(4)={2,-2,0,0.25};

// Lines, Splines, BSplines, Circles and Ellipses
Line(1)={1,2};
Line(2)={2,3};
Line(3)={3,4};
Line(4)={4,1};

// Line Loops
Line Loop(1)={1 ,2 ,3 ,4};

// Surfaces
Plane Surface(1)={1};







// Variables
Point(5)={2,-2,0,0.25};
Point(6)={2,2,0,0.5};
Point(7)={6,2,0,0.5};
Point(8)={6,-2,0,0.5};

// Lines, Splines, BSplines, Circles and Ellipses
Line(5)={5,6};
Line(6)={6,7};
Line(7)={7,8};
Line(8)={8,5};

// Line Loops
Line Loop(2)={5 ,6 ,7 ,8};

// Surfaces
Plane Surface(2)={2};







Geometry.MatchGeomAndMesh=1; 
Coherence Mesh; 
