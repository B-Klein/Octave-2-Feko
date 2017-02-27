function [F ind] = FF(F, fieldpos, ind, varargin)
	
	% This card controls the calculation of the far fields in spherical coordinates.
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



	% if ~ischar(scale), scale = num2str(scale); else scale = ['#' scale]; end
	switch fieldpos
		case{'none'}
			if isempty(ind), try, ind = size(F.FF)(2)+1; catch, ind=1; end, end
			F.FF{ind} = ['FF   0'];F.DA{ind}=[];
		case{'stand'}
			% F = FF(F, fieldpos,scatonly,pattype, numtheta, numphi,theta0, phi0, itheta, iphi, maxn, N1, N2 )
			fp = 1;
			scatonly = varargin{1}; if(~isempty(scatonly) && abs(scatonly-1)<tol), fp=fp*-1; end 
			fp = num2str(fp);
			pattype =varargin{2}; switch pattype, case{'dir'}, pattype='0'; case{'gain'}, pattype='1'; otherwise('wrong pattern type'); end
			numtheta=varargin{3}; if ~ischar(numtheta), numtheta = num2str(numtheta); else numtheta = ['#' numtheta]; end
			numphi = varargin{4}; if ~ischar(numphi), numphi = num2str(numphi); else numphi = ['#' numphi]; end
			theta0 = varargin{5}; if ~ischar(theta0), theta0 = num2str(theta0); else theta0 = ['#' theta0]; end
			phi0 = varargin{6}; if ~ischar(phi0), phi0 = num2str(phi0); else phi0 = ['#' phi0]; end
			itheta = varargin{7}; if ~ischar(itheta), itheta = num2str(itheta); else itheta = ['#' itheta]; end
			iphi = varargin{8}; if ~ischar(iphi), iphi = num2str(iphi); else iphi = ['#' iphi]; end

			naragin = length(varargin);

			if(naragin>9)
				maxn = varargin{9}; if ~ischar(maxn), maxn = num2str(maxn); else maxn = ['#' maxn]; end
			else
				maxn = [];
			end
			if isempty(ind), try, ind = size(F.FF)(2)+1; catch, ind=1; end, end


			% Gets rid of implicit conversion warnings
			if isempty(fp), fp=''; end; if isempty(numtheta), numtheta=''; end; if isempty(numphi), numphi=''; end; if isempty(pattype), pattype=''; end; if isempty(maxn), maxn=''; end; if isempty(theta0), theta0=''; end; if isempty(phi0), phi0=''; end; if isempty(itheta), itheta=''; end; if isempty(iphi), iphi=''; end; 

			line1 =  ['FF: ' fp ' : ' numtheta ' : ' numphi ' : ' pattype ' : ' maxn ' : ' theta0 ' : ' phi0 ' : ' itheta ' : ' iphi ];

			if(naragin>10)
				N1 = varargin{10}; if ~ischar(N1), N1 = num2str(N1); else N1 = ['#' N1]; end
				N2 = varargin{11}; if ~ischar(N2), N2 = num2str(N2); else N2 = ['#' N2]; end
				F.FF{ind} =[line1 '	: ' N1 ' :  ' N2];F.DA{ind}=[];
			else
				F.FF{ind} =[line1];F.DA{ind}=[];
			end


			% 
			% 
			% 
			% switch pattype, case{'gain'}, pat=1; case{'direc'}, pat=0; end
			% 
			% if ~ischar(numtheta), numtheta = num2str(numtheta); else numtheta = ['#' numtheta]; end
			% if ~ischar(numphi), numphi = num2str(numphi); else numphi = ['#' numphi]; end
			% if ~ischar(theta0), theta0 = num2str(theta0); else theta0 = ['#' theta0]; end
			% if ~ischar(phi0), phi0 = num2str(phi0); else phi0 = ['#' phi0]; end
			% if ~ischar(itheta), itheta = num2str(itheta); else itheta = ['#' itheta]; end
			% if ~ischar(iphi), iphi = num2str(iphi); else iphi = ['#' iphi]; end
			% 
			% if ~ischar(maxn), maxn = num2str(maxn); else maxn = ['#' maxn]; end


			% F.FF{ind} = ['FF: ' 1 ' : ' numtheta ' : ' numphi ' : ' 0 : MAXN : INTTHETA : INTPHI : INCTHETA : INCPHI : NElu1 : NE2u1

			% FF: 1 : NUMPTHETAlonglong : NUMPPHIlonglong : 0 : MAXNlonglong : INTTHETAlonglong : INTPHIlonglong : INCTHETAlonglong : INCPHIlonglong : NElu1longlong : NE2u1longlong
			%
		otherwise
			error('unknown field pos')
	end
	ind=ind+1;
