function [gms pN]=addpnts(gms,xyzm,msh)

% Add pnts to gmshSurf object, excepts xyz or xyz+mesh column vector, will add msh
% automatically if needed BUT only for arrays 2 or longer

% Add in an option to check if it's a cell to suppourt variables


if length(xyzm)<tol, pN=0; return; end

pnts=getgmshSurf(gms,'pnts');
% Check if there is no mesh parameter setgmshSurf
if ~abs(exist('msh')-1)<tol, msh=0; end

if abs(length(xyzm(1,:))-3)<tol, xyzm(1,4)=msh; end

for n=1:length(xyzm(:,1))
	if abs(n-1)<tol
		if(xyzm(1,4)<tol),xyzm(1,4)=abs(norm(xyzm(1,1:3)-xyzm(2,1:3)));	end
	else
		if(xyzm(n,4)<tol),xyzm(n,4)=abs(norm(xyzm(n,1:3)-xyzm(n-1,1:3)));	end
	end
end

pnts=[pnts; xyzm];
gms=setgmshSurf(gms,'pnts', pnts);
pN=getgmshSurf(gms,'pN');
pN=pN+length(xyzm(:,1));
gms=setgmshSurf(gms,'pN',pN);
