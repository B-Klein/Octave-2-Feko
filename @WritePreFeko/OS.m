function [F ind] = OS(F, calculation, ind, varargin)



	%
	% The following paragraph is taken (and corresponding previous information) from :
	%
	% User’s Manual
	% Suite 6.1.1
	% December 2011
	% Copyright 1998 – 2011: EM Software & Systems-S.A. (Pty) Ltd
	% 32 Techno Avenue, Technopark, Stellenbosch, 7600, South Africa
	% Tel: +27-21-880-1880, Fax: +27-21-880-1936
	% E-Mail: OSko@emss.co.za
	% WWW: http://www.OSko.info
	% 

	switch calculation
		case{'none' 'n' 'N'}
			if isempty(ind), try, ind = size(F.OS)(2)+1; catch, ind=1; end, end
			F.OS{ind} = ['OS   0         1'];F.DA{ind}=[];

		case{'All' 'all' 'A' 'a'} %[F ind] = OS(F, 'a', [], no_average_corneroftriangle)
			noaverg = varargin{1};
			if noaverg>1, noaverg='1'; else noaverg='0'; end
			if isempty(ind), try, ind = size(F.OS)(2)+1; catch, ind=1; end, end
			F.OS{ind} = ['OS   1         ' noaverg];			F.DA{ind}=[];

		case{'OnlyTri' 'OT' 'ot'} %[F ind] = OS(F, 'ot', [], no_average_corneroftriangle)
			noaverg = varargin{1};
			if noaverg>1, noaverg='1'; else noaverg='0'; end
			if isempty(ind), try, ind = size(F.OS)(2)+1; catch, ind=1; end, end
			F.OS{ind} = ['OS   2         ' noaverg];			F.DA{ind}=[];

		case{'OnlySegments' 'OS' 'os'} %[F ind] = OS(F, 'os', [])
			if isempty(ind), try, ind = size(F.OS)(2)+1; catch, ind=1; end, end
			F.OS{ind} = ['OS   3'];	F.DA{ind}=[];


		otherwise
			error('incorrect calculation type, or not implemented type yet');
	end
			% CordSys = varargin{1};
			% ScattOnly = varargin{2};
			% %	if ~ischar(ScattOnly), ScattOnly = num2str(ScattOnly); end % Tag
			% if ScattOnly > 1, ScattOnly=-1; else, ScattOnly=1; end
% 
			% switch calculation
				% case{'Electric' 'electric' 'e' 'E'}
					% calcT = 1*ScattOnly; calcT = num2str(calcT);
				% case{'Magnetic' 'magnetic' 'm' 'M'}
					% calcT = 2*ScattOnly; calcT = num2str(calcT);
				% case{'BothEandH' 'bothEandH' 'both' 'b'}
					% calcT = 3*ScattOnly; calcT = num2str(calcT);
				% case{'MagneticVpotential' 'MVP' 'mVp''mvp'}
					% calcT = 10*ScattOnly; calcT = num2str(calcT);
				% case{'ElectricPgradient' 'EPG' 'ePg' 'epg'}
					% calcT = 11*ScattOnly; calcT = num2str(calcT);
				% case{'ElectricVpotential' 'EVP' 'eVp' 'evp'}
					% calcT = 12*ScattOnly; calcT = num2str(calcT);
				% case{'MagneticPgradient' 'MPG' 'mPg' 'mpg'}
					% calcT = 13*ScattOnly; calcT = num2str(calcT);
				% otherwise
					% error('unknown calculation type');
			% end
% 
			% switch CordSys
				% case{'Cartesian' 'cart'}
					% cordT = '0';
				% case{'Cylindircal' 'cylin'}
					% cordT = '1';
				% case{'Spherical' 'sphe'}
					% cordT = '2';
				% case{'Cylindrical xaxis' 'cylinx'}
					% cordT = '3';
				% case{'Cylindrical yaxis' 'cyliny'}
					% cordT = '4';
				% case{'Conical' 'cone'} % Npoints x must be 1
					% StartValues(2:3) = StartValues(1:2); StartValues(1) =1;
					% cordT = '5';
				% otherwise
					% error('unknown co-ordinate system type');
			% end
% 
			% StartValues = varargin{3};
			% Increment = varargin{4};
			% Nopoints = varargin{5};
			% if length(varargin)>5, 
				% oldformat=varargin{6};	
				% if oldformat>1, oldformat = ' :  : -1'; else oldformat = []; end
			% else
				% oldformat =[];
			% end
% 
			% if isempty(ind), try, ind = size(F.OS)(2)+1; catch, ind=1; end, end
			% F.OS{ind} = ['OS: ' calcT ' : ' num2str(Increment(1),writepr) ' : ' num2str(Increment(2),writepr) ' : ' num2str(Increment(3),writepr) ' : ' cordT ' : ' num2str(StartValues(1),writepr) ' : ' num2str(StartValues(2),writepr) ' : ' num2str(StartValues(3),writepr) ' : ' num2str(Increment(1),writepr) ' : ' num2str(Increment(2),writepr) ' : ' num2str(Increment(3),writepr) oldformat]; 
			% F.DA{ind}=[];
	% end
% 
	ind=ind+1;
