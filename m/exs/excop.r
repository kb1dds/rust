file	copy - expat copy & touch commands
include rid:rider	; rider
include	rid:fidef	; files
include	rid:imdef	; image
include	rid:vfdef	; virtual files
include rid:fidef	; files
include rid:stdef	; strings
include rid:tidef	; time
include	exb:exmod	; expat

;	COPY/ASCII/DATE/LOG/QUERY/BEFORE/DATE/SINCE src dst
;
;	/NOREPLACE
;	/DELETE/PREDELETE/[NO]PROTECTION
;	/SYSTEM
;	/UNPROTECT
;	/WAIT
;
;	/BINARY/CONCATENATE
;
;
;	Single wildcard filespec for input and output

	cu_ptb : (*FILE, int)-

  func	cm_cop
	src : * vfTobj
	ent : * vfTent~
  is	dst : * vfTobj = &Idst		; destination object
	opt : * FILE~			; output file
	rgt : [mxSPC] char		; right spec (output)
	tim : tiTplx			; time
	err : int = 0			; error flag
	cha : int			; some character/byte

	++ctl.Vcnt			; found another file
					;	
	cu_res (dst->Aspc,ent->Anam,rgt) ; get resultant output spec

	if ctl.Qnrp && fi_exs (rgt, <>)	; /noreplace
	.. fail im_rep ("I-File exists, not replaced by [%s]", rgt)
					;
	if ctl.Qupd			; /update
	&& fi_exs (rgt, <>)		; file exists
	&& fi_gtp (rgt, &tim, <>)	; get plex time
	&& tm_cmp (&ent->Itim, &tim) gt	; compare times
	else
	.. fine
 					;
	opt = fi_opn (rgt, "wb", "")	; open the output file
	fail ++err if fail		; system error
					;
	while (cha = vf_get (src)) ne EOF
	   next if !cu_asc (cha)	; check /ascii
	   cu_ptb (opt, cha) if ctl.Qdtb; /detab
	   fi_ptb (opt, cha) otherwise	;
	   next
;	   next if ne EOF		; we're good
	   im_rep ("E-Error writing %s", rgt)
	   fi_prg (opt, "")		; RUST/RT purge; Windows close
	   fail ++err		;
   	end				;
	fail if err			;
	fi_clo (opt, "")		; close output
	ctl.Qdat ? &ctl.Inew  ?? &ent->Itim ; /SETDATE or source date
	fi_stp (rgt, that, "") 		; set file time - plex
	fine
  end

code	cu_ptb -- edit output

  func	cu_ptb
	fil : * FILE~
	cha : int
  is	case cha
	of '\t' cu_ptb (fil, ' ')
		cu_ptb (fil, ' ') while (ctl.Vcol&7) ne
	of '\r'
	or '\n' ctl.Vcol = -1
	or other
	   fi_ptb (fil, cha)
	   ++ctl.Vcol
	end case
  end

code	touch command

;	Touch and copy share the set date library routines

  func	cm_tou
	src : * vfTobj
	ent : * vfTent~
  is	spc : [mxSPC] char
	cu_res (src->Aspc,ent->Anam,spc); get resultant spc
	fi_stp (spc, &ctl.Inew, "") 	; set file time - plex
	fine
  end
                                                                                                                                                                                                                  