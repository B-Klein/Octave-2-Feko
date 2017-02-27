function F = varsA(F, varName, varValues)
	
	% function F = variables(F, vr)
	%

	if length(F.varsA), ind = size(F.varsA)(1)+1; else ind =1; end

	% F.varsA{ind}= ['#' varName '=' num2str(varValue)];
	F.varsA{ind,1}= ['#' varName];
	F.varsA(ind,2)= varValues;

