function displayWritePreFeko(a)

	vrb = 0; 

	disp('filename:')
	disp(a.filename)
	disp('directory:')
	disp(a.directory)

	try, a.notes;
		disp('notes:')
		disp(a.notes)
	catch, if(vrb),if(vrb),disp('no notes');end,end, end
	try, a.header;
		disp('header:')
		disp(a.header)
	catch, if(vrb),disp('no header');end, end
	try, a.IP;
		disp('IP:')
		disp(a.IP)
	catch, if(vrb),disp('no IP');end, end
	try, a.FM;
		disp('FM:')
		disp(a.FM)
	catch, if(vrb),disp('no FM');end, end
	try, a.vars;
		disp('vars:')
		disp(a.vars)
	catch, if(vrb),disp('no vars');end, end
	try, a.varsA;
		disp('varsA:')
		disp(a.varsA)
	catch, if(vrb),disp('no varsA');end, end
	try, a.DP;
		disp('DP:')
		disp(a.DP)
	catch, if(vrb),disp('no DP');end, end
	try, a.ZY;
		disp('ZY:')
		disp(a.ZY)
	catch, if(vrb),disp('no ZY');end, end
	try, a.KR;
		disp('KR:')
		disp(a.KR)
	catch, if(vrb),disp('no KR');end, end
	try, a.KK;
		disp('KK:')
		disp(a.KK)
	catch, if(vrb),disp('no KK');end, end
	try, a.PB;
		disp('PB:')
		disp(a.PB)
	catch, if(vrb),disp('no PB');end, end
	try, a.AW;
		disp('AW:')
		disp(a.AW)
	catch, if(vrb),disp('no AW');end, end
	try, a.FF;
		disp('FF:')
		disp(a.FF)
	catch, if(vrb),disp('no FF');end, end
	try, a.FE;
		disp('FE:')
		disp(a.FE)
	catch, if(vrb),disp('no FE');end, end
	try, a.OS;
		disp('OS:')
		disp(a.OS)
	catch, if(vrb),disp('no OS');end, end
	try, a.SP;
		disp('SP:')
		disp(a.SP)
	catch, if(vrb),disp('no SP');end, end
	try, a.FR;
		disp('FR:')
		disp(a.FR)
	catch, if(vrb),disp('no FR');end, end
	try, a.PW;
		disp('PW:')
		disp(a.PW)
	catch, if(vrb),disp('no PW');end, end
	try, a.DA;
		disp('DA:')
		disp(a.DA)
	catch, if(vrb),disp('no DA');end, end
	try, a.SY;
		disp('SY:')
		disp(a.SY)
	catch, if(vrb),disp('no SY');end, end
	try, a.BQ;
		disp('BQ:')
		disp(a.BQ)
	catch, if(vrb),disp('no BQ');end, end
	try, a.PM;
		disp('PM:')
		disp(a.PM)
	catch, if(vrb),disp('no PM');end, end
	try, a.DZ;
		disp('DZ:')
		disp(a.DZ)
	catch, if(vrb),disp('no DZ');end, end
	try, a.PH;
		disp('PH:')
		disp(a.PH)
	catch, if(vrb),disp('no PH');end, end
	try, a.TG;
		disp('TG:')
		disp(a.TG)
	catch, if(vrb),disp('no TG');end, end
	try, a.BT;
		disp('BT:')
		disp(a.BT)
	catch, if(vrb),disp('no BT');end, end
	try, a.RM;
		disp('RM:')
		disp(a.RM)
	catch, if(vrb),disp('no RM');end, end
	try, a.DI;
		disp('DI:')
		disp(a.DI)
	catch, if(vrb),disp('no DI');end, end
	try, a.SF;
		disp('SF:')
		disp(a.SF)
	catch, if(vrb),disp('no SF');end, end
	try, a.LE;
		disp('LE:')
		disp(a.LE)
	catch, if(vrb),disp('no LE');end, end
	try, a.MB;
		disp('MB:')
		disp(a.MB)
	catch, if(vrb),disp('no MB');end, end


	
	
	
	
	
	
	
	
	
	% 
	% 
	% disp('header:')
	% disp(a.header)
	% try, a.notes;
		% disp('notes:')
		% disp(a.notes)
	% catch, if(vrb),disp('no notes');end, end
	% disp('IP:')
	% disp(a.IP)
% 
	% try, a.FM;
		% disp('FM:')
		% disp(a.FM)
	% catch, disp('no FM'); end
% 
% 
	% disp('vars:')
	% for n = 1:size(a.vars)(1)
		% disp(a.vars(n,:));
	% end
	% disp('varsA:')
	% for n = 1:size(a.varsA)(1)
		% disp(a.varsA(n,:));
	% end
% 
	% try, a.FE;
		% disp('FE:')
		% disp(a.FE)
	% catch, disp('no FE'); end
% 
	% try, a.OS;
		% disp('OS:')
		% disp(a.OS)
	% catch, disp('no OS'); end
% 
	% try, a.DA;
		% disp('DA:')
		% disp(a.DA)
	% catch, disp('no DA'); end
% 
	% try, a.DI;
		% disp('DI:')
		% disp(a.DI)
	% catch, disp('no DI'); end
% 
	% try, a.SF;
		% SFsp('SF:')
		% disp(a.SF)
	% catch, disp('no SF'); end
% 
	% try, a.LE;
		% LEsp('LE:')
		% disp(a.LE)
	% catch, disp('no LE'); end
