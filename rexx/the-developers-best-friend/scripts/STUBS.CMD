/*---------------------------------------------------------------------------*/
  '@echo off'
  programNameStr=   "Program Stub Creation"
  copyrightStr=     "Copyright (c) Paul Gallagher 1995"

/*                                ***keywords*** "Version: %v  Date: %d %t"  */
  versionStr=       "Version: 2:1  Date: 5-Apr-95 12:00:18"
/*
;                                 ***keywords*** "%l"
; LOCK STATUS       "/EDMSUB1"
;
;                                 ***keywords*** "%n"
; Filename          "STUBS.CMD"
; Platform          OS/2 (REXX)
;
; Authors           Paul Gallagher (paulpg@ibm.net)
;
; Description       
;
; Revision History
;                                 ***revision-history***
; 1 STUBS.CMD 26-Feb-95,18:40:08,`PAULG/EDMSUB1' Initial check-in
; 1:1 STUBS.CMD 9-Mar-95,0:23:52,`PAULG/EDMSUB1' Fix qchar replacement
; 2 STUBS.CMD 9-Mar-95,22:23:02,`PAULG/EDMSUB1' Final for EDM submission
; 2:1 STUBS.CMD 5-Apr-95,12:00:18,`PAULG/EDMSUB1' Add new email address
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
Parse Arg params
                                  /* call help routine if required */
If Pos(Translate(params),"-?"'00'x"/?"'00'x"-HELP"'00'x"/HELP") > 0 Then Do
  Call HelpInfo
  Signal ExitProc
End

/*-----------------------------------------------------------------------------
; Start user procedure
;----------------------------------------------------------------------------*/

                                  /* sign-on */
Say programNameStr versionStr
Say copyrightStr

                                  /* set some global values that may be used
                                     in stubs */
Author = 'Paul Gallagher'
FullAuthor = Author '(paulpg@ibm.net)'
Parse Value DATE('N') With dd mm yy
Parse Source . . SourceFile
                                  /* command variable */
Cmd = ''

                                  /* main loop */
Do Forever
                                  /* display menu */
  Say 
  Say "Select from the following commands:"
/*FLAG1* DO NOT DELETE THIS LINE - New menu items inserted above*/
  Say "   -----------------------------------------------------"
  Say "   MODIFY: add a new template to this file"
  Say "   EXIT: end processing"
  Call CHAROUT ,'> '
  Pull Cmd

                                  /* process menu option */
  Select
  When ABBREV("EXIT",Cmd) Then
    Signal ExitProc
  When ABBREV("MODIFY",Cmd) Then
    Call AdminMODIFY
/*FLAG2* DO NOT DELETE THIS LINE - New menu items inserted below*/
  Otherwise
    Nop
  End
End

/*-----------------------------------------------------------------------------
; General exit procedure
;----------------------------------------------------------------------------*/
ExitProc:
  Drop Cmd SourceFile
  Drop params programNameStr copyrightStr versionStr Author FullAuthor
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
  Say "*======================================================================*"
Return

/*-----------------------------------------------------------------------------
; routine to modify thjis file (add a new stub)
;----------------------------------------------------------------------------*/
AdminMODIFY: Procedure Expose SourceFile
                                  /* get parameters for new stub */
  Say
  Say "DEFINING NEW STUB..."
  Call CHAROUT ,'Enter sample filename : '
  Parse Pull sample
  Call CHAROUT ,'Enter command key     : '
  Pull key
  Call CHAROUT ,'Description (for menu): '
  Parse Pull description

                                  /* create a queue to store the file-in-process */
  newq = RXQUEUE('Create')
  oldq = RXQUEUE('Set',newq)

                                  /* read stubs.cmd to queue */
  Do While LINES(SourceFile) > 0
    line = LINEIN(SourceFile)
    queue line
  End

                                  /* begin re-writting stubs.cmd */
  Call LINEOUT SourceFile,,1

  Do While QUEUED() > 0
    Parse Pull line

                                  /* insert new menu item */
    if (POS("/*FLAG1",line)=1) Then Do
      Call LINEOUT SourceFile,'  Say "   'key': 'description'"'
    End
                                  /* write current line */
    Call LINEOUT SourceFile,line

                                  /* insert new menu-processing commands */
    if (POS("/*FLAG2",line)=1) Then Do
      Call LINEOUT SourceFile,'  When ABBREV("'key'",Cmd) Then'
      Call LINEOUT SourceFile,'    Call Create'key
    End
  End
                                  /* append new procedure */
  Call LINEOUT SourceFile,"/*-----------------------------------------------------------------------------"
  Call LINEOUT SourceFile,"; routine to create a new stub file"
  Call LINEOUT SourceFile,";----------------------------------------------------------------------------*/"
  Call LINEOUT SourceFile,"Create"key": Procedure Expose Author FullAuthor dd mm yy"
  Call LINEOUT SourceFile,"  Say '"key": "description"'"
  Call LINEOUT SourceFile,"  Call CHAROUT ,'Enter new filename: '"
  Call LINEOUT SourceFile,"  Parse Pull f"
  Call LINEOUT SourceFile,"  If LENGTH(name)=0 Then Return"

                                  /* begin writing stub file */
  Call LINEOUT SourceFile,""
                                  /* insert sample script */
  pre="Call LINEOUT f,'"
  post="'"
  Do While LINES(sample) > 0
    line = LINEIN(sample)
    new=""
                                  /* replace conflicting quote chars in source */
    Do While POS("'",line)>0
      Parse Var line frag"'"line
      new=new''frag"''"
    End
    new=new''line
                                  /* write command to write 'clean' line */
    Call LINEOUT SourceFile,'  'pre''new''post
  End

                                  /* end writting stub */
  Call LINEOUT SourceFile,"  Call LINEOUT f"

  Call LINEOUT SourceFile,"  Say f 'successfully create..'"
  Call LINEOUT SourceFile,"  Drop f"
  Call LINEOUT SourceFile,"Return"
  Call LINEOUT SourceFile,""

  Call RXQUEUE 'Set',oldq
  Call RXQUEUE 'Delete',newq

  Drop sample key description
  Drop frag pre post qchar reqchar
  Drop line newq oldq

  Say SourceFile "modified: re-run to use new options..."
  Signal ExitProc
Return

