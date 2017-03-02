function display(Gms)

	n=length(Gms.gmsurfs)

	try, Gms.name;
		disp('name:')
		disp(Gms.name)
	catch, end 

	try, Gms.duplicatelines;
		disp('duplicatelines:')
		disp(Gms.duplicatelines)
	catch, end 
	
	for n=1:length(Gms.gmsurfs)
		disp(['gmshSurf object ' num2str(n) ':']);
		display(Gms.gmsurfs{n});
	end

	%
	% try, a.notes;
		% disp('notes:')
		% disp(a.notes)
	% catch, end %disp('no notes'); 
