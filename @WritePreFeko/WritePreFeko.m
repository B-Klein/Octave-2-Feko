## -*- texinfo -*-
## @deftypefn  {Function File} {} WritePreFeko ()
## @deftypefnx {Function File} {} WritePreFeko (@var{filename})
## @deftypefnx {Function File} {} WritePreFeko (@var{filename}, @var{directory})
## Create a WritePreFeko object to write out prefeko file similar to editfeko file
##
## @example
## WritePreFeko (filename, directory)
## @end example
##
## @noindent
## 
## @end deftypefn
function F = WritePreFeko(filename, directory)

	switch nargin
		case{0}
			F.filename = getfilename('Oct2Feko', '.pre'); 
			F.directory = pwd;
		case{1}
			F.filename = filename;
			F.directory = pwd;
		case{2}
			if(isempty(filename))
			F.filename = getfilename('Oct2Feko', '.pre'); 
			F.directory = pwd;
			else
				F.filename = filename;
			end
			F.directory = directory;
		otherwise
			print_usage ();
	end
	% Set default fields
	F.header = [];
	F.IP = [];
	F.FM= [];
	F.vars=[];
	F.varsA=[];
	F.DP=[];
	F.ZY=[];
	F.KR=[];
	F.KK=[];
	F.AW=[];
	F.FF=[];
	F.FE=[];
	F.OS=[];
	F.SP=[];
	F.FR=[];
	F.PW=[];
	F.DA=[];
	F.SY=[];
	F.BQ=[];
	F.BP=[];
	F.PM=[];
	F.DZ=[];
	F.PH=[];
	F.TG=[];
	F.BT=[];
	F.RM=[];
	F.DI=[];
	F.SF=[];
	F.LE=[];
	F.MB=[];
	F.PB=[];

	F = class (F, "WritePreFeko");
end

	
