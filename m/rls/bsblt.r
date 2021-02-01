file	bsblt - blit operations

  type	bsTblt
  is	sec : * bsTsec
	use : int		; usage
	tra : int		; transparent color
				;
	si  : * BITMAPINFO	; source info
	sb  : * void		; source buffer
	sx  : int		; x origin source
	sy  : int		; 
				;
	di  : * BITMAPINFO	; destination info
	db  : * void		; destination buffer
	dx  : int		; x origin destination
	dy  : int		;
  end

  func	bs_tra
	blt : * bsTblt

BOOL TransparentDIBits( BITMAPINFO far *pBufferHeader,
  void huge *pBufferBits,
  int nXOriginDest, int nYOriginDest, void const far *pBits,
  BITMAPINFO const far *pBitmapInfo, int nXOriginSrc, int nYOriginSrc,
  int iUsage, char unsigned TransparentColor )
{
  BOOL ReturnValue = FALSE;

	ndx : int
	ndy : int
	ddx : int
	ddy : int
	wid : int
	hgt : int
  int NewDestinationXOrigin;
  int NewDestinationYOrigin;
  int DestinationDeltaX;
  int DestinationDeltaY;
  int Width;
  int Height;
	nso : int
	nsy : int
	ori : int = 1
	dht : int
	swd
	sht : int
  int NewSourceXOrigin;
  int NewSourceYOrigin;
  int Orientation = 1;
  int DestinationHeight = DibHeight(&pBufferHeader->bmiHeader);
  int SourceWidth = DibWidth(&pBitmapInfo->bmiHeader);
  int SourceHeight = DibHeight(&pBitmapInfo->bmiHeader);

  char unsigned huge *pSource;
  WORD DestSelector;
  DWORD DestOffset;

  RECT SourceRectangle = { nXOriginDest, nYOriginDest,
    nXOriginDest + SourceWidth, nYOriginDest + SourceHeight };

  RECT DestinationRectangle;

  RECT ClippedRectangle;

  if(DestinationHeight < 0)   // check for top-down DIB
  {
    Orientation = -1;
    DestinationHeight = -DestinationHeight;
  }

  DestinationRectangle.top = 0;
  DestinationRectangle.left = 0;
  DestinationRectangle.bottom = DestinationHeight;
  DestinationRectangle.right = DibWidth(&pBufferHeader->bmiHeader);

  // intersect the destination rectangle with the destination DIB

  if(IntersectRect(&ClippedRectangle,&SourceRectangle,
    &DestinationRectangle))
  {
    // default delta scan to width in bytes
    long DestinationScanDelta = DibWidthBytes(&pBufferHeader->bmiHeader);


    NewDestinationXOrigin = ClippedRectangle.left;
    NewDestinationYOrigin = ClippedRectangle.top;

    DestinationDeltaX = NewDestinationXOrigin - nXOriginDest;
    DestinationDeltaY = NewDestinationYOrigin - nYOriginDest;

    Width = ClippedRectangle.right - ClippedRectangle.left;
    Height = ClippedRectangle.bottom - ClippedRectangle.top;

    pSource = (char unsigned huge *)pBits;

    NewSourceXOrigin = DestinationDeltaX;
    NewSourceYOrigin = DestinationDeltaY;

    pSource += ((long)SourceHeight - (NewSourceYOrigin + Height)) *
      (long)DibWidthBytes(&pBitmapInfo->bmiHeader)
      + NewSourceXOrigin;

    // now we'll calculate the starting destination pointer taking into
    // account we may have a top-down destination

    DestSelector = HIWORD(pBufferBits);

    if(Orientation < 0)
    {
      // destination is top-down

      DestinationScanDelta *= -1;

      DestOffset = (long)(NewDestinationYOrigin + Height - 1) *
        (long)DibWidthBytes(&pBufferHeader->bmiHeader) +
        NewDestinationXOrigin;
    }
    else
    {
      // destination is bottom-up

      DestOffset = ((long)DestinationHeight -
        (NewDestinationYOrigin + Height))
        * (long)DibWidthBytes(&pBufferHeader->bmiHeader) +
        NewDestinationXOrigin;
    }

    TransCopyDIBBits(DestSelector,DestOffset,pSource,Width,Height,
      DestinationScanDelta,
      DibWidthBytes(&pBitmapInfo->bmiHeader),
      TransparentColor);

    ReturnValue = TRUE;
  }

  return ReturnValue;
}
/**************************************************************************

    TBLT.C - transparent blt

 **************************************************************************/
