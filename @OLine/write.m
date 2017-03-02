function write(L, fid)

	linetype = ' -- '; % only supports this for now
%   writepr=5;

	if ~isempty(L.options), L.options=['[' L.options ']']; end
% 	L.options

	switch L.typ 
		case 'straight'
		  lstrA = ['\draw' L.options ' (' num2str(L.cords(1,1), writepr) ',' num2str(L.cords(1,2),writepr)...
				') '];
			lstrB = [' (' num2str(L.cords(2,1), writepr) ',' num2str(L.cords(2,2), writepr)...
				')'];
			if ~isempty(L.label)
				if ~isempty(L.label{1}),	ndstrA = ['node[' L.label{1} ']' ' {' L.label{2} '}'];	else ndstrA=[]; end
				if length(L.label)>2 && ~isempty(L.label{3}),	ndstrB = ['node[' L.label{3} ']' ' {' L.label{4} '}'];	else ndstrB=[]; end
				if length(L.label)>4 && ~isempty(L.label{5}),	ndstrC = ['node[' L.label{5} ']' ' {' L.label{6} '}'];	else ndstrC=[]; end
			else
				ndstrA =[]; ndstrB =[]; ndstrC =[];
			end
			fputs (fid, [lstrA ndstrA linetype ndstrB lstrB ndstrC ';' "\n"]);
		case 'circle'
			linetype = ' circle '; % only supports this for now
		  lstrA = ['\draw' L.options ' (' num2str(L.cords(1,1), writepr) ',' num2str(L.cords(1,2),writepr)...
				') '];
			lstrB = [' (' num2str(L.cords(2,1), writepr) ')'];
			if ~isempty(L.label)
				if ~isempty(L.label{1}),	ndstrA = ['node[' L.label{1} ']' ' {' L.label{2} '}'];	else ndstrA=[]; end
				if length(L.label)>2 && ~isempty(L.label{3}),	ndstrB = ['node[' L.label{3} ']' ' {' L.label{4} '}'];	else ndstrB=[]; end
				if length(L.label)>4 && ~isempty(L.label{5}),	ndstrC = [' node[' L.label{5} ']' ' {' L.label{6} '}'];	else ndstrC=[]; end
			else
				ndstrA =[]; ndstrB =[]; ndstrC =[];
			end
			fputs (fid, [lstrA ndstrA linetype ndstrB lstrB ndstrC ';' "\n"]);
		case 'circlefill'
			linetype = ' circle '; % only supports this for now
		  lstrA = ['\fill' L.options ' (' num2str(L.cords(1,1), writepr) ',' num2str(L.cords(1,2),writepr)...
				') '];
			lstrB = [' (' num2str(L.cords(2,1), writepr) ')'];
			if ~isempty(L.label)
				if ~isempty(L.label{1}),	ndstrA = ['node[' L.label{1} ']' ' {' L.label{2} '}'];	else ndstrA=[]; end
				if length(L.label)>2 && ~isempty(L.label{3}),	ndstrB = ['node[' L.label{3} ']' ' {' L.label{4} '}'];	else ndstrB=[]; end
				if length(L.label)>4 && ~isempty(L.label{5}),	ndstrC = [' node[' L.label{5} ']' ' {' L.label{6} '}'];	else ndstrC=[]; end
			else
				ndstrA =[]; ndstrB =[]; ndstrC =[];
			end
			fputs (fid, [lstrA ndstrA linetype ndstrB lstrB ndstrC ' -- cycle;' "\n"]);
		case 'curved'
			linetype = ' curved '; % only supports this for now
			lengL=length(L.cords(:,1));
			if abs(lengL-3)<tol,
 		  strA = ['\draw' L.options ' (' num2str(L.cords(1,1), writepr) ',' num2str(L.cords(1,2),writepr)...
				') .. controls' ' (' num2str(L.cords(3,1), writepr) ',' num2str(L.cords(3,2),writepr)...
				') ..'  ' (' num2str(L.cords(2,1), writepr) ',' num2str(L.cords(2,2),writepr)...
				')'];
% 			if ~isempty(L.label)
% 				if ~isempty(L.label{1}),	ndstrA = ['node[' L.label{1} ']' ' {' L.label{2} '}'];	else ndstrA=[]; end
% 				if length(L.label)>2 && ~isempty(L.label{3}),	ndstrB = ['node[' L.label{3} ']' ' {' L.label{4} '}'];	else ndstrB=[]; end
% 				if length(L.label)>4 && ~isempty(L.label{5}),	ndstrC = ['node[' L.label{5} ']' ' {' L.label{6} '}'];	else ndstrC=[]; end
% 			else
% 				ndstrA =[]; ndstrB =[]; ndstrC =[];
% 			end
% 			fputs (fid, [lstrA ndstrA linetype ndstrB lstrB ndstrC ';' "\n"]);
 			fputs (fid, [strA ';' "\n"]);
	end
		otherwise
			warning('contains unknown line types');
	end
