function F = FM(F, varargin)

	% function F = FM(F,adaptive, nearfield,farfield,boxsize); 
	%
	% Fast methods settings
	%
	% All these are optional INPUTS and if they are not empty will be set. So F=FM(F) is default
	% 	adaptive run adaptive settings
	% 	nearfield run nearfied on traditional settings
	% 	farfield run farfield on tradional settings
	% 	boxsize : set box size at finest level manually
	%
	% Do not set extra variables if you are not using them so (F,[],'n',[]) will result in an error use (F,[],'n') instead!
	%
	% The following paragraph is taken (and corresponding previous information) from :
	% User’s Manual
	% Suite 6.1.1
	% December 2011
	% Copyright 1998 – 2011: EM Software & Systems-S.A. (Pty) Ltd
	% 32 Techno Avenue, Technopark, Stellenbosch, 7600, South Africa
	% Tel: +27-21-880-1880, Fax: +27-21-880-1936
	% E-Mail: feko@emss.co.za
	% WWW: http://www.feko.info
	%
	% Parameters:
	% Use MLFMM:
	% The Multilevel Fast Multipole Method method is used to calculate the solution.
	% Use adaptive cross-approximation (ACA): The ACA method is used to calculate the solution. This
	% method approximates the impedance matrix by constructing a sparse H-matrix
	% (only a few selected elements are computed).
	% Box size at fines level: The MLFMM is based on a hierarchical tree-based grouping algorithm, and
	% depending on the frequency and the model dimensions FEKO automatically
	% determines the number of levels in this tree and the size of the boxes at the
	% finest level. It is also recommended that this default box size of 0.23λ is kept.
	% When there is no convergence in the MLFMM, then advanced users might try
	% to slightly increase or decrease this box size by setting it manually (the input
	% is in terms of the wavelength).
	% Near field calculation method: The MLFMM method can use a fast near field calculation method (this
	% is the default), but under certain circumstances it is preferred to use the tradi-
	% tional integration method. The method to use can be selected here.
	% Far field calculation method: The MLFMM method can use a fast far field calculation method (this is
	% the default), but under certain circumstances it is preferred to use the tradi-
	% tional integration method. The method to use can be selected here.
	% Multilevel Fast Multipole Method (MLFMM)
	% Currently, the MLFMM may not be used in conjunction with the multilayer Greens function.
	% 
	% Advantages of Adaptive Cross Approximation (ACA)
	% • ACA is done on the matrix level.
	% • No frequency breakdown like MLFMM.
	% • Not restricted to free space Green’s function like MLFMM.
	% • Iterative solution, each matrix-vector multiplication is very fast.
	% Note that the ACA can currently only be used sequentially.


	% if ~ischar(Wr), Wr = num2str(Wr); else Wr = ['#' Wr]; end

	if length(varargin)<tol		% Setting everything to default
		F.FM = ['FM   0'];		return
	end

	if ~isempty(varargin{1})
		F.FM = ['FM   4']; return 
	end

	if abs(length(varargin)-2)<tol % only set nearfield 
		F.FM = ['FM   1']; return 
	end

	if abs(length(varargin)-3)<tol % only set nearfield and farfield
		if ~isempty(varargin{2}) % both are set so 
			F.FM = ['FM   3']; return 
		else % Assumes the user is smart enough not to set (F,[],'n',[])
			F.FM = ['FM   2']; return 
		end
	end

	if isempty(varargin{2}) && isempty(varargin{3}), v='0';
	elseif ~isempty(varargin{2}) && isempty(varargin{3}), v='1';
	elseif isempty(varargin{2}) && ~isempty(varargin{3}), v='2';
	elseif ~isempty(varargin{2}) && ~isempty(varargin{3}), v='3';
	else, warning('FM function is very confused so it is doing nothing!');
	end

	if ~ischar(varargin{4}), box = num2str(varargin{4}); else box = ['#' varargin{4}]; end

	F.FM = ['FM: ' v ' :  :  :  :  : ' box];
