/* file -  ripre - preprocessor functions */
#include "m:\rid\ridef.h"
#include "m:\rid\eddef.h"
#include "m:\rid\imdef.h"
#include "m:\rid\iodef.h"
#include "m:\rid\ridat.h"
#include "m:\rid\stdef.h"
/* code -  pp_if - preprocessor conditional */
void pp_if()
{ ed_del (" ");
  if ( ed_del ("!&")) {
    ed_pre ("#ifndef ");
  } else if ( ed_del ("&")) {
    ed_pre ("#ifdef ");
    } else {
    ed_pre ("#if "); }
} 
/* code -  pp_elf - preprocessor elif */
void pp_elf()
{ ed_pre ("#elif ");
} 
/* code -  pp_els - preprocessor else */
void pp_els()
{ ed_pre ("#else ");
} 
/* code -  pp_end - preprocessor end */
void pp_end()
{ ed_pre ("#endif ");
} 
/* code -  pp_pra - pragma */
void pp_pra()
{ ed_pre ("#pragma ");
} 
/* code -  pp_rep - report */
void pp_rep()
{ ed_pre ("#error ");
} 
/* code -  pp_hea - preprocessor header */
void pp_hea()
{ char nam [64];
  char idt [64];
  ed_del (" ");
  ut_idt (edPdot, idt);
  if ( idt[0] == 0) {
    im_rep ("E-Header name missing [%s]", riAseg);
    return; }
  ut_seg ("header", NULL);
  ed_rst (nam);
  ri_fmt ("/* header %s */", nam);
  ri_fmt ("#ifndef _RIDER_H_%s", idt);
  ri_fmt ("#define _RIDER_H_%s 1", idt);
  if ( riVhdr) {
    im_rep ("W-Nested header [%s]", riAseg); }
  ++riVhdr;
} 
/* code -  pp_ehd - end header */
void pp_ehd()
{ if ( riVhdr == 0) {
    im_rep ("E-End header outside header [%s]", riAseg);
    } else {
    --riVhdr; }
  ri_fmt ("#endif");
} 
/* code -  pp_fix - fixup conditional variable */
#define ppBEG  0
#define ppOR  1
#define ppAND  2
#define ppEND  3
void pp_fix()
{ char cnd [64];
  char exp [64];
  char rep [64];
  int tst = 0;
  int def = 0;
  int val = 0;
  int opr ;
  int nxt = ppBEG;
  for(;;)  {
    switch ( (opr = nxt)) {
    case ppBEG:
      ed_del (" ");
      if( (ed_sub (" ?= ", "", cnd)) == 0)break;
      tst = (ed_sub (" If ", "", rep)) != NULL;
     break; case ppOR:
      ri_fmt ("#if !(%s)", cnd);
     break; case ppAND:
      ri_fmt ("#if (%s)", cnd);
     break; case ppEND:
      return;
       }
    ed_del (" ");
    val = def = 0;
    if ( ed_del ("*")) {++val ;}
    if ( ed_del ("&")) {++def ;}
    if ( ed_del ("!&")) {--def ;} else {
      ++val ; }
    if ( ed_sub (" || ", "", exp)) {
      nxt = ppOR;
    } else if ( ed_sub (" && ", "", exp)) {
      nxt = ppAND;
      } else {
      nxt = ppEND;
      ed_rst (exp);
      if( exp[0] == 0)break; }
    if ( !tst && opr != ppAND) {
      ri_fmt ("#undef %s", cnd);
      ri_fmt ("#define %s 0", cnd); }
    if ( def < 0) {ri_fmt ("#ifndef %s",exp) ;}
    if ( def > 0) {ri_fmt ("#ifdef %s",exp) ;}
    if ( val) {ri_fmt ("#if (%s)", exp) ;}
    if ( !tst) {
      ri_fmt ("#undef %s", cnd);
      ri_fmt ("#define %s 1", cnd);
      } else {
      st_rep (" (", "(", cnd);
      ri_fmt ("#define %s %s", cnd, rep); }
    if ( def) {ri_fmt ("#endif") ;}
    if ( val) {ri_fmt ("#endif") ;}
    switch ( opr) {
    case ppOR:
    case ppAND:
      ri_fmt ("#endif");
       }
  } 
  im_rep ("W-Invalid conditional fixup in [%s]", riAseg);
} 
/* code -  pp_mod - output module */
void pp_mod()
{ char buf [64];
  char *lst ;
  ed_del (" \"");
  ed_rst (buf);
  lst = st_lst (buf);
  if ( *lst == '\"') {*lst = 0 ;}
  ++riVsup;
  riVinh = 0;
  if ( buf[0] == 0) {
    im_rep ("E-No module filespec [%s]", riAseg);
    return; }
  io_clo (ioCout);
  if( (io_opn (ioCout, buf, "noname.c", "w")) != 0)return;
  io_opn (ioCout, riPsop, "noname.c", "w");
  im_rep ("E-Error creating module [%s]", buf);
} 
/* code -  pp_emd - end module */
void pp_emd()
{ io_clo (ioCout);
  ++riVinh;
} 