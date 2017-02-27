function F = DPAxyzfaster(F, name, xyz, firstplate)

	if(firstplate),	
		try, ind = size(F.DP)(2)+1; catch, ind=1; end
	else
		ind = size(F.DP)(2)+1;
	end

	for n=1:size(xyz)(1)
		F.DP{ind} = ['DP: ' [name '[' num2str(n,writepr()) ']']...
			' :  :  :  :  : ' num2str(xyz(n,1),writepr())...
			' : ' num2str(xyz(n,2),writepr()) ' : ' num2str(xyz(n,3),writepr()) ' : ' []]; 
		ind = ind+1;
	end
