function F = PHsq(F, cornp, rad, pname, maxedge, LA)

% Produces a square plate and 
%
% cornp1 ----- cornp2
%   | 						|
%   |	  	x->rad|	|
%   |		  				|
% cornp3 ----- cornp4
%
%
% plxyz =[...
	% 1 2 0;
	% 1 0 0;
	% 1 2 3;
	% 1 0 3];
	% rad = 0.5;

% x a
% x x

org = cornp(3,:) + 0.5*(cornp(2,:) - cornp(3, :));
s2 = cornp(3,:) + 0.5*(cornp(4,:) - cornp(3, :));
s3 = cornp(3,:);
s4 = cornp(3,:) + 0.5*(cornp(1,:) - cornp(3, :));
n = s2-org; 
s5 = org + rad*n/norm(n);

F = DP(F, [pname 'as1'], org(1), org(2), org(3));
F = DP(F, [pname 'as2'], s2(1), s2(2), s2(3));
F = DP(F, [pname 'as3'], s3(1), s3(2), s3(3));
F = DP(F, [pname 'as4'], s4(1), s4(2), s4(3));
F = DP(F, [pname 'as5'], s5(1), s5(2), s5(3));

if exist('LA'), 
	F = PH(F, [pname 'as1'],[pname 'as2'],[pname 'as3'],[pname 'as4'],[pname 'as5'], maxedge, [], LA);
else
	F = PH(F, [pname 'as1'],[pname 'as2'],[pname 'as3'],[pname 'as4'],[pname 'as5'], maxedge);
end

% b x
% x x

s2 = cornp(1,:) + 0.5*(cornp(3,:) - cornp(1, :));
s3 = cornp(1,:);
s4 = cornp(1,:) + 0.5*(cornp(2,:) - cornp(1, :));
n = s2 -org;
s5 = org + rad*n/norm(n); %(s2 - org);

F = DP(F, [pname 'bs1'], org(1), org(2), org(3));
F = DP(F, [pname 'bs2'], s2(1), s2(2), s2(3));
F = DP(F, [pname 'bs3'], s3(1), s3(2), s3(3));
F = DP(F, [pname 'bs4'], s4(1), s4(2), s4(3));
F = DP(F, [pname 'bs5'], s5(1), s5(2), s5(3));

F = PH(F, [pname 'bs1'],[pname 'bs2'],[pname 'bs3'],[pname 'bs4'],[pname 'bs5'], maxedge);

% x x
% c x

s2 = cornp(1,:) + 0.5*(cornp(2,:) - cornp(1, :));
s3 = cornp(2,:);
s4 = cornp(2,:) + 0.5*(cornp(4,:) - cornp(2, :));
n = s2 -org;
s5 = org + rad*n/norm(n);
%(s2 - org);

F = DP(F, [pname 'cs1'], org(1), org(2), org(3));
F = DP(F, [pname 'cs2'], s2(1), s2(2), s2(3));
F = DP(F, [pname 'cs3'], s3(1), s3(2), s3(3));
F = DP(F, [pname 'cs4'], s4(1), s4(2), s4(3));
F = DP(F, [pname 'cs5'], s5(1), s5(2), s5(3));

F = PH(F, [pname 'cs1'],[pname 'cs2'],[pname 'cs3'],[pname 'cs4'],[pname 'cs5'], maxedge);

% x x
% x d

s3 = cornp(4,:);
n = s4-org;
s5 = org + rad*n/norm(n);

F = DP(F, [pname 'ds3'], s3(1), s3(2), s3(3));
F = DP(F, [pname 'ds5'], s5(1), s5(2), s5(3));

F = PH(F, [pname 'as1'],[pname 'cs4'],[pname 'ds3'],[pname 'as2'],[pname 'ds5'], maxedge);



% generate first plate





