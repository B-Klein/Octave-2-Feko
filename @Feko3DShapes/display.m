function display(s3d)

	n=length(s3d.fekoshapes)

	try, s3d.name;
		disp('name:')
		disp(s3d.name)
	catch, end 

	for n=1:length(s3d.fekoshapes)
		disp(['Feko object ' num2str(n) ':']);
		display(s3d.fekoshapes{n});
	end

	%
	% try, a.notes;
		% disp('notes:')
		% disp(a.notes)
	% catch, end %disp('no notes'); 
