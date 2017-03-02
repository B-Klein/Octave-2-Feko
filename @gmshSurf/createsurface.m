function gms = createsurface(gms,xyzt,xyzb)

% Creates a surface object from xyzt -> xyzb
if abs(nargin-1)<tol % example
	disp('no inputs running a typical example');
	N=25;
	R=2.5;
	x=linspace(-1.4,1.4,N);
	y=sqrt(R^2-x.^2);
	z=linspace(0.1,-0.2,N);
	xyz=[x' y' z'];
	N1=20;
	R1=2;
	x1=linspace(1.4,-1.4,N1);
	y1=sqrt(R1^2-x1.^2);
	z1=linspace(1.2,.5,N1);
	xyz1=[x1' y1' z1'];
	gms=createsurface(gms,xyz,xyz1);
	return
end

lnum=1;
[gms pN]=addpnts(gms,xyzt);
splineV=1:length(xyzt(:,1));
splineV=splineV+pN-length(xyzt(:,1));
gms=setgmshSurf(gms,'lines', lnum, splineV,'spline');lnum=lnum+1;

sp=splineV(1);
ep=splineV(end);

[gms pN]=addpnts(gms,xyzb);
splineV=1:length(xyzb(:,1));
splineV=splineV+pN-length(xyzb(:,1));

gms=setgmshSurf(gms,'lines',lnum, [splineV(end) sp],'line');lnum=lnum+1;
gms=setgmshSurf(gms,'lines',lnum, [ep splineV(1)],'line');lnum=lnum+1;
gms=setgmshSurf(gms,'lines', lnum, splineV,'spline');
gms=setgmshSurf(gms,'lineloops',1:lnum);
snum=1;
gms=setgmshSurf(gms,'surfaces',snum,1,'r');

%gms=setgmshSurf(gms,'lineloop',[
