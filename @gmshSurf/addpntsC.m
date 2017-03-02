function [gms pNC]=addpntsC(gms,xyzm,msh)

% Add pnts to gmshSurf object, excepts xyz or xyz+mesh column vector, will add msh
% automatically if needed BUT only for arrays 2 or longer
% This creates points as cells, much more versitile

addN=size(xyzm)(1); %addN=length(xyzm);
if addN<tol, pNC=0; return; end
pntsC=getgmshSurf(gms,'pntsC');
if isempty(pntsC), currN=0; else, currN=size(pntsC)(1); end


for n=1:addN
	pntsC(currN+n,1:3)=xyzm(n,1:3);
	pntsC(currN+n,4)=msh;
end
pNC=getgmshSurf(gms,'pNC');
pNC=pNC+addN;

gms=setgmshSurf(gms,'pNC',pNC);
gms=setgmshSurf(gms,'pntsC',pntsC);
	
