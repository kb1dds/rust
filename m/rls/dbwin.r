file	dbwin - windows debugging
include	rid:rider
include	rid:dbdef
include	rid:imdef
include	rid:stdef
include	<windows.h>

  func	db_clr
  is	SetLastError (0)
	fine
  end

code	db_lst - decode last error message

  func	db_lst
	idt : * char
  is	err : int = GetLastError ()
	fine if !err
	db_rep (idt, err)
	fail
  end

  func	db_rep
	idt : * char
	err : int
  is	buf : [256] char
	msg : * char
	msg = dbw_err (err)
	st_cop ("I-", buf)
	if idt
	   st_app (idt, buf)
	.. st_app (" ", buf)
	FMT(st_end(buf), "(%d)-", err)
	st_app ("%s", buf)
	im_rep (buf, msg)
	fail
  end
code	dbw_msg - Windows Message Code

  type	dbwTmsg
  is	Vcod : nat
	Ptxt : * char
  end

  init	dbwAmsg : [] dbwTmsg
  is	WM_NULL, "WM_NULL"
	WM_CREATE, "WM_CREATE"
	WM_DESTROY, "WM_DESTROY"
	WM_MOVE, "WM_MOVE"
	WM_SIZE, "WM_SIZE"
	WM_ACTIVATE, "WM_ACTIVATE"
	WM_SETFOCUS, "WM_SETFOCUS"
	WM_KILLFOCUS, "WM_KILLFOCUS"
	WM_ENABLE, "WM_ENABLE"
	WM_SETREDRAW, "WM_SETREDRAW"
	WM_SETTEXT, "WM_SETTEXT"
	WM_GETTEXT, "WM_GETTEXT"
	WM_GETTEXTLENGTH, "WM_GETTEXTLENGTH"
	WM_PAINT, "WM_PAINT"
	WM_CLOSE, "WM_CLOSE"
	WM_QUERYENDSESSION, "WM_QUERYENDSESSION"
	WM_QUIT, "WM_QUIT"
	WM_QUERYOPEN, "WM_QUERYOPEN"
	WM_ERASEBKGND, "WM_ERASEBKGND"
	WM_SYSCOLORCHANGE, "WM_SYSCOLORCHANGE"
	WM_ENDSESSION, "WM_ENDSESSION"
	WM_SHOWWINDOW, "WM_SHOWWINDOW"
	WM_WININICHANGE, "WM_WININICHANGE"
	WM_DEVMODECHANGE, "WM_DEVMODECHANGE"
	WM_ACTIVATEAPP, "WM_ACTIVATEAPP"
	WM_FONTCHANGE, "WM_FONTCHANGE"
	WM_TIMECHANGE, "WM_TIMECHANGE"
	WM_CANCELMODE, "WM_CANCELMODE"
	WM_SETCURSOR, "WM_SETCURSOR"
	WM_MOUSEACTIVATE, "WM_MOUSEACTIVATE"
	WM_CHILDACTIVATE, "WM_CHILDACTIVATE"
	WM_QUEUESYNC, "WM_QUEUESYNC"
	WM_GETMINMAXINFO, "WM_GETMINMAXINFO"
	WM_PAINTICON, "WM_PAINTICON"
	WM_ICONERASEBKGND, "WM_ICONERASEBKGND"
	WM_NEXTDLGCTL, "WM_NEXTDLGCTL"
	WM_SPOOLERSTATUS, "WM_SPOOLERSTATUS"
	WM_DRAWITEM, "WM_DRAWITEM"
	WM_MEASUREITEM, "WM_MEASUREITEM"
	WM_DELETEITEM, "WM_DELETEITEM"
	WM_VKEYTOITEM, "WM_VKEYTOITEM"
	WM_CHARTOITEM, "WM_CHARTOITEM"
	WM_SETFONT, "WM_SETFONT"
	WM_GETFONT, "WM_GETFONT"
	WM_SETHOTKEY, "WM_SETHOTKEY"
	WM_GETHOTKEY, "WM_GETHOTKEY"
	WM_QUERYDRAGICON, "WM_QUERYDRAGICON"
	WM_COMPAREITEM, "WM_COMPAREITEM"
	WM_COMPACTING, "WM_COMPACTING"
