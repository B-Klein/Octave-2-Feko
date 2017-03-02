function op=nodes2latex(op,nodes,plane,lineoptions)
% takes nodes and creates triangles for latex


if ~exist('plane'), plane='xy'; end
if ~exist('lineoptions'), lineoptions='line width=0.01mm'; end
% tr=nodes.tr;
vr=nodes.v;
ed=nodes.ed;
tr=nodes.tr;
% [F] = DPAxyz(F,name,vr);
N=length(tr(:,1));
L=OLine('mesh line');
L = set(L, 'options', [lineoptions]);

prec=1E5;
precn=1/prec;
% create all triangles might create duplicate lines
% Assumes the triangles are going to be in the XY domain
switch plane
case{'xy'}
	for n=1:N
			ln1=[tr(n,1) tr(n,2)];
			ln2=[tr(n,2) tr(n,3)];
			ln3=[tr(n,3) tr(n,1)];
			L=set(L, 'cords',...
				 [precn*round(vr(ln1(1),1:2)*prec); precn*round(vr(ln1(2),1:2)*prec)]); 
			op=addOLine(op,L);
			L=set(L, 'cords',...
				 [precn*round(vr(ln2(1),1:2)*prec); precn*round(vr(ln2(2),1:2)*prec)]); 
			op=addOLine(op,L);
			L=set(L, 'cords',...
				 [precn*round(vr(ln3(1),1:2)*prec); precn*round(vr(ln3(2),1:2)*prec)]); 
			op=addOLine(op,L);
	end

case{'xz'}
	for n=1:N
			ln1=[tr(n,1) tr(n,2)];
			ln2=[tr(n,2) tr(n,3)];
			ln3=[tr(n,3) tr(n,1)];
			L=set(L, 'cords',...
				 [precn*round(vr(ln1(1),[1 3])*prec); precn*round(vr(ln1(2),[1 3])*prec)]); 
			op=addOLine(op,L);
			L=set(L, 'cords',...
				 [precn*round(vr(ln2(1),[1 3])*prec); precn*round(vr(ln2(2),[1 3])*prec)]); 
			op=addOLine(op,L);
			L=set(L, 'cords',...
				 [precn*round(vr(ln3(1),[1 3])*prec); precn*round(vr(ln3(2),[1 3])*prec)]); 
			op=addOLine(op,L);
	end
case{'yz'}
	for n=1:N
			ln1=[tr(n,1) tr(n,2)];
			ln2=[tr(n,2) tr(n,3)];
			ln3=[tr(n,3) tr(n,1)];
			L=set(L, 'cords',...
				 [precn*round(vr(ln1(1),[2 3])*prec); precn*round(vr(ln1(2),[2 3])*prec)]); 
			op=addOLine(op,L);
			L=set(L, 'cords',...
				 [precn*round(vr(ln2(1),[2 3])*prec); precn*round(vr(ln2(2),[2 3])*prec)]); 
			op=addOLine(op,L);
			L=set(L, 'cords',...
				 [precn*round(vr(ln3(1),[2 3])*prec); precn*round(vr(ln3(2),[2 3])*prec)]); 
			op=addOLine(op,L);
	end
otherwise
error('not sure of which plane you want to plot in nodes2latex.m');
end