/**************************************************************************

    (C) Copyright 1994 Microsoft Corp.  All rights reserved.

    You have a royalty-free right to use, modify, reproduce and 
    distribute the Sample Files (and/or any modified version) in 
    any way you find useful, provided that you agree that 
    Microsoft has no warranty obligations or liability for any 
    Sample Application Files which are modified. 

 **************************************************************************/

#include <windows.h>
#include <windowsx.h>
#include <wing.h>

#include "..\utils\utils.h"

extern  void PASCAL far TransCopyDIBBits( WORD DestSelector, DWORD DestOffset,
  void const far *pSource, DWORD Width, DWORD Height, long DestWidth,
  long SourceWidth, char unsigned TransparentColor );


/*----------------------------------------------------------------------------

This function ignores the source origin and blts the entire source.

*/

BOOL TransparentDIBits( BITMAPINFO far *pBufferHeader,
  void huge *pBufferBits,
  int nXOriginDest, int nYOriginDest, void const far *pBits,
  BITMAPINFO const far *pBitmapInfo, int nXOriginSrc, int nYOriginSrc,
  int iUsage, char unsigned TransparentColor )
{
  BOOL ReturnValue = FALSE;

  int NewDestinationXOrigin;
  int NewDestinationYOrigin;
  int DestinationDeltaX;
  int DestinationDeltaY;
  int Width;
  int Height;
  int NewSourceXOrigin;
  int NewSourceYOrigin;
  int Orientation = 1;
  int DestinationHeight = DibHeight(&pBufferHeader->bmiHeader);
  int SourceWidth = DibWidth(&pBitmapInfo->bmiHeader);
  int SourceHeight = DibHeight(&pBitmapInfo->bmiHeader);

  char unsigned huge *pSource;
  WORD DestSelector;
  DWORD DestOffset;

  RECT SourceRectangle = { nXOriginDest, nYOriginDest,
    nXOriginDest + SourceWidth, nYOriginDest + SourceHeight };

  RECT DestinationRectangle;

  RECT ClippedRectangle;

  if(DestinationHeight < 0)   // check for top-down DIB
  {
    Orientation = -1;
    DestinationHeight = -DestinationHeight;
  }

  DestinationRectangle.top = 0;
  DestinationRectangle.left = 0;
  DestinationRectangle.bottom = DestinationHeight;
  DestinationRectangle.right = DibWidth(&pBufferHeader->bmiHeader);

  // intersect the destination rectangle with the destination DIB

  if(IntersectRect(&ClippedRectangle,&SourceRectangle,
    &DestinationRectangle))
  {
    // default delta scan to width in bytes
    long DestinationScanDelta = DibWidthBytes(&pBufferHeader->bmiHeader);


    NewDestinationXOrigin = ClippedRectangle.left;
    NewDestinationYOrigin = ClippedRectangle.top;

    DestinationDeltaX = NewDestinationXOrigin - nXOriginDest;
    DestinationDeltaY = NewDestinationYOrigin - nYOriginDest;

    Width = ClippedRectangle.right - ClippedRectangle.left;
    Height = ClippedRectangle.bottom - ClippedRectangle.top;

    pSource = (char unsigned huge *)pBits;

    NewSourceXOrigin = DestinationDeltaX;
    NewSourceYOrigin = DestinationDeltaY;

    pSource += ((long)SourceHeight - (NewSourceYOrigin + Height)) *
      (long)DibWidthBytes(&pBitmapInfo->bmiHeader)
      + NewSourceXOrigin;

    // now we'll calculate the starting destination pointer taking into
    // account we may have a top-down destination

    DestSelector = HIWORD(pBufferBits);

    if(Orientation < 0)
    {
      // destination is top-down

      DestinationScanDelta *= -1;

      DestOffset = (long)(NewDestinationYOrigin + Height - 1) *
        (long)DibWidthBytes(&pBufferHeader->bmiHeader) +
        NewDestinationXOrigin;
    }
    else
    {
      // destination is bottom-up

      DestOffset = ((long)DestinationHeight -
        (NewDestinationYOrigin + Height))
        * (long)DibWidthBytes(&pBufferHeader->bmiHeader) +
        NewDestinationXOrigin;
    }

    TransCopyDIBBits(DestSelector,DestOffset,pSource,Width,Height,
      DestinationScanDelta,
      DibWidthBytes(&pBitmapInfo->bmiHeader),
      TransparentColor);

    ReturnValue = TRUE;
  }

  return ReturnValue;
}

    page ,132
    TITLE FAST32.ASM