;	WM_OTHERWINDOWCREATED, "WM_OTHERWINDOWCREATED"
;	WM_OTHERWINDOWDESTROYED, "WM_OTHERWINDOWDESTROYED"
	WM_COMMNOTIFY, "WM_COMMNOTIFY"
	WM_WINDOWPOSCHANGING, "WM_WINDOWPOSCHANGING"
	WM_WINDOWPOSCHANGED, "WM_WINDOWPOSCHANGED"
	WM_POWER, "WM_POWER"
	WM_COPYDATA, "WM_COPYDATA"
	WM_CANCELJOURNAL, "WM_CANCELJOURNAL"
	WM_NCCREATE, "WM_NCCREATE"
	WM_NCDESTROY, "WM_NCDESTROY"
	WM_NCCALCSIZE, "WM_NCCALCSIZE"
	WM_NCHITTEST, "WM_NCHITTEST"
	WM_NCPAINT, "WM_NCPAINT"
	WM_NCACTIVATE, "WM_NCACTIVATE"
	WM_GETDLGCODE, "WM_GETDLGCODE"
	WM_NCMOUSEMOVE, "WM_NCMOUSEMOVE"
	WM_NCLBUTTONDOWN, "WM_NCLBUTTONDOWN"
	WM_NCLBUTTONUP, "WM_NCLBUTTONUP"
	WM_NCLBUTTONDBLCLK, "WM_NCLBUTTONDBLCLK"
	WM_NCRBUTTONDOWN, "WM_NCRBUTTONDOWN"
	WM_NCRBUTTONUP, "WM_NCRBUTTONUP"
	WM_NCRBUTTONDBLCLK, "WM_NCRBUTTONDBLCLK"
	WM_NCMBUTTONDOWN, "WM_NCMBUTTONDOWN"
	WM_NCMBUTTONUP, "WM_NCMBUTTONUP"
	WM_NCMBUTTONDBLCLK, "WM_NCMBUTTONDBLCLK"

	WM_KEYFIRST, "WM_KEYFIRST"
	WM_KEYDOWN, "WM_KEYDOWN"
	WM_KEYUP, "WM_KEYUP"
	WM_CHAR, "WM_CHAR"
	WM_DEADCHAR, "WM_DEADCHAR"
	WM_SYSKEYDOWN, "WM_SYSKEYDOWN"
	WM_SYSKEYUP, "WM_SYSKEYUP"
	WM_SYSCHAR, "WM_SYSCHAR"
	WM_SYSDEADCHAR, "WM_SYSDEADCHAR"
	WM_KEYLAST, "WM_KEYLAST"
	WM_INITDIALOG, "WM_INITDIALOG"
	WM_COMMAND, "WM_COMMAND"
	WM_SYSCOMMAND, "WM_SYSCOMMAND"
	WM_TIMER, "WM_TIMER"
	WM_HSCROLL, "WM_HSCROLL"
	WM_VSCROLL, "WM_VSCROLL"
	WM_INITMENU, "WM_INITMENU"
	WM_INITMENUPOPUP, "WM_INITMENUPOPUP"
	WM_MENUSELECT, "WM_MENUSELECT"
	WM_MENUCHAR, "WM_MENUCHAR"
	WM_ENTERIDLE, "WM_ENTERIDLE"

	WM_CTLCOLORMSGBOX, "WM_CTLCOLORMSGBOX"
	WM_CTLCOLOREDIT, "WM_CTLCOLOREDIT"
	WM_CTLCOLORLISTBOX, "WM_CTLCOLORLISTBOX"
	WM_CTLCOLORBTN, "WM_CTLCOLORBTN"
	WM_CTLCOLORDLG, "WM_CTLCOLORDLG"
	WM_CTLCOLORSCROLLBAR, "WM_CTLCOLORSCROLLBAR"
	WM_CTLCOLORSTATIC, "WM_CTLCOLORSTATIC"

	WM_MOUSEFIRST, "WM_MOUSEFIRST"
	WM_MOUSEMOVE, "WM_MOUSEMOVE"
	WM_LBUTTONDOWN, "WM_LBUTTONDOWN"
	WM_LBUTTONUP, "WM_LBUTTONUP"
	WM_LBUTTONDBLCLK, "WM_LBUTTONDBLCLK"
	WM_RBUTTONDOWN, "WM_RBUTTONDOWN"
	WM_RBUTTONUP, "WM_RBUTTONUP"
	WM_RBUTTONDBLCLK, "WM_RBUTTONDBLCLK"
	WM_MBUTTONDOWN, "WM_MBUTTONDOWN"
	WM_MBUTTONUP, "WM_MBUTTONUP"
	WM_MBUTTONDBLCLK, "WM_MBUTTONDBLCLK"
	WM_MOUSELAST, "WM_MOUSELAST"

	WM_PARENTNOTIFY, "WM_PARENTNOTIFY"
	WM_ENTERMENULOOP, "WM_ENTERMENULOOP"
	WM_EXITMENULOOP, "WM_EXITMENULOOP"
	WM_MDICREATE, "WM_MDICREATE"
	WM_MDIDESTROY, "WM_MDIDESTROY"
	WM_MDIACTIVATE, "WM_MDIACTIVATE"
	WM_MDIRESTORE, "WM_MDIRESTORE"
	WM_MDINEXT, "WM_MDINEXT"
	WM_MDIMAXIMIZE, "WM_MDIMAXIMIZE"
	WM_MDITILE, "WM_MDITILE"
	WM_MDICASCADE, "WM_MDICASCADE"
	WM_MDIICONARRANGE, "WM_MDIICONARRANGE"
	WM_MDIGETACTIVE, "WM_MDIGETACTIVE"
	WM_MDISETMENU, "WM_MDISETMENU"
	WM_DROPFILES, "WM_DROPFILES"
	WM_MDIREFRESHMENU, "WM_MDIREFRESHMENU"

	WM_CUT, "WM_CUT"
	WM_COPY, "WM_COPY"
	WM_PASTE, "WM_PASTE"
	WM_CLEAR, "WM_CLEAR"
	WM_UNDO, "WM_UNDO"
	WM_RENDERFORMAT, "WM_RENDERFORMAT"
	WM_RENDERALLFORMATS, "WM_RENDERALLFORMATS"
	WM_DESTROYCLIPBOARD, "WM_DESTROYCLIPBOARD"
	WM_DRAWCLIPBOARD, "WM_DRAWCLIPBOARD"
	WM_PAINTCLIPBOARD, "WM_PAINTCLIPBOARD"
	WM_VSCROLLCLIPBOARD, "WM_VSCROLLCLIPBOARD"
	WM_SIZECLIPBOARD, "WM_SIZECLIPBOARD"
	WM_ASKCBFORMATNAME, "WM_ASKCBFORMATNAME"
	WM_CHANGECBCHAIN, "WM_CHANGECBCHAIN"
	WM_HSCROLLCLIPBOARD, "WM_HSCROLLCLIPBOARD"
	WM_QUERYNEWPALETTE, "WM_QUERYNEWPALETTE"
	WM_PALETTEISCHANGING, "WM_PALETTEISCHANGING"
	WM_PALETTECHANGED, "WM_PALETTECHANGED"
	WM_HOTKEY, "WM_HOTKEY"

	WM_PENWINFIRST, "WM_PENWINFIRST"
	WM_PENWINLAST, "WM_PENWINLAST"

;	MM codes

	MM_JOY1MOVE, "MM_JOY1MOVE"
	MM_JOY2MOVE, "MM_JOY2MOVE"
	MM_JOY1ZMOVE, "MM_JOY1ZMOVE"
	MM_JOY2ZMOVE, "MM_JOY2ZMOVE"
	MM_JOY1BUTTONDOWN, "MM_JOY1BUTTONDOWN"
	MM_JOY2BUTTONDOWN, "MM_JOY2BUTTONDOWN"
	MM_JOY1BUTTONUP, "MM_JOY1BUTTONUP"
	MM_JOY2BUTTONUP, "MM_JOY2BUTTONUP"
	MM_MCINOTIFY, "MM_MCINOTIFY"
	MM_MCISYSTEM_STRING, "MM_MCISYSTEM_STRING"
	MM_WOM_OPEN, "MM_WOM_OPEN"
	MM_WOM_CLOSE, "MM_WOM_CLOSE"
	MM_WOM_DONE, "MM_WOM_DONE"
	MM_WIM_OPEN, "MM_WIM_OPEN"
	MM_WIM_CLOSE, "MM_WIM_CLOSE"
	MM_WIM_DATA, "MM_WIM_DATA"
	MM_MIM_OPEN, "MM_MIM_OPEN"
	MM_MIM_CLOSE, "MM_MIM_CLOSE"
	MM_MIM_DATA, "MM_MIM_DATA"
	MM_MIM_LONGDATA, "MM_MIM_LONGDATA"
	MM_MIM_ERROR, "MM_MIM_ERROR"
	MM_MIM_LONGERROR, "MM_MIM_LONGERROR"
	MM_MOM_OPEN, "MM_MOM_OPEN"
	MM_MOM_CLOSE, "MM_MOM_CLOSE"
	MM_MOM_DONE, "MM_MOM_DONE"

	WM_USER, "WM_USER"
	0, <>
  end

code	dbw_msg - decode message code

  func	dbw_msg
	cod : nat
	()  : * char
  is	ent : * dbwTmsg = dbwAmsg
	while (ent->Ptxt)
	   if cod eq ent->Vcod
	   .. reply ent->Ptxt
	   ++ent
	end
	reply "Unknown message"
  end
