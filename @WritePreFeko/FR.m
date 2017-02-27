function F = FR(F, modes ,varargin)

	% modes 'single' | 'discrete' | 'continuous'
	% 
	% 'single'
	% 	F = FR(F, 's' ,f)
	% 		f : frequency in Hz
	% 'discrete'
	% 	F = FR(F, 'd' ,Nf, multi, Fstart, Finc, Fend)
	% 		Nf : Number of frequency points: For a discrete frequency sweep, the number
	%				of frequency samples must be larger than 1.
	%			multi : Frequency scale: In this group either Linear (0 []) or Multiplicative (1)scaling is
	%				selected. If Linear is selected, then consecutive frequencies differ with
	% 			a fixed value, i.e. the new frequency is the previous value plus the fre- quency increment.
	% 			If Multiplicative is selected, then consecutive frequen- cies differ by a constant factor,
	% 			i.e. the new frequency is the previous value multiplied by the frequency factor.
	% 		Fstart: Start frequency [Hz]
	% 		Finc : Specify by: If Frequency increment / factor is selected, the user speci- fies the
	% 			increment or factor mentioned in the previous item. This, the number of frequencies and the
	% 			start frequency then determine the ending frequency. 
	% 		Fend : If Ending frequency is selected, the user specifies this and the increment / factor is
	%		 		calculated. Set Finc = [] for this case
	%
	% 'continous'
	% 	F = FR(F, 'c'...
	% 	NOT IMPLEMENTED YET

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

	try, ind = size(F.FR)(2)+1; catch, ind=1; end
	switch modes
		case{'single', 's'}
			% F = FR(F, modes ,freq [Hz])
			freq = varargin{1}; if ~ischar(freq), freq = num2str(freq); else freq = ['#' freq]; end
			F.FR{ind} = ['FR:  :  :  :  :  : ' freq];
		case{'discrete', 'd'}
			% F = FR(F, modes ,Nf, multi, Fstart, Finc, Fend)
			Nf = varargin{1}; if ~ischar(Nf), Nf = num2str(Nf); else Nf = ['#' Nf]; end
			multi = varargin{2}; if isempty(multi), multi='0'; else multi = num2str(multi); end
			Fstart = varargin{3}; if ~ischar(Fstart), Fstart = num2str(Fstart); else Fstart = ['#' Fstart]; end
			Finc = varargin{4}; 
			if(~isempty(Finc))
				if ~ischar(Finc), Finc = num2str(Finc); else Finc = ['#' Finc]; end, Fend=[];
			else
				Fend = varargin{5}; if ~ischar(Fend), Fend = num2str(Fend); else Fend = ['#' Fend]; end
			end
			F.FR{ind} = ['FR: ' Nf ' : ' multi ' :  :  :  : ' Fstart ' : ' Finc ' : ' Fend];
		case{'c', 'continous'}
			error('not yet implemented in FR card');
		otherwise
			error('unknown option called from FR card')
	end
