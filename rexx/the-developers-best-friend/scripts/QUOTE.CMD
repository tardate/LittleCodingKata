/*---------------------------------------------------------------------------*/
  '@echo off'
  programNameStr=   "Quote input for use in C/REXX scripts"
  copyrightStr=     "Copyright (c) Paul Gallagher 1995"

/*                                ***keywords*** "Version: %v  Date: %d %t"  */
  versionStr=       "Version: 1:3  Date: 5-Apr-95 12:00:38"
/*
;                                 ***keywords*** "%l"
; LOCK STATUS       "/EDMSUB1"
;
;                                 ***keywords*** "%n"
; Filename          "QUOTE.CMD"
; Platform          OS/2 (REXX)
;
; Authors           Paul Gallagher (paulpg@ibm.net)
;
; Description       
;
; Revision History
;                                 ***revision-history***
; 1 QUOTE.CMD 26-Feb-95,18:33:14,`PAULG/EDMSUB1' Initial check-in
; 1:1 QUOTE.CMD 6-Mar-95,22:51:18,`PAULG/EDMSUB1' Added documentation; Fixed
;      bug in qchar replacement.
; 1:2 QUOTE.CMD 9-Mar-95,22:24:32,`PAULG/EDMSUB1' final for EDM submission
; 1:3 QUOTE.CMD 5-Apr-95,12:00:38,`PAULG/EDMSUB1' Add my new email address
;                                 ***revision-history***
;----------------------------------------------------------------------------*/
                                  /* */
/*-----------------------------------------------------------------------------
; Set error traps
;----------------------------------------------------------------------------*/
signal on failure name ExitProc
signal on halt name ExitProc
signal on syntax name ExitProc

/*-----------------------------------------------------------------------------
; Do initial parse of command line and call help message if required
;----------------------------------------------------------------------------*/
                                  /* get the command line arguments */
Arg params
                                  /* call help routine if required */
If POS(params,"-?"'00'x"/?"'00'x"-HELP"'00'x"/HELP") > 0 Then Do
  Call HelpInfo
  Signal ExitProc
End

/*-----------------------------------------------------------------------------
; Start user procedure
;----------------------------------------------------------------------------*/

                                  /* based on the formatting selected, define
                                     appropriate quote paramters:
                                        pre: prefix
                                        post: suffix
                                        qchar: quote character
                                        qqchar: REXX-quoted quote char (!)
                                        reqchar: replacement quote character
                                          (for embedded quotes in body text) 
                                     NB: pre and post should already contain
                                         appropriate quotes to bound the text.
                                  */
  Select
  When (params="C") Then Do
      pre='printf("'
      post='");'
      qchar='"'
      qqchar='''"'''
      reqchar='\"'
    End
  When (params="C++") Then Do
      pre='cout << "'
      post='" << endl;'
      qchar='"'
      qqchar='''"'''
      reqchar='\"'
    End
  When (params="REXX") Then Do
      pre="Say '"
      post="'"
      qchar="'"
      qqchar='"''"'
      reqchar="''"
    End
  When (params="REXXF") Then Do
      pre="Call LINEOUT f,'"
      post="'"
      qchar="'"
      qqchar='"''"'
      reqchar="''"
    End
  Otherwise
    Signal ExitProc
  End

  Call QuoteLines

/*-----------------------------------------------------------------------------
; General exit procedure
;----------------------------------------------------------------------------*/
ExitProc:
  Drop pre post qchar reqchar
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
  Say " QUOTE C"
  Say "    formats lines with printf statements"
  Say " QUOTE C++"
  Say "    formats lines to print to cout iostream"
  Say " QUOTE REXX"
  Say "    formats lines to print with 'Say' keyword"
  Say " QUOTE REXXF"
  Say "    formats lines to print with 'LINEOUT' function"
  Say
  Say " This program is a filter - it processes the text redircted to its"
  Say " standard input stream. Output is written to standard output stream."
  Say " So, use it like this:"
  Say "    type filename.txt | quote rexx > out.cmd"
  Say " to process filename.txt for use in a REXX script"
  Say "*======================================================================*"
Return

/*-----------------------------------------------------------------------------
; routine to quote lines
; uses globals 'pre' 'post' 'qchar' and 'reqchar'
;----------------------------------------------------------------------------*/
QuoteLines:
  Do While LINES() > 0
    line = LINEIN()
    new=""

                                  /* replace qchar occurrences in source text
                                     with reqchar */
    Do While POS(qchar,line)>0
      cmd = "Parse Var line frag"qqchar"line"
      interpret cmd
      new=new''frag''reqchar
    End

                                  /* tack on any remaining line to new */
    new=new''line
                                  /* print the quoted line */
    say pre''new''post
  End
  Drop cmd line frag new
Return