code	dbw_err - Windows Error Code

  type	dbwTerr
  is	Vcod : nat
	Ptxt : * char
  end

  init	dbwAerr : [] dbwTerr
  is	NO_ERROR, "NO_ERROR"
	ERROR_SUCCESS, "ERROR_SUCCESS"
	ERROR_INVALID_FUNCTION, "ERROR_INVALID_FUNCTION"
	ERROR_FILE_NOT_FOUND, "ERROR_FILE_NOT_FOUND"
	ERROR_PATH_NOT_FOUND, "ERROR_PATH_NOT_FOUND"
	ERROR_TOO_MANY_OPEN_FILES, "ERROR_TOO_MANY_OPEN_FILES"
	ERROR_ACCESS_DENIED, "ERROR_ACCESS_DENIED"
	ERROR_INVALID_HANDLE, "ERROR_INVALID_HANDLE"
	ERROR_ARENA_TRASHED, "ERROR_ARENA_TRASHED"
	ERROR_NOT_ENOUGH_MEMORY, "ERROR_NOT_ENOUGH_MEMORY"
	ERROR_INVALID_BLOCK, "ERROR_INVALID_BLOCK"
	ERROR_BAD_ENVIRONMENT, "ERROR_BAD_ENVIRONMENT"
	ERROR_BAD_FORMAT, "ERROR_BAD_FORMAT"
	ERROR_INVALID_ACCESS, "ERROR_INVALID_ACCESS"
	ERROR_INVALID_DATA, "ERROR_INVALID_DATA"
	ERROR_OUTOFMEMORY, "ERROR_OUTOFMEMORY"
	ERROR_INVALID_DRIVE, "ERROR_INVALID_DRIVE"
	ERROR_CURRENT_DIRECTORY, "ERROR_CURRENT_DIRECTORY"
	ERROR_NOT_SAME_DEVICE, "ERROR_NOT_SAME_DEVICE"
	ERROR_NO_MORE_FILES, "ERROR_NO_MORE_FILES"
	ERROR_WRITE_PROTECT, "ERROR_WRITE_PROTECT"
	ERROR_BAD_UNIT, "ERROR_BAD_UNIT"
	ERROR_NOT_READY, "ERROR_NOT_READY"
	ERROR_BAD_COMMAND, "ERROR_BAD_COMMAND"
	ERROR_CRC, "ERROR_CRC"
	ERROR_BAD_LENGTH, "ERROR_BAD_LENGTH"
	ERROR_SEEK, "ERROR_SEEK"
	ERROR_NOT_DOS_DISK, "ERROR_NOT_DOS_DISK"
	ERROR_SECTOR_NOT_FOUND, "ERROR_SECTOR_NOT_FOUND"
	ERROR_OUT_OF_PAPER, "ERROR_OUT_OF_PAPER"
	ERROR_WRITE_FAULT, "ERROR_WRITE_FAULT"
	ERROR_READ_FAULT, "ERROR_READ_FAULT"
	ERROR_GEN_FAILURE, "ERROR_GEN_FAILURE"
	ERROR_SHARING_VIOLATION, "ERROR_SHARING_VIOLATION"
	ERROR_LOCK_VIOLATION, "ERROR_LOCK_VIOLATION"
	ERROR_WRONG_DISK, "ERROR_WRONG_DISK"
	ERROR_SHARING_BUFFER_EXCEEDED, "ERROR_SHARING_BUFFER_EXCEEDED"
	ERROR_HANDLE_EOF, "ERROR_HANDLE_EOF"
	ERROR_HANDLE_DISK_FULL, "ERROR_HANDLE_DISK_FULL"
	ERROR_NOT_SUPPORTED, "ERROR_NOT_SUPPORTED"
	ERROR_REM_NOT_LIST, "ERROR_REM_NOT_LIST"
	ERROR_DUP_NAME, "ERROR_DUP_NAME"
	ERROR_BAD_NETPATH, "ERROR_BAD_NETPATH"
	ERROR_NETWORK_BUSY, "ERROR_NETWORK_BUSY"
	ERROR_DEV_NOT_EXIST, "ERROR_DEV_NOT_EXIST"
	ERROR_TOO_MANY_CMDS, "ERROR_TOO_MANY_CMDS"
	ERROR_ADAP_HDW_ERR, "ERROR_ADAP_HDW_ERR"
	ERROR_BAD_NET_RESP, "ERROR_BAD_NET_RESP"
	ERROR_UNEXP_NET_ERR, "ERROR_UNEXP_NET_ERR"
	ERROR_BAD_REM_ADAP, "ERROR_BAD_REM_ADAP"
	ERROR_PRINTQ_FULL, "ERROR_PRINTQ_FULL"
	ERROR_NO_SPOOL_SPACE, "ERROR_NO_SPOOL_SPACE"
	ERROR_PRINT_CANCELLED, "ERROR_PRINT_CANCELLED"
	ERROR_NETNAME_DELETED, "ERROR_NETNAME_DELETED"
	ERROR_NETWORK_ACCESS_DENIED, "ERROR_NETWORK_ACCESS_DENIED"
	ERROR_BAD_DEV_TYPE, "ERROR_BAD_DEV_TYPE"
	ERROR_BAD_NET_NAME, "ERROR_BAD_NET_NAME"
	ERROR_TOO_MANY_NAMES, "ERROR_TOO_MANY_NAMES"
	ERROR_TOO_MANY_SESS, "ERROR_TOO_MANY_SESS"
	ERROR_SHARING_PAUSED, "ERROR_SHARING_PAUSED"
	ERROR_REQ_NOT_ACCEP, "ERROR_REQ_NOT_ACCEP"
	ERROR_REDIR_PAUSED, "ERROR_REDIR_PAUSED"
	ERROR_FILE_EXISTS, "ERROR_FILE_EXISTS"
	ERROR_CANNOT_MAKE, "ERROR_CANNOT_MAKE"
	ERROR_FAIL_I24, "ERROR_FAIL_I24"
	ERROR_OUT_OF_STRUCTURES, "ERROR_OUT_OF_STRUCTURES"
	ERROR_ALREADY_ASSIGNED, "ERROR_ALREADY_ASSIGNED"
	ERROR_INVALID_PASSWORD, "ERROR_INVALID_PASSWORD"
	ERROR_INVALID_PARAMETER, "ERROR_INVALID_PARAMETER"
	ERROR_NET_WRITE_FAULT, "ERROR_NET_WRITE_FAULT"
	ERROR_NO_PROC_SLOTS, "ERROR_NO_PROC_SLOTS"
	ERROR_TOO_MANY_SEMAPHORES, "ERROR_TOO_MANY_SEMAPHORES"
	ERROR_EXCL_SEM_ALREADY_OWNED, "ERROR_EXCL_SEM_ALREADY_OWNED"
	ERROR_SEM_IS_SET, "ERROR_SEM_IS_SET"
	ERROR_TOO_MANY_SEM_REQUESTS, "ERROR_TOO_MANY_SEM_REQUESTS"
	ERROR_INVALID_AT_INTERRUPT_TIME, "ERROR_INVALID_AT_INTERRUPT_TIME"
	ERROR_SEM_OWNER_DIED, "ERROR_SEM_OWNER_DIED"
	ERROR_SEM_USER_LIMIT, "ERROR_SEM_USER_LIMIT"
	ERROR_DISK_CHANGE, "ERROR_DISK_CHANGE"
	ERROR_DRIVE_LOCKED, "ERROR_DRIVE_LOCKED"
	ERROR_BROKEN_PIPE, "ERROR_BROKEN_PIPE"
	ERROR_OPEN_FAILED, "ERROR_OPEN_FAILED"
	ERROR_BUFFER_OVERFLOW, "ERROR_BUFFER_OVERFLOW"
	ERROR_DISK_FULL, "ERROR_DISK_FULL"
	ERROR_NO_MORE_SEARCH_HANDLES, "ERROR_NO_MORE_SEARCH_HANDLES"
	ERROR_INVALID_TARGET_HANDLE, "ERROR_INVALID_TARGET_HANDLE"
	ERROR_INVALID_CATEGORY, "ERROR_INVALID_CATEGORY"
	ERROR_INVALID_VERIFY_SWITCH, "ERROR_INVALID_VERIFY_SWITCH"
	ERROR_BAD_DRIVER_LEVEL, "ERROR_BAD_DRIVER_LEVEL"
	ERROR_CALL_NOT_IMPLEMENTED, "ERROR_CALL_NOT_IMPLEMENTED"
	ERROR_SEM_TIMEOUT, "ERROR_SEM_TIMEOUT"
	ERROR_INSUFFICIENT_BUFFER, "ERROR_INSUFFICIENT_BUFFER"
	ERROR_INVALID_NAME, "ERROR_INVALID_NAME"
	ERROR_INVALID_LEVEL, "ERROR_INVALID_LEVEL"
	ERROR_NO_VOLUME_LABEL, "ERROR_NO_VOLUME_LABEL"
	ERROR_MOD_NOT_FOUND, "ERROR_MOD_NOT_FOUND"
	ERROR_PROC_NOT_FOUND, "ERROR_PROC_NOT_FOUND"
	ERROR_WAIT_NO_CHILDREN, "ERROR_WAIT_NO_CHILDREN"
	ERROR_CHILD_NOT_COMPLETE, "ERROR_CHILD_NOT_COMPLETE"
	ERROR_DIRECT_ACCESS_HANDLE, "ERROR_DIRECT_ACCESS_HANDLE"
	ERROR_NEGATIVE_SEEK, "ERROR_NEGATIVE_SEEK"
	ERROR_SEEK_ON_DEVICE, "ERROR_SEEK_ON_DEVICE"
	ERROR_IS_JOIN_TARGET, "ERROR_IS_JOIN_TARGET"
	ERROR_IS_JOINED, "ERROR_IS_JOINED"
	ERROR_IS_SUBSTED, "ERROR_IS_SUBSTED"
	ERROR_NOT_JOINED, "ERROR_NOT_JOINED"
	ERROR_NOT_SUBSTED, "ERROR_NOT_SUBSTED"
	ERROR_JOIN_TO_JOIN, "ERROR_JOIN_TO_JOIN"
	ERROR_SUBST_TO_SUBST, "ERROR_SUBST_TO_SUBST"
	ERROR_JOIN_TO_SUBST, "ERROR_JOIN_TO_SUBST"
	ERROR_SUBST_TO_JOIN, "ERROR_SUBST_TO_JOIN"
	ERROR_BUSY_DRIVE, "ERROR_BUSY_DRIVE"
	ERROR_SAME_DRIVE, "ERROR_SAME_DRIVE"
	ERROR_DIR_NOT_ROOT, "ERROR_DIR_NOT_ROOT"
	ERROR_DIR_NOT_EMPTY, "ERROR_DIR_NOT_EMPTY"
	ERROR_IS_SUBST_PATH, "ERROR_IS_SUBST_PATH"
	ERROR_IS_JOIN_PATH, "ERROR_IS_JOIN_PATH"
	ERROR_PATH_BUSY, "ERROR_PATH_BUSY"
	ERROR_IS_SUBST_TARGET, "ERROR_IS_SUBST_TARGET"
	ERROR_SYSTEM_TRACE, "ERROR_SYSTEM_TRACE"
	ERROR_INVALID_EVENT_COUNT, "ERROR_INVALID_EVENT_COUNT"
	ERROR_TOO_MANY_MUXWAITERS, "ERROR_TOO_MANY_MUXWAITERS"
	ERROR_INVALID_LIST_FORMAT, "ERROR_INVALID_LIST_FORMAT"
	ERROR_LABEL_TOO_LONG, "ERROR_LABEL_TOO_LONG"
	ERROR_TOO_MANY_TCBS, "ERROR_TOO_MANY_TCBS"
	ERROR_SIGNAL_REFUSED, "ERROR_SIGNAL_REFUSED"
	ERROR_DISCARDED, "ERROR_DISCARDED"
	ERROR_NOT_LOCKED, "ERROR_NOT_LOCKED"
	ERROR_BAD_THREADID_ADDR, "ERROR_BAD_THREADID_ADDR"
	ERROR_BAD_ARGUMENTS, "ERROR_BAD_ARGUMENTS"
	ERROR_BAD_PATHNAME, "ERROR_BAD_PATHNAME"
	ERROR_SIGNAL_PENDING, "ERROR_SIGNAL_PENDING"
	ERROR_MAX_THRDS_REACHED, "ERROR_MAX_THRDS_REACHED"
	ERROR_LOCK_FAILED, "ERROR_LOCK_FAILED"
	ERROR_BUSY, "ERROR_BUSY"
	ERROR_CANCEL_VIOLATION, "ERROR_CANCEL_VIOLATION"
	ERROR_ATOMIC_LOCKS_NOT_SUPPORTED, "ERROR_ATOMIC_LOCKS_NOT_SUPPORTED"
	ERROR_INVALID_SEGMENT_NUMBER, "ERROR_INVALID_SEGMENT_NUMBER"
	ERROR_INVALID_ORDINAL, "ERROR_INVALID_ORDINAL"
	ERROR_ALREADY_EXISTS, "ERROR_ALREADY_EXISTS"
	ERROR_INVALID_FLAG_NUMBER, "ERROR_INVALID_FLAG_NUMBER"
	ERROR_SEM_NOT_FOUND, "ERROR_SEM_NOT_FOUND"
	ERROR_INVALID_STARTING_CODESEG, "ERROR_INVALID_STARTING_CODESEG"
	ERROR_INVALID_STACKSEG, "ERROR_INVALID_STACKSEG"
	ERROR_INVALID_MODULETYPE, "ERROR_INVALID_MODULETYPE"
	ERROR_INVALID_EXE_SIGNATURE, "ERROR_INVALID_EXE_SIGNATURE"
	ERROR_EXE_MARKED_INVALID, "ERROR_EXE_MARKED_INVALID"
	ERROR_BAD_EXE_FORMAT, "ERROR_BAD_EXE_FORMAT"
	ERROR_ITERATED_DATA_EXCEEDS_64k, "ERROR_ITERATED_DATA_EXCEEDS_64k"
	ERROR_INVALID_MINALLOCSIZE, "ERROR_INVALID_MINALLOCSIZE"
	ERROR_DYNLINK_FROM_INVALID_RING, "ERROR_DYNLINK_FROM_INVALID_RING"
	ERROR_IOPL_NOT_ENABLED, "ERROR_IOPL_NOT_ENABLED"
	ERROR_INVALID_SEGDPL, "ERROR_INVALID_SEGDPL"
	ERROR_AUTODATASEG_EXCEEDS_64k, "ERROR_AUTODATASEG_EXCEEDS_64k"
	ERROR_RING2SEG_MUST_BE_MOVABLE, "ERROR_RING2SEG_MUST_BE_MOVABLE"
	ERROR_RELOC_CHAIN_XEEDS_SEGLIM, "ERROR_RELOC_CHAIN_XEEDS_SEGLIM"
	ERROR_INFLOOP_IN_RELOC_CHAIN, "ERROR_INFLOOP_IN_RELOC_CHAIN"
	ERROR_ENVVAR_NOT_FOUND, "ERROR_ENVVAR_NOT_FOUND"
	ERROR_NO_SIGNAL_SENT, "ERROR_NO_SIGNAL_SENT"
	ERROR_FILENAME_EXCED_RANGE, "ERROR_FILENAME_EXCED_RANGE"
	ERROR_RING2_STACK_IN_USE, "ERROR_RING2_STACK_IN_USE"
	ERROR_META_EXPANSION_TOO_LONG, "ERROR_META_EXPANSION_TOO_LONG"
	ERROR_INVALID_SIGNAL_NUMBER, "ERROR_INVALID_SIGNAL_NUMBER"
	ERROR_THREAD_1_INACTIVE, "ERROR_THREAD_1_INACTIVE"
	ERROR_LOCKED, "ERROR_LOCKED"
	ERROR_TOO_MANY_MODULES, "ERROR_TOO_MANY_MODULES"
	ERROR_NESTING_NOT_ALLOWED, "ERROR_NESTING_NOT_ALLOWED"
	ERROR_BAD_PIPE, "ERROR_BAD_PIPE"
	ERROR_PIPE_BUSY, "ERROR_PIPE_BUSY"
	ERROR_NO_DATA, "ERROR_NO_DATA"
	ERROR_PIPE_NOT_CONNECTED, "ERROR_PIPE_NOT_CONNECTED"
	ERROR_MORE_DATA, "ERROR_MORE_DATA"
	ERROR_VC_DISCONNECTED, "ERROR_VC_DISCONNECTED"
	ERROR_INVALID_EA_NAME, "ERROR_INVALID_EA_NAME"
	ERROR_EA_LIST_INCONSISTENT, "ERROR_EA_LIST_INCONSISTENT"
	ERROR_NO_MORE_ITEMS, "ERROR_NO_MORE_ITEMS"
	ERROR_CANNOT_COPY, "ERROR_CANNOT_COPY"
	ERROR_DIRECTORY, "ERROR_DIRECTORY"
	ERROR_EAS_DIDNT_FIT, "ERROR_EAS_DIDNT_FIT"
	ERROR_EA_FILE_CORRUPT, "ERROR_EA_FILE_CORRUPT"
	ERROR_EA_TABLE_FULL, "ERROR_EA_TABLE_FULL"
	ERROR_INVALID_EA_HANDLE, "ERROR_INVALID_EA_HANDLE"
	ERROR_EAS_NOT_SUPPORTED, "ERROR_EAS_NOT_SUPPORTED"
	ERROR_NOT_OWNER, "ERROR_NOT_OWNER"
	ERROR_TOO_MANY_POSTS, "ERROR_TOO_MANY_POSTS"
	ERROR_MR_MID_NOT_FOUND, "ERROR_MR_MID_NOT_FOUND"
	ERROR_INVALID_ADDRESS, "ERROR_INVALID_ADDRESS"
	ERROR_ARITHMETIC_OVERFLOW, "ERROR_ARITHMETIC_OVERFLOW"
	ERROR_PIPE_CONNECTED, "ERROR_PIPE_CONNECTED"
	ERROR_PIPE_LISTENING, "ERROR_PIPE_LISTENING"
	ERROR_EA_ACCESS_DENIED, "ERROR_EA_ACCESS_DENIED"
	ERROR_OPERATION_ABORTED, "ERROR_OPERATION_ABORTED"
	ERROR_IO_INCOMPLETE, "ERROR_IO_INCOMPLETE"
	ERROR_IO_PENDING, "ERROR_IO_PENDING"
	ERROR_NOACCESS, "ERROR_NOACCESS"
	ERROR_SWAPERROR, "ERROR_SWAPERROR"
	ERROR_STACK_OVERFLOW, "ERROR_STACK_OVERFLOW"
	ERROR_INVALID_MESSAGE, "ERROR_INVALID_MESSAGE"
	ERROR_CAN_NOT_COMPLETE, "ERROR_CAN_NOT_COMPLETE"
	ERROR_INVALID_FLAGS, "ERROR_INVALID_FLAGS"
	ERROR_UNRECOGNIZED_VOLUME, "ERROR_UNRECOGNIZED_VOLUME"
	ERROR_FILE_INVALID, "ERROR_FILE_INVALID"
	ERROR_FULLSCREEN_MODE, "ERROR_FULLSCREEN_MODE"
	ERROR_NO_TOKEN, "ERROR_NO_TOKEN"
	ERROR_BADDB, "ERROR_BADDB"
	ERROR_BADKEY, "ERROR_BADKEY"
	ERROR_CANTOPEN, "ERROR_CANTOPEN"
	ERROR_CANTREAD, "ERROR_CANTREAD"
	ERROR_CANTWRITE, "ERROR_CANTWRITE"
	ERROR_REGISTRY_RECOVERED, "ERROR_REGISTRY_RECOVERED"
	ERROR_REGISTRY_CORRUPT, "ERROR_REGISTRY_CORRUPT"
	ERROR_REGISTRY_IO_FAILED, "ERROR_REGISTRY_IO_FAILED"
	ERROR_NOT_REGISTRY_FILE, "ERROR_NOT_REGISTRY_FILE"
	ERROR_KEY_DELETED, "ERROR_KEY_DELETED"
	ERROR_NO_LOG_SPACE, "ERROR_NO_LOG_SPACE"
	ERROR_KEY_HAS_CHILDREN, "ERROR_KEY_HAS_CHILDREN"
	ERROR_CHILD_MUST_BE_VOLATILE, "ERROR_CHILD_MUST_BE_VOLATILE"
	ERROR_NOTIFY_ENUM_DIR, "ERROR_NOTIFY_ENUM_DIR"
	ERROR_DEPENDENT_SERVICES_RUNNING, "ERROR_DEPENDENT_SERVICES_RUNNING"
	ERROR_INVALID_SERVICE_CONTROL, "ERROR_INVALID_SERVICE_CONTROL"
	ERROR_SERVICE_REQUEST_TIMEOUT, "ERROR_SERVICE_REQUEST_TIMEOUT"
	ERROR_SERVICE_NO_THREAD, "ERROR_SERVICE_NO_THREAD"
	ERROR_SERVICE_DATABASE_LOCKED, "ERROR_SERVICE_DATABASE_LOCKED"
	ERROR_SERVICE_ALREADY_RUNNING, "ERROR_SERVICE_ALREADY_RUNNING"
	ERROR_INVALID_SERVICE_ACCOUNT, "ERROR_INVALID_SERVICE_ACCOUNT"
	ERROR_SERVICE_DISABLED, "ERROR_SERVICE_DISABLED"
	ERROR_CIRCULAR_DEPENDENCY, "ERROR_CIRCULAR_DEPENDENCY"
	ERROR_SERVICE_DOES_NOT_EXIST, "ERROR_SERVICE_DOES_NOT_EXIST"
	ERROR_SERVICE_CANNOT_ACCEPT_CTRL, "ERROR_SERVICE_CANNOT_ACCEPT_CTRL"
	ERROR_SERVICE_NOT_ACTIVE, "ERROR_SERVICE_NOT_ACTIVE"
	ERROR_FAILED_SERVICE_CONTROLLER_CONNECT, "ERROR_FAILED_SERVICE_CONTROLLER_CONNECT"
	ERROR_EXCEPTION_IN_SERVICE, "ERROR_EXCEPTION_IN_SERVICE"
	ERROR_DATABASE_DOES_NOT_EXIST, "ERROR_DATABASE_DOES_NOT_EXIST"
	ERROR_SERVICE_SPECIFIC_ERROR, "ERROR_SERVICE_SPECIFIC_ERROR"
	ERROR_PROCESS_ABORTED, "ERROR_PROCESS_ABORTED"
	ERROR_SERVICE_DEPENDENCY_FAIL, "ERROR_SERVICE_DEPENDENCY_FAIL"
	ERROR_SERVICE_LOGON_FAILED, "ERROR_SERVICE_LOGON_FAILED"
	ERROR_SERVICE_START_HANG, "ERROR_SERVICE_START_HANG"
	ERROR_INVALID_SERVICE_LOCK, "ERROR_INVALID_SERVICE_LOCK"
	ERROR_SERVICE_MARKED_FOR_DELETE, "ERROR_SERVICE_MARKED_FOR_DELETE"
	ERROR_SERVICE_EXISTS, "ERROR_SERVICE_EXISTS"
	ERROR_ALREADY_RUNNING_LKG, "ERROR_ALREADY_RUNNING_LKG"
	ERROR_SERVICE_DEPENDENCY_DELETED, "ERROR_SERVICE_DEPENDENCY_DELETED"
	ERROR_BOOT_ALREADY_ACCEPTED, "ERROR_BOOT_ALREADY_ACCEPTED"
	ERROR_SERVICE_NEVER_STARTED, "ERROR_SERVICE_NEVER_STARTED"
	ERROR_DUPLICATE_SERVICE_NAME, "ERROR_DUPLICATE_SERVICE_NAME"
	ERROR_END_OF_MEDIA, "ERROR_END_OF_MEDIA"
	ERROR_FILEMARK_DETECTED, "ERROR_FILEMARK_DETECTED"
	ERROR_BEGINNING_OF_MEDIA, "ERROR_BEGINNING_OF_MEDIA"
	ERROR_SETMARK_DETECTED, "ERROR_SETMARK_DETECTED"
	ERROR_NO_DATA_DETECTED, "ERROR_NO_DATA_DETECTED"
	ERROR_PARTITION_FAILURE, "ERROR_PARTITION_FAILURE"
	ERROR_INVALID_BLOCK_LENGTH, "ERROR_INVALID_BLOCK_LENGTH"
	ERROR_DEVICE_NOT_PARTITIONED, "ERROR_DEVICE_NOT_PARTITIONED"
	ERROR_UNABLE_TO_LOCK_MEDIA, "ERROR_UNABLE_TO_LOCK_MEDIA"
	ERROR_UNABLE_TO_UNLOAD_MEDIA, "ERROR_UNABLE_TO_UNLOAD_MEDIA"
	ERROR_MEDIA_CHANGED, "ERROR_MEDIA_CHANGED"
	ERROR_BUS_RESET, "ERROR_BUS_RESET"
	ERROR_NO_MEDIA_IN_DRIVE, "ERROR_NO_MEDIA_IN_DRIVE"
	ERROR_NO_UNICODE_TRANSLATION, "ERROR_NO_UNICODE_TRANSLATION"
	ERROR_DLL_INIT_FAILED, "ERROR_DLL_INIT_FAILED"
	ERROR_SHUTDOWN_IN_PROGRESS, "ERROR_SHUTDOWN_IN_PROGRESS"
	ERROR_NO_SHUTDOWN_IN_PROGRESS, "ERROR_NO_SHUTDOWN_IN_PROGRESS"
	ERROR_IO_DEVICE, "ERROR_IO_DEVICE"
	ERROR_SERIAL_NO_DEVICE, "ERROR_SERIAL_NO_DEVICE"
	ERROR_IRQ_BUSY, "ERROR_IRQ_BUSY"
	ERROR_MORE_WRITES, "ERROR_MORE_WRITES"
	ERROR_COUNTER_TIMEOUT, "ERROR_COUNTER_TIMEOUT"
	ERROR_FLOPPY_ID_MARK_NOT_FOUND, "ERROR_FLOPPY_ID_MARK_NOT_FOUND"
	ERROR_FLOPPY_WRONG_CYLINDER, "ERROR_FLOPPY_WRONG_CYLINDER"
	ERROR_FLOPPY_UNKNOWN_ERROR, "ERROR_FLOPPY_UNKNOWN_ERROR"
	ERROR_FLOPPY_BAD_REGISTERS, "ERROR_FLOPPY_BAD_REGISTERS"
	ERROR_DISK_RECALIBRATE_FAILED, "ERROR_DISK_RECALIBRATE_FAILED"
	ERROR_DISK_OPERATION_FAILED, "ERROR_DISK_OPERATION_FAILED"
	ERROR_DISK_RESET_FAILED, "ERROR_DISK_RESET_FAILED"
	ERROR_EOM_OVERFLOW, "ERROR_EOM_OVERFLOW"
	ERROR_NOT_ENOUGH_SERVER_MEMORY, "ERROR_NOT_ENOUGH_SERVER_MEMORY"
	ERROR_POSSIBLE_DEADLOCK, "ERROR_POSSIBLE_DEADLOCK"
	ERROR_MAPPED_ALIGNMENT, "ERROR_MAPPED_ALIGNMENT"
	ERROR_BAD_USERNAME, "ERROR_BAD_USERNAME"
	ERROR_NOT_CONNECTED, "ERROR_NOT_CONNECTED"
	ERROR_OPEN_FILES, "ERROR_OPEN_FILES"
	ERROR_DEVICE_IN_USE, "ERROR_DEVICE_IN_USE"
	ERROR_BAD_DEVICE, "ERROR_BAD_DEVICE"
	ERROR_CONNECTION_UNAVAIL, "ERROR_CONNECTION_UNAVAIL"
	ERROR_DEVICE_ALREADY_REMEMBERED, "ERROR_DEVICE_ALREADY_REMEMBERED"
	ERROR_NO_NET_OR_BAD_PATH, "ERROR_NO_NET_OR_BAD_PATH"
	ERROR_BAD_PROVIDER, "ERROR_BAD_PROVIDER"
	ERROR_CANNOT_OPEN_PROFILE, "ERROR_CANNOT_OPEN_PROFILE"
	ERROR_BAD_PROFILE, "ERROR_BAD_PROFILE"
	ERROR_NOT_CONTAINER, "ERROR_NOT_CONTAINER"
	ERROR_EXTENDED_ERROR, "ERROR_EXTENDED_ERROR"
	ERROR_INVALID_GROUPNAME, "ERROR_INVALID_GROUPNAME"
	ERROR_INVALID_COMPUTERNAME, "ERROR_INVALID_COMPUTERNAME"
	ERROR_INVALID_EVENTNAME, "ERROR_INVALID_EVENTNAME"
	ERROR_INVALID_DOMAINNAME, "ERROR_INVALID_DOMAINNAME"
	ERROR_INVALID_SERVICENAME, "ERROR_INVALID_SERVICENAME"
	ERROR_INVALID_NETNAME, "ERROR_INVALID_NETNAME"
	ERROR_INVALID_SHARENAME, "ERROR_INVALID_SHARENAME"
	ERROR_INVALID_PASSWORDNAME, "ERROR_INVALID_PASSWORDNAME"
	ERROR_INVALID_MESSAGENAME, "ERROR_INVALID_MESSAGENAME"
	ERROR_INVALID_MESSAGEDEST, "ERROR_INVALID_MESSAGEDEST"
	ERROR_SESSION_CREDENTIAL_CONFLICT, "ERROR_SESSION_CREDENTIAL_CONFLICT"
	ERROR_REMOTE_SESSION_LIMIT_EXCEEDED, "ERROR_REMOTE_SESSION_LIMIT_EXCEEDED"
	ERROR_DUP_DOMAINNAME, "ERROR_DUP_DOMAINNAME"
	ERROR_NO_NETWORK, "ERROR_NO_NETWORK"
	ERROR_NOT_ALL_ASSIGNED, "ERROR_NOT_ALL_ASSIGNED"
	ERROR_SOME_NOT_MAPPED, "ERROR_SOME_NOT_MAPPED"
	ERROR_NO_QUOTAS_FOR_ACCOUNT, "ERROR_NO_QUOTAS_FOR_ACCOUNT"
	ERROR_LOCAL_USER_SESSION_KEY, "ERROR_LOCAL_USER_SESSION_KEY"
	ERROR_NULL_LM_PASSWORD, "ERROR_NULL_LM_PASSWORD"
	ERROR_UNKNOWN_REVISION, "ERROR_UNKNOWN_REVISION"
	ERROR_REVISION_MISMATCH, "ERROR_REVISION_MISMATCH"
	ERROR_INVALID_OWNER, "ERROR_INVALID_OWNER"
	ERROR_INVALID_PRIMARY_GROUP, "ERROR_INVALID_PRIMARY_GROUP"
	ERROR_NO_IMPERSONATION_TOKEN, "ERROR_NO_IMPERSONATION_TOKEN"
	ERROR_CANT_DISABLE_MANDATORY, "ERROR_CANT_DISABLE_MANDATORY"
	ERROR_NO_LOGON_SERVERS, "ERROR_NO_LOGON_SERVERS"
	ERROR_NO_SUCH_LOGON_SESSION, "ERROR_NO_SUCH_LOGON_SESSION"
	ERROR_NO_SUCH_PRIVILEGE, "ERROR_NO_SUCH_PRIVILEGE"
	ERROR_PRIVILEGE_NOT_HELD, "ERROR_PRIVILEGE_NOT_HELD"
	ERROR_INVALID_ACCOUNT_NAME, "ERROR_INVALID_ACCOUNT_NAME"
	ERROR_USER_EXISTS, "ERROR_USER_EXISTS"
	ERROR_NO_SUCH_USER, "ERROR_NO_SUCH_USER"
	ERROR_GROUP_EXISTS, "ERROR_GROUP_EXISTS"
	ERROR_NO_SUCH_GROUP, "ERROR_NO_SUCH_GROUP"
	ERROR_MEMBER_IN_GROUP, "ERROR_MEMBER_IN_GROUP"
	ERROR_MEMBER_NOT_IN_GROUP, "ERROR_MEMBER_NOT_IN_GROUP"
	ERROR_LAST_ADMIN, "ERROR_LAST_ADMIN"
	ERROR_WRONG_PASSWORD, "ERROR_WRONG_PASSWORD"
	ERROR_ILL_FORMED_PASSWORD, "ERROR_ILL_FORMED_PASSWORD"
	ERROR_PASSWORD_RESTRICTION, "ERROR_PASSWORD_RESTRICTION"
	ERROR_LOGON_FAILURE, "ERROR_LOGON_FAILURE"
	ERROR_ACCOUNT_RESTRICTION, "ERROR_ACCOUNT_RESTRICTION"
	ERROR_INVALID_LOGON_HOURS, "ERROR_INVALID_LOGON_HOURS"
	ERROR_INVALID_WORKSTATION, "ERROR_INVALID_WORKSTATION"
	ERROR_PASSWORD_EXPIRED, "ERROR_PASSWORD_EXPIRED"
	ERROR_ACCOUNT_DISABLED, "ERROR_ACCOUNT_DISABLED"
	ERROR_NONE_MAPPED, "ERROR_NONE_MAPPED"
	ERROR_TOO_MANY_LUIDS_REQUESTED, "ERROR_TOO_MANY_LUIDS_REQUESTED"
	ERROR_LUIDS_EXHAUSTED, "ERROR_LUIDS_EXHAUSTED"
	ERROR_INVALID_SUB_AUTHORITY, "ERROR_INVALID_SUB_AUTHORITY"
	ERROR_INVALID_ACL, "ERROR_INVALID_ACL"
	ERROR_INVALID_SID, "ERROR_INVALID_SID"
	ERROR_INVALID_SECURITY_DESCR, "ERROR_INVALID_SECURITY_DESCR"
	ERROR_BAD_INHERITANCE_ACL, "ERROR_BAD_INHERITANCE_ACL"
	ERROR_SERVER_DISABLED, "ERROR_SERVER_DISABLED"
	ERROR_SERVER_NOT_DISABLED, "ERROR_SERVER_NOT_DISABLED"
	ERROR_INVALID_ID_AUTHORITY, "ERROR_INVALID_ID_AUTHORITY"
	ERROR_ALLOTTED_SPACE_EXCEEDED, "ERROR_ALLOTTED_SPACE_EXCEEDED"
	ERROR_INVALID_GROUP_ATTRIBUTES, "ERROR_INVALID_GROUP_ATTRIBUTES"
	ERROR_BAD_IMPERSONATION_LEVEL, "ERROR_BAD_IMPERSONATION_LEVEL"
	ERROR_CANT_OPEN_ANONYMOUS, "ERROR_CANT_OPEN_ANONYMOUS"
	ERROR_BAD_VALIDATION_CLASS, "ERROR_BAD_VALIDATION_CLASS"
	ERROR_BAD_TOKEN_TYPE, "ERROR_BAD_TOKEN_TYPE"
	ERROR_NO_SECURITY_ON_OBJECT, "ERROR_NO_SECURITY_ON_OBJECT"
	ERROR_CANT_ACCESS_DOMAIN_INFO, "ERROR_CANT_ACCESS_DOMAIN_INFO"
	ERROR_INVALID_SERVER_STATE, "ERROR_INVALID_SERVER_STATE"
	ERROR_INVALID_DOMAIN_STATE, "ERROR_INVALID_DOMAIN_STATE"
	ERROR_INVALID_DOMAIN_ROLE, "ERROR_INVALID_DOMAIN_ROLE"
	ERROR_NO_SUCH_DOMAIN, "ERROR_NO_SUCH_DOMAIN"
	ERROR_DOMAIN_EXISTS, "ERROR_DOMAIN_EXISTS"
	ERROR_DOMAIN_LIMIT_EXCEEDED, "ERROR_DOMAIN_LIMIT_EXCEEDED"
	ERROR_INTERNAL_ERROR, "ERROR_INTERNAL_ERROR"
	ERROR_GENERIC_NOT_MAPPED, "ERROR_GENERIC_NOT_MAPPED"
	ERROR_BAD_DESCRIPTOR_FORMAT, "ERROR_BAD_DESCRIPTOR_FORMAT"
	ERROR_NOT_LOGON_PROCESS, "ERROR_NOT_LOGON_PROCESS"
	ERROR_LOGON_SESSION_EXISTS, "ERROR_LOGON_SESSION_EXISTS"
	ERROR_NO_SUCH_PACKAGE, "ERROR_NO_SUCH_PACKAGE"
	ERROR_BAD_LOGON_SESSION_STATE, "ERROR_BAD_LOGON_SESSION_STATE"
	ERROR_LOGON_SESSION_COLLISION, "ERROR_LOGON_SESSION_COLLISION"
	ERROR_INVALID_LOGON_TYPE, "ERROR_INVALID_LOGON_TYPE"
	ERROR_CANNOT_IMPERSONATE, "ERROR_CANNOT_IMPERSONATE"
	ERROR_RXACT_INVALID_STATE, "ERROR_RXACT_INVALID_STATE"
	ERROR_RXACT_COMMIT_FAILURE, "ERROR_RXACT_COMMIT_FAILURE"
	ERROR_SPECIAL_ACCOUNT, "ERROR_SPECIAL_ACCOUNT"
	ERROR_SPECIAL_GROUP, "ERROR_SPECIAL_GROUP"
	ERROR_SPECIAL_USER, "ERROR_SPECIAL_USER"
	ERROR_MEMBERS_PRIMARY_GROUP, "ERROR_MEMBERS_PRIMARY_GROUP"
	ERROR_TOKEN_ALREADY_IN_USE, "ERROR_TOKEN_ALREADY_IN_USE"
	ERROR_NO_SUCH_ALIAS, "ERROR_NO_SUCH_ALIAS"
	ERROR_MEMBER_NOT_IN_ALIAS, "ERROR_MEMBER_NOT_IN_ALIAS"
	ERROR_MEMBER_IN_ALIAS, "ERROR_MEMBER_IN_ALIAS"
	ERROR_ALIAS_EXISTS, "ERROR_ALIAS_EXISTS"
	ERROR_LOGON_NOT_GRANTED, "ERROR_LOGON_NOT_GRANTED"
	ERROR_TOO_MANY_SECRETS, "ERROR_TOO_MANY_SECRETS"
	ERROR_SECRET_TOO_LONG, "ERROR_SECRET_TOO_LONG"
	ERROR_INTERNAL_DB_ERROR, "ERROR_INTERNAL_DB_ERROR"
	ERROR_TOO_MANY_CONTEXT_IDS, "ERROR_TOO_MANY_CONTEXT_IDS"
	ERROR_LOGON_TYPE_NOT_GRANTED, "ERROR_LOGON_TYPE_NOT_GRANTED"
	ERROR_NT_CROSS_ENCRYPTION_REQUIRED, "ERROR_NT_CROSS_ENCRYPTION_REQUIRED"
	ERROR_NO_SUCH_MEMBER, "ERROR_NO_SUCH_MEMBER"
	ERROR_TOO_MANY_SIDS, "ERROR_TOO_MANY_SIDS"
	ERROR_LM_CROSS_ENCRYPTION_REQUIRED, "ERROR_LM_CROSS_ENCRYPTION_REQUIRED"
	ERROR_NO_INHERITANCE, "ERROR_NO_INHERITANCE"
	ERROR_INVALID_MEMBER, "ERROR_INVALID_MEMBER"
	ERROR_FILE_CORRUPT, "ERROR_FILE_CORRUPT"
	ERROR_DISK_CORRUPT, "ERROR_DISK_CORRUPT"
	ERROR_NO_USER_SESSION_KEY, "ERROR_NO_USER_SESSION_KEY"
  end

