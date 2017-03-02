function gms = addsurf(gms,gmsn,type,vrb);


if !exist('vrb'), vrb=0; end
% Must have at least points and lines
% Lets check for duplicate points and remove them
xyz=getgmshSurf(gms,'pnts');

if isempty(xyz) % Add to an empty gms file
	gmsn=setgmshSurf(gmsn,'dpath',getgmshSurf(gms,'dpath'));
	gms=gmsn;
	return
end

xyzn=getgmshSurf(gmsn,'pnts');
lines=getgmshSurf(gms,'lines');
linesn=getgmshSurf(gmsn,'lines');
lnOr=length(xyz(:,1));
ind2Add=[];
% First need to find the duplicate points
xyztoadd=[];
for n=1:length(xyzn(:,1))
	xyzc=xyzn(n,1:3);
	ind=findduplicatepoints(xyz,xyzc);
	if isempty(ind) % need to add point and update lines 
		xyztoadd=[xyztoadd; xyzn(n,:)];
		newpointN=lnOr+length(xyztoadd(:,1));		for nn=1:length(linesn(1,:)) % so go through lines and replace points	
			currl=cell2mat(linesn(1,nn));
			indl=find(currl==n);
			if !isempty(indl) %linesn{1,nn}(indl)=newpointN;
%				if vrb, disp('**********'); disp(n); disp('**********'); end
				for nnn=1:length(indl)
					ind2Add=[ind2Add; nn indl(nnn) newpointN];
				end
			end
		end
	else % need to update the lines without adding point
		% ind is now the point which is duplicated
%		if length(ind)>10 %		disp('********'); ind n xyzc xyz(ind,:) disp('********'); %		end
		for nn=1:length(linesn(1,:)) % so go through lines and replace points
			currl=cell2mat(linesn(1,nn));
			indl=find(currl==n);
			if !isempty(indl)
			%ind2Add=[ind2Add; nn indl ind]; 
				for nnn=1:length(indl)
					ind2Add=[ind2Add; nn indl(nnn) ind];
				end
			end
		end
	end
	% and the modify all the lines so that they reference new points
end
for n=1:length(ind2Add(:,1))
	linesn{1,ind2Add(n,1)}(ind2Add(n,2))=ind2Add(n,3);
end

%gms
xyz=[xyz; xyztoadd];
gms=setgmshSurf(gms,'pnts',xyz);
gms=setgmshSurf(gms,'pN',length(xyz));
ln=length(lines);
for n=1:length(linesn(1,:))
	gms=setgmshSurf(gms,'lines',n+ln,linesn{1,n},linesn{2,n});
end

lineloopsn=getgmshSurf(gmsn,'lineloops');
if !isempty(lineloopsn)
	for n=1:length(lineloopsn)
		gms=setgmshSurf(gms,'lineloop',lineloopsn{n}+ln);
	end
end

if !isempty(getgmshSurf(gmsn,'surfaces'))
	lss=length(getgmshSurf(gmsn,'surfaces')(1,:));
	ll=length(getgmshSurf(gms, 'surfaces')(1,:));
	maxi=1;
	for n=1:ll
		cnum=getgmshSurf(gms, 'surfaces')(1,n); cnum=cell2mat(cnum);
		if max(cnum)>maxi,maxi=max(cnum);	end
	end
	ll=maxi;
	for n=1:lss
		cnum=getgmshSurf(gmsn, 'surfaces')(1,n);
		cnum=cell2mat(cnum);
		cnum=cnum+ll;
		%num=n+ll;
		typ=gmsn.surfaces{2,n};
		gms=setgmshSurf(gms,'surfaces',0,cnum,typ);
	end
end




return


break
	n=length(gms.surfaces{1,:});
	gms.surfaces{1,n+1}=surfs;
	gms.surfaces{2,n+1}=type;
