/* file -  iomod - generic text I/O */
#include <stdio.h>
#include "m:\rid\rider.h"
#include "m:\rid\iodef.h"
#include "m:\rid\imdef.h"
#include "m:\rid\chdef.h"
#include "m:\rid\medef.h"
#include "m:\rid\fidef.h"
#include "m:\rid\stdef.h"
/* code -  locals */
#define ioTfil struct ioTfil_t 
struct ioTfil_t
{ FILE *Pfil ;
  int Vlin ;
  char Aspc [ioLspc];
   };
ioTfil *io_map (int );
#define ioLfil  sizeof(ioTfil)
ioTfil *ioAfil [ioCtot];
static int ioVsrc = 0;
/* code -  io_ini - initialize file database */
io_ini()
{ ioVsrc = 0;
  return 1;
} 
/* code -  io_map - map i/o file block */
ioTfil *io_map(
int fid )
{ ioTfil *fil ;
  if ( !fid) {fid = ioVsrc ;}
  fil = ioAfil[fid];
  if ( !fil) {
    fil = me_acc (ioLfil);
    ioAfil[fid] = fil; }
  return ( fil);
} 
/* code -  io_spc return file spec */
char *io_spc(
int fid )
{ return ( io_map (fid)->Aspc);
} 
/* code -  io_lin - return current line number */
int io_lin(
int fid )
{ return ( io_map (fid)->Vlin);
} 
/* code -  io_src - open source file */
int io_src(
char *nam ,
char *def )
{ int fid = ioVsrc + 1;
  if ( fid >= ioClst) {
     im_rep ("E-Too many Includes at [%s]", nam);return 0; }
  if( (io_opn (fid, nam, def, "r")) == 0)return ( 0 );
  ioVsrc = fid;
  return 1;
} 
/* code -  io_opn - open file */
int io_opn(
int fid ,
char *nam ,
char *def ,
register char *mod )
{ ioTfil *fil = io_map (fid);
  char *spc = fil->Aspc;
  if ( !fi_def (nam, def, spc)) {
     im_rep ("E-Invalid file specification [%s]", nam);return 0; }
  fil->Vlin = 0;
  fil->Pfil = fi_opn (spc, mod,"");
  if( fil->Pfil)return 1;
  if ( *mod == 'r') {im_rep ("E-File not found [%s]", spc) ;} else {
    im_rep ("E-File not created [%s]", spc) ; }
  return 0;
} 
/* code -  io_clo - close file */
int io_clo(
int fid )
{ ioTfil *fil = io_map (fid);
  if( !fil)return 1;
  fil->Vlin = 0;
  fi_clo (fil->Pfil, "");
  return 1;
} 
/* code -  io_get - get next input record */
int io_get(
char *buf )
{ ioTfil *fil ;
  register char *lst ;
  for(;;)  {
    if( ioVsrc == 0)return 0;
    fil = io_map (ioVsrc);
    if( (fi_get (fil->Pfil, buf, ioLlin)) != EOF)break;
    io_clo (ioVsrc);
    --ioVsrc;
  } 
  if ( *buf != 0) {
    lst = st_lst (buf);
    if (( *--lst == _cr)
    ||(*++lst == _nl)) {
      *lst = 0; } }
  ++fil->Vlin;
  return 1;
} 
/* code -  io_put - put next output record */
int io_put(
char *buf )
{ ioTfil *fil = io_map (ioCout);
  if ( !fil->Pfil) {
     im_rep ("E-No output file open", NULL);return 0; }
  fi_wri (fil->Pfil, buf, (~1));
  ++fil->Vlin;
  return 1;
} 