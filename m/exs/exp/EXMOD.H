/* header exmod - EXPAT module definitions */
#ifndef _RIDER_H_exmod
#define _RIDER_H_exmod 1
#include "rid:rider.h"
#include "rid:dcdef.h"
#include "rid:fidef.h"
#include "rid:mxdef.h"
#include "rid:tidef.h"
#include "rid:vfdef.h"
typedef int cxTfun ();
int cx_dis ();
/* code -  cuTctl - EXPAT control block */
extern vfTobj Isrc ;
extern vfTobj Idst ;
#define cuTctl struct cuTctl_t 
struct cuTctl_t
{dcTdcl *Pdcl ;
  vfTobj *Psrc ;
  vfTobj *Pdst ;
  char Abef [mxSPC];
  char Adat [mxSPC];
  char Asin [mxSPC];
  tiTplx Ibef ;
  tiTplx Idat ;
  tiTplx Inew ;
  tiTplx Isin ;
  char Aexc [mxLIN];
  char Aopt [mxSPC];
  FILE *Hopt ;
  char Adir [mxSPC];
  int Vfct ;
  int Qasc ;
  int Qbrf ;
  int Qdat ;
  int Qexe ;
  int Qful ;
  int Qlst ;
  int Qlog ;
  int Qnew ;
  int Qoct ;
  int Qpau ;
  int Qque ;
  int Q7bt ;
  char Asch [mxLIN];
  int Qxdp ;
  int Qana ;
  int Qemt ;
  int Qdrs ;
  int Qpas ;
  int Qxmx ;
#if Win
  char Aexe [mxSPC];
#endif 
   };
extern cuTctl ctl ;
extern dcTitm cuAdcl [];
extern char *cuAhlp [];
dcTfun cv_cop ;
dcTfun cv_dir ;
dcTfun cv_typ ;
dc_ovl ();
dcTfun cm_cop ;
dcTfun cm_del ;
dcTfun cm_dir ;
dcTfun cm_ren ;
dcTfun cm_typ ;
dcTfun cm_xdp ;
int cu_asc ();
cu_gdt ();
cu_cdt ();
int cu_exe ();
cu_exc ();
int cu_log ();
FILE *cu_opt ();
int cu_pau ();
int cu_que ();
cu_res ();
cu_fmt ();
int cu_sub ();
cu_prg ();
cu_fnf ();
LONG cu_len ();
#endif
                                                     