;---------------------------------------------------------------------------;
;  FAST.ASM
;
;  32 bit asm routines for doing a "sprite" bitblt
;
;      TransCopyDIBBits - copy DIB bits with a transparent color
;      CopyDIBBits      - copy DIB bits without a transparent color
;
;   (C) Copyright 1994 Microsoft Corp.  All rights reserved.
;
;   You have a royalty-free right to use, modify, reproduce and
;   distribute the Sample Files (and/or any modified version) in
;   any way you find useful, provided that you agree that
;   Microsoft has no warranty obligations or liability for any
;   Sample Application Files which are modified.
;
;---------------------------------------------------------------------------;

;
; 32 bit code segment version of FAST16.ASM
;
; NOTE! cmacro32.inc needs MASM 5.1 compatibility
; Run MASM 6 specifying option: /Zm   (provides MASM 5.1 compatibility)
;
    .xlist
    include cmacro32.inc
    .list

;
; NOTE!!!! because we are generating USE32 code this must NOT
; be located in a code segment with USE16 code, so we put it into
; it's own little segment....
;

ifndef SEGNAME
    SEGNAME equ <FAST_TEXT32>
endif

createSeg %SEGNAME, CodeSeg, dword, use32, CODE

sBegin Data
sEnd Data

sBegin CodeSeg
        assumes cs,CodeSeg
        assumes ds,nothing
        assumes es,nothing

;-------------------------------------------------------
;
; TransCopyDIBBits
;
; Copy a block with transparency
;
;-------------------------------------------------------

cProc TransCopyDIBBits,<FAR, PASCAL, PUBLIC>,<>
        ParmW   DestSelector    ; dest 48bit pointer
        ParmD   DestOffset
        ParmD   pSource         ; source pointer
        ParmD   dwWidth         ; width pixels
        ParmD   dwHeight        ; height pixels
        ParmD   dwScanD         ; width bytes dest
        ParmD   dwScanS         ; width bytes source
        ParmB   bTranClr        ; transparent color
cBegin
        push ds
        push esi
        push edi

        mov ecx, dwWidth
        or ecx,ecx
        jz tcdb_nomore     ; test for silly case

        mov edx, dwHeight       ; EDX is line counter
        mov ah, bTranClr        ; AL has transparency color

        xor esi, esi
        lds si, pSource         ; DS:[ESI] point to source

        mov es, DestSelector    ; es:[edi] point to dest
        mov edi, DestOffset

        sub dwScanD,ecx         ; bias these
        sub dwScanS,ecx

        mov ebx,ecx             ; save this for later

        align 4

tcdb_morelines:
        mov ecx, ebx            ; ECX is pixel counter
        shr ecx,2
        jz  short tcdb_nextscan

;
; The idea here is to not branch very often so we unroll the loop by four
; and try to not branch when a whole run of pixels is either transparent
; or not transparent.
;
; There are two loops. One loop is for a run of pixels equal to the
; transparent color, the other is for runs of pixels we need to store.
;
; When we detect a "bad" pixel we jump to the same position in the
; other loop.
;
; Here is the loop we will stay in as long as we encounter a "transparent"
; pixel in the source.
;

        align 4

