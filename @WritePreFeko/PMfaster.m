function F = PMfaster(F,s,firstplate)

	if(firstplate),	
		try, ind = size(F.PM)(2)+1; catch, ind=1; end
	else
		ind = size(F.PM)(2)+1;
	end
	if ~isempty(get(s,'label')), F.PM{ind} = ['LA: ' get(s,'label')]; ind=ind+1; end % adds a label
	F.PM{ind} = ['PM: -1 : ' get(s,'shapename') ' : ' num2str(get(s,'Numedgepoints'))];
