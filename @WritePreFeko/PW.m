function F = PW(F, modes, varargin)

	% 	F = PW(F, 'noscaling', decouple);
	%		F = PW(F, 'TSPnointimp', decouple, sourcepower);
	%		F = PW(F, 'TSPintimp', decouple, sourcepower, Reimp, Imimp);
	%		F = PW(F, 'TSPtransmissionline', decouple, sourcepower, Rechimp, Imchimp);
	%
	% INPUT
	%
	% No scaling (use specified voltages): PW card is not activated, i.e. the specified value of the voltage
	% source is used.
	%		modes: 'noscaling' | 'ns'
	% 	F = PW(F, 'noscaling', decouple);
	%
	% Total source power (no internal impedance): PW card is activated and all the currents are multiplied by
	% a scaling factor so that the total source power (the sum of the power delivered
	% by all the individual sources) is P0 — the value specified in the Source power
	% field. Mismatch is not considered.
	%		modes: 'TSPnointimp'|'noint'
	%		F = PW(F, 'TSPnointimp', decouple, sourcepower);
	%
	% Total source power (internal impedance): All voltage sources are assumed to have an input impedance
	% Zi as specified by the parameters Source impedance, real part and Source
	% impedance, imag part. The currents are scaled such that the total power sup-
	% plied by the voltage sources equals P0 as discussed below. The mismatch losses
	% in the source impedance reduce the antenna gain.
	%		modes: 'TSPintimp'|'int'
	%		F = PW(F, 'TSPintimp', decouple, sourcepower, Reimp, Imimp);
	%
	% Total source power (transmission line feed): All the antennas are assumed to be fed by transmission
	% lines with a complex characteristic impedance Z L as specified by the parame-
	% ters Charact. impedance, real part and Charact. impedance, imag part. If there
	% is a mismatch between Z L and the antenna input impedance Za , some of the
	% incident power will be reflected back to the source.
	%			modes: 'TSPtransmissionline'| 'tl'
	%			F = PW(F, 'TSPtransmissionline', decouple, sourcepower, Rechimp, Imchimp);
	%
	% decouple (Decouple all sources when calculating power): When this item is not checked and multiple
	% impressed sources (i.e. elementary dipoles A5/A6, impressed current elements AI/AV, etc.) are
	% present, the mutual coupling of all these sources, as well as the coupling of the sources with
	% other structures such as ground (BO card), UTD surfaces, or MoM elements are taken into account
	% when determining the source power. This is also the default if the PW card is not present. When
	% this item is checked, however, this mutual coupling is not considered. This is acceptable for
	% sources which are relatively far away or when no accurate power values are required. (Since
	% gain/directivity are based on power, they are then also possibly not very accurate.)
	%
	% December 2011
	% FEKO User’s Manual
	% CONTROL CARDS
	% Source power:
	% 12-148
	% The total power P0 in Watt, i.e. the total power supplied by all the voltage
	% sources, or in the case of transmission lines, the total power of all forward
	% travelling waves.
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
	% When defining the excitation of an antenna, the source is normally specified as a complex volt-
	% age. The PW card allows the user to specify the radiated power or the source power instead
	% (FEKO then just internally scales the whole solution to arrive at this desired power). In addi-
	% tion, it is possible to consider a mismatch between the antenna input impedance and the internal
	% impedance of a voltage source or the characteristic impedance of a transmission line feed.
	%
	% (see 12-148 for more details)


	% if ~ischar(ang), ang = num2str(ang); else ang = ['#' ang]; end
	try, ind = size(F.PW)(2)+1; catch, ind=1; end

	switch modes 
		case{'noscaling', 'ns'}
			decouple = varargin{1};
			if abs(decouple)<tol, F.PW{ind} = ['PW   0    0'];	else, F.PW{ind} = ['PW   0    1']; end
		case{'TSPnointimp', 'noint'}
			decouple = varargin{1}; decouple = num2str(decouple);
			sourcepower = varargin{2}; if ~ischar(sourcepower), sourcepower = num2str(sourcepower); else sourcepower = ['#' sourcepower]; end
			F.PW{ind} = ['PW: 1 : ' decouple ' :  :  :  : ' sourcepower];
		case{'TSPintimp', 'int'}
			decouple = varargin{1}; decouple = num2str(decouple);
			sourcepower = varagin{2}; if ~ischar(sourcepower), sourcepower = num2str(sourcepower); else sourcepower = ['#' sourcepower]; end
			ReI = varagin{3}; if ~ischar(ReI), ReI = num2str(ReI); else ReI = ['#' ReI]; end
			ImI = varagin{4}; if ~ischar(ImI), ImI = num2str(ImI); else ImI = ['#' ImI]; end
			F.PW{ind} = ['PW: 2 : ' decouple ' :  :  :  : ' sourcepower ' : ' ReI ' : ' ImI];
		case{'TSPtransmissionline', 'tl'}
			decouple = varargin{1}; decouple = num2str(decouple);
			sourcepower = varagin{2}; if ~ischar(sourcepower), sourcepower = num2str(sourcepower); else sourcepower = ['#' sourcepower]; end
			Rechimp = varagin{3}; if ~ischar(Rechimp), Rechimp = num2str(Rechimp); else Rechimp = ['#' Rechimp]; end
			Imchimp = varagin{4}; if ~ischar(Imchimp), Imchimp = num2str(Imchimp); else Imchimp = ['#' Imchimp]; end
			F.PW{ind} = ['PW: 3 : ' decouple ' :  :  :  : ' sourcepower ' : ' Rechimp ' : ' Imchimp];
		otherwise
			error('unknown input to PW card');
	end
