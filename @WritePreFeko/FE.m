function [F ind] = FE(F, calculation, ind, varargin)

	% This card controls the calculation of the near fields in spherical coordinates.
	%
	% Typical use:
	% [F ind] = FE(F, calculation, ind, CordSys, ScattOnly, StartValues, Increment,	Npointsm oldformat)
	%
	% Parameters:
	% Select what to calculate:
	% caculation 
	% 'none', 'n', 'N' - No field calculation: Field is not calculated.
	% 
	% 'e' - Electric field values: Calculate the electric field, E.
	% 'm' - Magnetic field values: Calculate the magnetic field, H.
	% 'b' - Both electric field and magnetic field values: Calculate both electric and
	% magnetic fields.
	% • Electric field and SAR values in cuboids: The electric field and SAR values
	% in the dielectric volume elements. For this option, no other parameters
	% are required.
	% • Magnetic vector potential: Calculate the magnetic vector potential, A.
	% • Gradient of the scalar electric potential: Calculate the gradient of the
	% scalar electric potential, ∇ φ.
	% • Electric vector potential: Calculate the electric vector potential, F .
	% • Gradient of the scalar magnetic potential: Calculate the gradient of the
	% scalar magnetic potential, ∇ ψ.
	%
	%
	% The following paragraph is taken (and corresponding previous information) from :
	%
	% User’s Manual
	% Suite 6.1.1
	% December 2011
	% Copyright 1998 – 2011: EM Software & Systems-S.A. (Pty) Ltd
	% 32 Techno Avenue, Technopark, Stellenbosch, 7600, South Africa
	% Tel: +27-21-880-1880, Fax: +27-21-880-1936
	% E-Mail: feko@emss.co.za
	% WWW: http://www.feko.info
	% 

	switch calculation
		case{'none' 'n' 'N'}
			if isempty(ind), try, ind = size(F.FE)(2)+1; catch, ind=1; end, end
			calcT = '0';
			F.FE{ind} = ['FE   ' calcT '                   0'];F.DA{ind}=[];
		case{'ElectricandSars' 'es' 'ES'}
			calcT = '7';
			F.FE{ind} = ['FE   ' calcT '                   5'];F.DA{ind}=[];
		otherwise

			CordSys = varargin{1};
			ScattOnly = varargin{2};
			%	if ~ischar(ScattOnly), ScattOnly = num2str(ScattOnly); end % Tag
			if ScattOnly > 1, ScattOnly=-1; else, ScattOnly=1; end

			switch calculation
				case{'Electric' 'electric' 'e' 'E'}
					calcT = 1*ScattOnly; calcT = num2str(calcT);
				case{'Magnetic' 'magnetic' 'm' 'M'}
					calcT = 2*ScattOnly; calcT = num2str(calcT);
				case{'BothEandH' 'bothEandH' 'both' 'b' 'Both'}
					calcT = 3*ScattOnly; calcT = num2str(calcT);
				case{'MagneticVpotential' 'MVP' 'mVp''mvp'}
					calcT = 10*ScattOnly; calcT = num2str(calcT);
				case{'ElectricPgradient' 'EPG' 'ePg' 'epg'}
					calcT = 11*ScattOnly; calcT = num2str(calcT);
				case{'ElectricVpotential' 'EVP' 'eVp' 'evp'}
					calcT = 12*ScattOnly; calcT = num2str(calcT);
				case{'MagneticPgradient' 'MPG' 'mPg' 'mpg'}
					calcT = 13*ScattOnly; calcT = num2str(calcT);
				otherwise
					error('unknown calculation type');
			end

			switch CordSys
				case{'Cartesian' 'cart'}
					cordT = '0';
				case{'Cylindircal' 'cylin'}
					cordT = '1';
				case{'Spherical' 'sphe'}
					cordT = '2';
				case{'Cylindrical xaxis' 'cylinx'}
					cordT = '3';
				case{'Cylindrical yaxis' 'cyliny'}
					cordT = '4';
				case{'Conical' 'cone'} % Npoints x must be 1
					StartValues(2:3) = StartValues(1:2); StartValues(1) =1;
					cordT = '5';
				otherwise
					error('unknown co-ordinate system type');
			end

			StartValues = varargin{3};
			Increment = varargin{4};
			Nopoints = varargin{5};
			if length(varargin)>5, 
				oldformat=varargin{6};	
				if oldformat>1, oldformat = ' :  : -1'; else oldformat = []; end
			else
				oldformat =[];
			end

			if isempty(ind), try, ind = size(F.FE)(2)+1; catch, ind=1; end, end
			F.FE{ind} = ['FE: ' calcT ' : ' num2str(Nopoints(1),writepr) ' : ' num2str(Nopoints(2),writepr) ' : ' num2str(Nopoints(3),writepr) ' : ' cordT ' : ' num2str(StartValues(1),writepr) ' : ' num2str(StartValues(2),writepr) ' : ' num2str(StartValues(3),writepr) ' : ' num2str(Increment(1),writepr) ' : ' num2str(Increment(2),writepr) ' : ' num2str(Increment(3),writepr) oldformat]; 
			F.DA{ind}=[];

			% F.FE{ind} = ['FE: ' calcT ' : ' num2str(Increment(1),writepr) ' : ' num2str(Increment(2),writepr) ' : ' num2str(Increment(3),writepr) ' : ' cordT ' : ' num2str(StartValues(1),writepr) ' : ' num2str(StartValues(2),writepr) ' : ' num2str(StartValues(3),writepr) ' : ' num2str(Increment(1),writepr) ' : ' num2str(Increment(2),writepr) ' : ' num2str(Increment(3),writepr) oldformat]; 

	end



	ind=ind+1;
