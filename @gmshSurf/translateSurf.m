function gmsn = translateSurf(gms,vect)


gmsn=gms;

name=[tmpnam];
namegeo=[name ".geo"];
gmsn=setgmshSurf(gmsn,'dpath', namegeo); %gmshSurf(namegeo);

xyz=getgmshSurf(gms,'pnts');
for n=1:3, xyz(:,n)=xyz(:,n)+vect(n); end
gmsn=setgmshSurf(gmsn,'pnts',xyz);
