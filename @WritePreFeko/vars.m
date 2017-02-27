function F = vars(F, varName, varValue)
	
	% function F = variables(F, vr)
	%

	if length(F.vars), ind = size(F.vars)(1)+1; else ind =1; end

	% F.vars{ind}= ['#' varName '=' num2str(varValue)];
	F.vars{ind,1}= ['#' varName];
	if ~ischar(varValue), varValue = num2str(varValue); else varValue = ['#' varValue]; end
	F.vars(ind,2)= varValue;
	