code	dbw_err - decode error code

  func	dbw_err
	cod : nat
	()  : * char
  is	ent : * dbwTerr = dbwAerr
	while (ent->Ptxt)
	   if cod eq ent->Vcod
	   .. reply ent->Ptxt
	   ++ent
	end
	reply "Unknown error"
  end
code	db_opn - open process for read/write

  func	db_opn
	acc : * dbTacc
	nam : * char
	pid : long
	wri : int
  is	mod : int = PROCESS_VM_READ
	mod |= PROCESS_VM_WRITE|PROCESS_VM_OPERATION if wri
	pid = GetCurrentProcessId() if !nam && !pid
	db_clo (acc)
	acc->Hprc = OpenProcess (mod, 0, pid)
	reply that ne
  end

code	db_clo - close process

  func	db_clo
	acc : * dbTacc
  is	fine if !acc->Hprc
	CloseHandle (acc->Hprc)
	acc->Hprc = 0
	fine
  end

code	db_rea - read process memory

  func	db_rea
	acc : * dbTacc
	rem : * void
	loc : * void
	siz : size
  is	ReadProcessMemory (acc->Hprc, rem, loc, siz, <>)
	reply that
  end

code	db_wri - write process memory

  func	db_wri
	acc : * dbTacc
	loc : * void
	rem : * void
	siz : size
  is	WriteProcessMemory (acc->Hprc, rem, loc, siz, <>)
	reply that
  end
