function [F ind] = SP (F, A, R, Z0, ind)

	% [F ind] = SP (F, A, R, Z0, ind)
	%
	% This card is used to calculate the S-parameters for the active sources.
	%
	%	INPUT
	%
	%	A (1 on, 0 off)
	% Always add port impedance to existing loads: When S-parameters are computed, each port is automat-
	% 	ically loaded by FEKO with the S-parameter reference impedance of the port.  If this option is
	% 	checked, and the user has manually defined a load at a port, then the S-parameter load will be
	% 	added to the existing load at the port. If this option is not checked, then FEKO is backwards
	% 	compatible to the behaviour of the SP card in FEKO Suite 5.1 and earlier: FEKO will
	% 	automatically add the S- parameter reference loads at the various ports, but possible user
	% 	defined loads of the same load type (see discussion below) will be overwritten (i.e. then not
	% 	added) at these ports. 
	% R (1 on, 0 off)
	% Restore loads	after calculation: As discussed above, FEKO automatically adds loads to ports when com- 
	% 	puting S-parameters. With this option the behaviour can be controlled after the SP card
	% 	processing is finished.  When this option is enabled, the automatically added loads will be
	% 	removed again, and the load situation (for instance for a subsequent far field request) is the
	% 	same as if the SP card was not used. Otherwise, all the loads as set during the SP card
	% 	processing will remain in place afterwards. This was the default behaviour of FEKO Suite 5.1 and
	% 	earlier. See the discussion below regarding a potential run-time impact of restoring loads
	% 	(re-computing the MoM matrix is required then).  
	%	Z0
	% System impedance: The reference impedance in Ohm. This is used for all sources for which no
	% 	impedance value is specified when defining the source. If this field is empty, it defaults to 50
	% 	Ω.  Note that for waveguide sources (AW card) S-parameters are always related to the
	% 	corresponding waveguide impedance.
	%
	% The following paragraph is taken (and corresponding previous information) from :
	%
	% User’s Manual Suite 6.1.1 December 2011 Copyright 1998 – 2011: EM Software & Systems-S.A. (Pty)
	% Ltd 32 Techno Avenue, Technopark, Stellenbosch, 7600, South Africa Tel: +27-21-880-1880, Fax:
	% +27-21-880-1936 E-Mail: feko@emss.co.za WWW: http://www.feko.info
	%
	% The N ports must be defined before using the SP card. They are identified simply by defining
	% excitation cards. Currently only A1, A2, A3, A4, AE, AF, AN, AB and AW sources are supported.  A1,
	% A2 and A3 sources must be selected by label (not with position), and unique labels must be used
	% (i.e. no other segments or triangles may have a label which is used for a port).  If the amplitude
	% of any port is set to zero, it will be used as a receive port (or sink) but not as a source. For
	% example, if only S21 and S11 are required for a two port network, one may set the amplitude of the
	% source defining port 2 exactly to zero. Then S12 and S22 are not calculated — in some cases this may
	% save considerable computation time.  The S-parameter load impedance for each of the port sources can
	% be specified at the source itself. If no such impedance was specified, the System impedance (Ohm)
	% value specified with the SP card will be used (if this value is not specified it defaults to 50 Ω).
	% This S-parameter load impedance will be added automatically to each port. The only exception here
	% are waveguide orts (AW card) and modal ports (AB card), where S-parameters are related directly to
	% the corresponding waveguide impedance.  It must be noted that except for waveguide ports the SP card
	% adds load impedances to all the ports. For A1, A2 and A3 sources it uses LZ type loads; for A4
	% sources it uses L4 type loads; for AN sources it uses LN type loads and for AE sources it uses LE
	% type loads. If any similar loads were applied to the source position before the SP card these loads
	% will either be added or will be overwritten, as controlled by the Always add port impedance to
	% existing loads checkbox.  When execution continues after processing the SP card these loads will
	% either be removed or kept, as controlled by the checkbox Restore loads after calculation. This makes
	% a difference when for instance after the SP card the far field is computed by means of an FF card.
	% If the loads are removed, then the result for the far field pattern is the same as if there was no
	% SP card (i.e.  far field with ports not loaded by the S-parameter reference impedances). The
	% disadvantage of restoring the loads is that after the SP card processing the loads change and for
	% instance for the MoM this means that the MoM matrix changes, and in order to compute the far field
	% pattern, a full extra matrix computation and LU decomposition must be done. If the loads are kept,
	% then further results are readily available (i.e. the LU decomposed matrix can be re-used).  The
	% original amplitudes and phases of the excitations will, always be restored. It should, however, be
	% noted that unlike near- or far field computations or some other results, the amplitudes and phases
	% of the excitations at the various ports do not influence the S-parameter results (except for the
	% special case of setting the amplitude of a port to zero which indicates to FEKO that this is a
	% passive port only). This is not something special in FEKO, but is how S-parameters are defined (i.e.
	% results are normalised by the incident port signal). It should in particular also be noted that
	% setting a phase of 180◦ for the excitation of a port does not change the direction of this port. One
	% rather physically has to define the port the other way round (e.g. other feed segment orientation).
	% When viewing a model in POSTFEKO then the arrows always indicate the positive source direction and
	% the arrows will also not change direction when setting a 180◦ phase on the excitation.  Note that a
	% request to compute S-parameters is not required for 1-port networks, as the S11 (reflection
	% coefficient for a 1-port network) data will be available since it is always calculated for voltage
	% and current sources. For current and voltage sources, an additional S-parameter block will not be
	% computed if the model consist of a 1-port network and an SP card was requested and the reference
	% impedance remains unchanged. For waveguide and modal ports, S-parameters are calculated by default
	% in the same way that port impedances are calculated for voltage and current sources. When a
	% redundant S-parameter request has been made, a warning will be displayed to indicate to the user
	% that the SP card will be ignored. For n-port networks (with n ≥2) while processing S-parameter
	% request, source, power and impedance data is not written to *.out and *.bof files since this was
	% misleading as the effect of port loads were included.

	if ~exist('A') || isempty(A), A=1; end
	if ~exist('R') || isempty(R), R=0; end
	if ~exist('Z0') || isempty(Z0), Z0=50; end

	if ~ischar(Z0), Z0 = num2str(Z0); else Z0 = ['#' Z0]; end
	if ~ischar(A), A = num2str(A); else A = ['#' A]; end
	if ~ischar(R), R = num2str(R); else R = ['#' R]; end

	if ~exist('ind') || isempty(ind), try, ind = size(F.SP)(2)+1; catch, ind=1; end, end
	F.SP{ind} =['SP: ' A ' : ' R ' :  :  :  : ' Z0]; F.DA{ind}=[];
	ind = ind+1;
