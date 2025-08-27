/*---------------------------------------------------------------------------*/
  '@echo off'
  programNameStr=   "Print the last 'x' lines of a file"
  copyrightStr=     "Copyright (c) Paul Gallagher 1995"

/*                                ***keywords*** "Version: %v  Date: %d %t"  */
  versionStr=       "Version: 1:3  Date: 5-Apr-95 12:00:36"
/*
;                                 ***keywords*** "%l"
; LOCK STATUS       "/EDMSUB1"
;
;                                 ***keywords*** "%n"
; Filename          "TAIL.CMD"
; Platform          OS/2 (REXX)
;
; Authors           Paul Gallagher (paulpg@ibm.net)
;
; Description       Prints the last 'x' lines of a file that is piped to
;                   the standard input stream
;
; Revision History
;                                 ***revision-history***
; 1 TAIL.CMD 26-Feb-95,18:32:44,`PAULG/EDMSUB1' Initial check-in
; 1:1 TAIL.CMD 6-Mar-95,21:34:20,`PAULG/EDMSUB1' Expanded documentation
; 1:2 TAIL.CMD 9-Mar-95,22:22:46,`PAULG/EDMSUB1' Final for EDM submission
; 1:3 TAIL.CMD 5-Apr-95,12:00:36,`PAULG/EDMSUB1' Add my new email address
;                                 ***revision-history***
;----------------------------------------------------------------------------*/

/*-----------------------------------------------------------------------------
; Do initial parse of command line and call help message if required
;----------------------------------------------------------------------------*/
                                  /* get the command line arguments */
Parse Arg params
                                  /* call help routine if required */
If (POS(TRANSLATE(params),"-?"'00'x"/?"'00'x"-HELP"'00'x"/HELP") > 0) | (DATATYPE(params) <> "NUM") Then Do
  Call HelpInfo
  Signal ExitProc
End

/*-----------------------------------------------------------------------------
; Start tail procedure
;----------------------------------------------------------------------------*/

                                  /* lc is our line counter */
  lc=0
                                  /* should print at least 1 line */
  If (params<1) Then
    params=1

                                  /* loop through the input file */
  Do While LINES() > 0
    line = LINEIN()
    lc=lc+1
                                  /* enqueue the new line */
    Queue line
                                  /* if we already have our quota, also discard
                                     a line from the front of the queue */
    If (lc>params) Then
      Pull line
  End

                                  /* clear/print the remaining entries in
                                     the queue */
  Do While QUEUED() > 0
    Parse Pull line
    Say line
  End

  Drop lc line

/*-----------------------------------------------------------------------------
; General exit procedure
;----------------------------------------------------------------------------*/
ExitProc:
  Drop params programNameStr copyrightStr versionStr
Exit
/*-----------------------------------------------------------------------------
; end of main routine
;----------------------------------------------------------------------------*/

/*-----------------------------------------------------------------------------
; routine to display help message
;----------------------------------------------------------------------------*/
HelpInfo: Procedure Expose programNameStr copyrightStr versionStr
  Say
  Say "*======================================================================*"
  Say "   "programNameStr
  Say "   "versionStr
  Say "   "copyrightStr
  Say
  Say " TAIL x"
  say "    prints the last 'x' lines of a file"
  Say "*======================================================================*"
Return
