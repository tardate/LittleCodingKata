/*---------------------------------------------------------------------------*/
  '@echo off'
  programNameStr=   "Print specified line number from file"
  copyrightStr=     "Copyright (c) Paul Gallagher 1995"

/*                                ***keywords*** "Version: %v  Date: %d %t"  */
  versionStr=       "Version: 1:4  Date: 5-Apr-95 12:00:34"
/*
;                                 ***keywords*** "%l"
; LOCK STATUS       "/EDMSUB1"
;
;                                 ***keywords*** "%n"
; Filename          "LINE.CMD"
; Platform          OS/2 (REXX)
;
; Authors           Paul Gallagher (paulpg@ibm.net)
;
; Description       Prints a specified line number, along with the
;                   preceeding and following 3 lines of a file that is piped to
;                   the standard input stream
;
; Revision History
;                                 ***revision-history***
; 1 LINE.CMD 26-Feb-95,18:33:00,`PAULG/EDMSUB1' Initial check-in
; 1:1 LINE.CMD 6-Mar-95,21:03:36,`PAULG/EDMSUB1' Added documentation; skips
;      to exit after last line printed
; 1:2 LINE.CMD 9-Mar-95,22:22:04,`PAULG/EDMSUB1' Final for EDM submission
; 1:3 LINE.CMD 27-Mar-95,20:35:56,`PAULG/EDMSUB1' purge input queue
; 1:4 LINE.CMD 5-Apr-95,12:00:34,`PAULG/EDMSUB1' Add my new email address
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
; Start printline procedure
;----------------------------------------------------------------------------*/

                                  /* l1 is the number of the first line to
                                     print; params is the 'target' line */
  l1=params-3
  If (l1<1) Then
    l1=1
                                  /* l2 is the last line to print */
  l2=params+3
                                  /* lc is the line counter */
  lc=0

                                  /* loop until no lines available at standard input */
  Do While LINES() > 0
                                  /* read current line */
    line = LINEIN()
                                  /* increment line counter */
    lc=lc+1
                                  /* if a 'printable' line then do */
    If (lc>=l1) & (lc<=l2) Then Do
                                  /* print line - 'target' line indicated by '*' */
      If (lc=params) Then
        Call CHAROUT ,'*'
      Else
        Call CHAROUT ,' '
      Say lc':' line
                                  /* quick exit if that was the last required line */
      If (lc=l2) Then Do
        Do While LINES() > 0
          Call LINEIN
        End
        signal ExitProc
      End
    End
  End

  Drop l1 l2 lc line

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
  Say " LINES lineno"
  say "    prints the specified 'lineno', and 3 lines before and after"
  Say "*======================================================================*"
Return
