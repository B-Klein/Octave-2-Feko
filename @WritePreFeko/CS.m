function F = CS(F, s1,s2,s3,s4,angBotStrt,angBotEnd,angTopStrt,angTopEnd,edgelenBot,edgelenTop,	inflag, scale, LA)

	% INPUT
	%
	% This card is used to define a path along which the cable runs thus also providing the centre/ref-
	% erence location to which a cable cross section definition is applied.
	% A path my be specified using data points in the *.pre file or loading a cable path from a NAS-
	% TRAN file.
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

	if ~ischar(s1), s1 = num2str(s1); end
	if ~ischar(s2), s2 = num2str(s2); end
	if ~ischar(s3), s3 = num2str(s3); end
	if ~ischar(s4), s4 = num2str(s4); end
	if ~ischar(angBotStrt), angBotStrt = num2str(angBotStrt); else angBotStrt = ['#' angBotStrt]; end
	if ~ischar(angBotEnd), angBotEnd = num2str(angBotEnd); else angBotEnd = ['#' angBotEnd]; end
	if ~ischar(angTopStrt), angTopStrt = num2str(angTopStrt); else angTopStrt = ['#' angTopStrt]; end
	if ~ischar(angTopEnd), angTopEnd = num2str(angTopEnd); else angTopEnd = ['#' angTopEnd]; end
	if ~ischar(edgelenBot), edgelenBot = num2str(edgelenBot); else edgelenBot = ['#' edgelenBot]; end
	if ~ischar(edgelenTop), edgelenTop = num2str(edgelenTop); else edgelenTop = ['#' edgelenTop]; end
	if ~ischar(inflag), inflag = num2str(inflag); else inflag = ['#' inflag]; end
	if ~ischar(scale), scale = num2str(scale); else scale = ['#' scale]; end

	try, ind = size(F.CS)(2)+1; catch, ind=1; end

	if exist('LA'), F.CS{ind} = ['LA: ' LA]; ind=ind+1; end % adds a label
	F.CS{ind} = ['CS: ' s1 ' : ' s2 ' : ' s3 ' : ' s4 ' : ' inflag ' : ' angBotEnd ' : ' edgelenTop...
		' : ' edgelenBot ' :  : ' scale ' : ' angTopEnd ' : ' angBotStrt ' : ' angTopStrt];