end file
;typedef struct _EXCEPTION_POINTERS {
;    PEXCEPTION_RECORD ExceptionRecord;
;    PCONTEXT ContextRecord;

;} EXCEPTION_POINTERS, *PEXCEPTION_POINTERS;
;typedef struct _EXCEPTION_RECORD {
;    /*lint -e18 */  // Don't complain about different definitions
;    DWORD    ExceptionCode;
;    /*lint +e18 */  // Resume checking for different definitions
;    DWORD ExceptionFlags;
;    struct _EXCEPTION_RECORD *ExceptionRecord;
;    PVOID ExceptionAddress;
;    DWORD NumberParameters;
;    DWORD ExceptionInformation[EXCEPTION_MAXIMUM_PARAMETERS];
;    } EXCEPTION_RECORD;
file	dbwin - windows debugging
include	rid:rider
include	<windows.h>

	dbHhan : HHOOK = <>
;	db_ast : (int, WPARAM, LPARAM) LRESULT
;	db_ast : (int, WPARAM, LPARAM) __stdcall int

code	db_ast - debug ast

  func	db_ast
	cod : int
	wrd : WPARAM
	lng : LPARAM
	()  : __stdcall int
  is;	printf ("cod=%d w=%d l=%d\n", cod, wrd, lng)
printf ("db_ast %d\n", cod)
;	reply CallNextHookEx (dbHhan, cod, wrd, lng)
	nothing while 1
fail
  end

code	db_ini - setup debugging

  func	db_ini
  is	tid : LONG = GetCurrentThreadId ()
	dbHhan = SetWindowsHookEx (WH_KEYBOARD, &db_ast, 0, tid)
printf ("db_ini %x\n", tid)
	reply that ne
  end

code	db_exi - exit debugging

  func	db_exi
  is	fine if dbHhan eq
	reply UnhookWindowsHookEx (dbHhan)
  end

