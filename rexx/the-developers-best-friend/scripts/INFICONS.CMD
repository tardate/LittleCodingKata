/*---------------------------------------------------------------------------*/
  '@echo off'
  programNameStr=   "Create icons for INF files"
  copyrightStr=     "Copyright (c) Paul Gallagher 1995"

/*                                ***keywords*** "Version: %v  Date: %d %t"  */
  versionStr=       "Version: 2:4  Date: 5-Apr-95 12:00:50"
/*
;                                 ***keywords*** "%l"
; LOCK STATUS       "/EDMSUB1"
;
;                                 ***keywords*** "%n"
; Filename          "INFICONS.CMD"
; Platform          OS/2 (REXX)
;
; Authors           Paul Gallagher (paulpg@ibm.net)
;
; Description       
;
; Revision History
;                                 ***revision-history***
; 1 INFICONS.CMD 7-Jan-95,13:50:12,`PAULG/REXX' Initial check-in
; 1:1 INFICONS.CMD 7-Jan-95,14:35:46,`PAULG/REXX' Removed fluff; Made sure
;      SysCreateObject setup string ended with ";"
; 1:2 INFICONS.CMD 14-Jan-95,22:41:52,`PAULG/REXX' icon path caption to lower
; 2 INFICONS.CMD 26-Feb-95,19:33:14,`PAULG/REXX' Icon now uses real INF title
; 2:1 INFICONS.CMD 6-Mar-95,19:23:30,`PAULG/EDMSUB1' Expanded documentation
; 2:2 INFICONS.CMD 7-Mar-95,0:24:46,`PAULG/EDMSUB1' Single line icon title -
; 2:3 INFICONS.CMD 9-Mar-95,22:20:52,`PAULG/EDMSUB1' Final for EDM submission
; 2:4 INFICONS.CMD 5-Apr-95,12:00:50,`PAULG/EDMSUB1' Add my new email address
;                                 ***revision-history***
;----------------------------------------------------------------------------*/
                                  /* */
/*-----------------------------------------------------------------------------
; Load REXXUTIL
;----------------------------------------------------------------------------*/
If RxFuncQuery('SysLoadFuncs') <> 0 Then
  If RxFuncAdd('SysLoadFuncs','RexxUtil','SysLoadFuncs') <>0 Then Do
    Say 'Unable to init REXX Utility function loader.'
    Exit
  End
Call SysLoadFuncs

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
Parse Arg params
                                  /* call help routine if required */
If Pos(Translate(params),"-?"'00'x"/?"'00'x"-HELP"'00'x"/HELP") > 0 Then Do
  Call HelpInfo
  Signal ExitProc
End

/*-----------------------------------------------------------------------------
; Start user procedure
;----------------------------------------------------------------------------*/

                                  /* sign-on message */

Say programNameStr versionStr
Say copyrightStr

                                  /* parse command line. If no parameters, search
                                     for c:\*.inf, otherwise clean up params, adding
                                     the *.inf filemask if required */

If LENGTH(params)>0 Then Do
  If SUBSTR(params,LENGTH(params),1)='\' Then
    mask=params'*.INF'
  Else
    If TRANSLATE(SUBSTR(params,LENGTH(params)-3,4))='.INF' Then
      mask=params
    Else
      mask=params'\*.INF'
End
Else
  mask='C:\*.INF'

                                  /* search for files matching 'mask' - results
                                     returned in 'file' stem */

If SysFileTree(mask, 'file', 'FSO') > 0 Then 

                                  /* out of memory message */
  Say SysGetMessage(8)

Else Do
                                  /* if files found then process */

  if file.0>0 Then Do

                                  /* create folder for INF files */

    Call SysCreateObject "WPFolder", "INF Files", "<WP_DESKTOP>",, 
                       "OBJECTID=<INF_FILES>"

                                  /* loop through all INFs found */
    Do i=1 to file.0

                                  /* get file name, print message to screen */

      name=FILESPEC("name",file.i)
      path=FILESPEC("drive",file.i)''FILESPEC("path",file.i)
      Call CHAROUT ,'Creating icon for' name

                                  /* peek inside INF to get title */

      Call CHARIN file.i,1,X2D('6B')
      Parse Value CHARIN(file.i,,48) with title'00'x

                                  /* if no title, use filename instead; print
                                     real title to screen if found */

      IF LENGTH(title)=0 Then
        title = name
      Else
        Call CHAROUT ,' ['title']'

                                  /* create object for INF file */

      Call SysCreateObject "WPProgram", title' ['path']', "<INF_FILES>",,
                   "EXENAME=VIEW.EXE;PARAMETERS="name";STARTUPDIR="path";",,
                   "UPDATE"

                                  /* end of line for screen message */
      Say

    End
  End
  Else
                                  /* file not found message */
    Say SysGetMessage(2)
End

/*-----------------------------------------------------------------------------
; General exit procedure
;----------------------------------------------------------------------------*/
ExitProc:
  Drop mask file. i name title path
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
  Say "   INFICONS [path][filemask]"
  Say
  Say ' Searches for INF files starting from the directory specified by "path"'
  Say ' A filemask may be provided to further restrict the search.'
  Say ' If no path or filemask is provided, all of C: drive will be seached.'
  Say ' Creates corresponding icons in a folder called "INF Files".'
  Say "*======================================================================*"
Return