tcdb_same:
        mov al, ds:[esi]
        cmp al, ah
        jne short tcdb_diff0

tcdb_same0:
        mov al, ds:[esi+1]
        cmp al, ah
        jne short tcdb_diff1

tcdb_same1:
        mov al, ds:[esi+2]
        cmp al, ah
        jne short tcdb_diff2

tcdb_same2:
        mov al, ds:[esi+3]
        cmp al, ah
        jne short tcdb_diff3

tcdb_same3:
        add edi,4
        add esi,4
        dec ecx
        jnz short tcdb_same
        jz  short tcdb_nextscan

;
; Here is the loop we will stay in as long as 
; we encounter a "non transparent" pixel in the source.
;

        align 4

tcdb_diff:
        mov al, ds:[esi]
        cmp al, ah
        je short tcdb_same0

tcdb_diff0:
        mov es:[edi],al
        mov al, ds:[esi+1]
        cmp al, ah
        je short tcdb_same1

tcdb_diff1:
        mov es:[edi+1],al
        mov al, ds:[esi+2]
        cmp al, ah
        je short tcdb_same2

tcdb_diff2:
        mov es:[edi+2],al
        mov al, ds:[esi+3]
        cmp al, ah
        je short tcdb_same3

tcdb_diff3:
        mov es:[edi+3],al

        add edi,4
        add esi,4
        dec ecx
        jnz short tcdb_diff
        jz  short tcdb_nextscan

;
; We are at the end of a scan, check for odd leftover pixels to do
; and go to the next scan.
;

        align 4

tcdb_nextscan:
        mov ecx,ebx
        and ecx,11b
        jnz short tcdb_oddstuff
        ; move on to the start of the next line

tcdb_nextscan1:
        add esi, dwScanS
        add edi, dwScanD

        dec edx                 ; line counter
        jnz short tcdb_morelines
        jz  short tcdb_nomore

;
; If the width is not a multiple of 4 we will come here to clean up
; the last few pixels
;

tcdb_oddstuff:
        inc ecx
tcdb_oddloop:
        dec ecx
        jz  short tcdb_nextscan1
        mov al, ds:[esi]
        inc esi
        inc edi
        cmp al, ah
        je  short tcdb_oddloop
        mov es:[edi-1],al
        jmp short tcdb_oddloop

tcdb_nomore:
        pop edi
        pop esi
        pop ds
cEnd

;-----------------------------------------------------------------------------;
;
; CopyDIBBits
;
; Copy a block without transparency
;
;-----------------------------------------------------------------------------;

cProc CopyDIBBits,<FAR, PASCAL, PUBLIC>,<>
        ParmD   pDest           ; dest pointer
        ParmD   pSource         ; source pointer
        ParmD   dwWidth         ; width pixels
        ParmD   dwHeight        ; height pixels
        ParmD   dwScanD         ; width bytes dest
        ParmD   dwScanS         ; width bytes source
cBegin
        push ds
        push esi
        push edi

        mov ecx, dwWidth
        or ecx,ecx
        jz cdb_nomore     ; test for silly case

        mov edx, dwHeight       ; EDX is line counter
        or edx,edx
        jz cdb_nomore     ; test for silly case

        xor esi, esi
        lds si, pSource         ; DS:[ESI] point to source

        xor edi, edi
        les di, pDest           ; ES:[EDI] point to dest

        sub dwScanD,ecx         ; bias these
        sub dwScanS,ecx

        mov ebx,ecx
        shr ebx,2

        mov eax,ecx
        and eax,11b

        align 4

cdb_loop:
        mov ecx, ebx
        rep movs dword ptr es:[edi], dword ptr ds:[esi]
        mov ecx,eax
        rep movs byte ptr es:[edi], byte ptr ds:[esi]

        add esi, dwScanS
        add edi, dwScanD
        dec edx                 ; line counter
        jnz short cdb_loop

cdb_nomore:
        pop edi
        pop esi
        pop ds
cEnd



sEnd CodeSeg
end
