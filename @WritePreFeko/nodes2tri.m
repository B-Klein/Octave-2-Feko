function F=nodes2tri(F,nodes,name,msh,La);

% takes nodes and creates triangles.

%function F = BT(F, s1,s2,s3,a,b,c,LA)
if ~exist('La'), La=[]; end
tr=nodes.tr;
vr=nodes.v;

[F] = DPAxyz(F,name,vr);

N=length(tr(:,1));
for n=1:N
	F = BT(F,	[name '[' num2str(tr(n,1)) ']'],...
						[name '[' num2str(tr(n,2)) ']'],...
						[name '[' num2str(tr(n,3)) ']'],...
						msh,msh,msh,La);
end
