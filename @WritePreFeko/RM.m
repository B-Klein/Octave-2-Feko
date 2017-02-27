function F = RM(F, RMmode, mshsize, varargin)

	% function F = RM(F, RMmode, mshsize)
	% INPUT
	% 	RMmode	: 'global'
	%		mshsize	: minimium msh size 
	%
	%	function F = RM(F, RMmode, mshsize, point,DistanceD1,addnew)
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

	if ~ischar(mshsize), mshsize = num2str(mshsize,writepr()); else mshsize = ['#' mshsize]; end

	try, ind = size(F.RM)(2)+1; catch, ind=1; end

	switch RMmode
		case{'global', 'GLOBAL'}
			F.RM{ind} = ['RM: 0 : 1 : 0 :  :  : ' mshsize];
		case{'localpoint', 'LOCALPOINT'}
			point=varargin{1};
			DistanceD1=varargin{2};
			addnew=varargin{3};
			if ~ischar(DistanceD1), DistanceD1 = num2str(DistanceD1,writepr()); else DistanceD1 = ['#' DistanceD1]; end
			if ~ischar(addnew), addnew = num2str(addnew,writepr()); else addnew = ['#' addnew]; end
			F.RM{ind} = ['RM: ' addnew ' : 2 : 0 : ' point ' :  : ' mshsize ' :  : ' DistanceD1];
		otherwise
			error('unrecognised mode in RM card');
	end
