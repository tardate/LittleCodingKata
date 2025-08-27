/*---------------------------------------------------------------------------*/
  '@echo off'
  programNameStr=   "Create new project (example only)"
  copyrightStr=     "Copyright (c) Paul Gallagher 1995"

/*                                ***keywords*** "Version: %v  Date: %d %t"  */
  versionStr=       "Version: 3:1  Date: 5-Apr-95 12:00:30"
/*
;                                 ***keywords*** "%l"
; LOCK STATUS       "/EDMSUB1"
;
;                                 ***keywords*** "%n"
; Filename          "NEWPROJ.CMD"
; Platform          OS/2 (REXX)
;
; Authors           Paul Gallagher (paulpg@ibm.net)
;
; Description       
;
; Revision History
;                                 ***revision-history***
; 1 NEWPROJ.CMD 5-Mar-95,1:13:44,`PAULG/EDMSUB1' Initial check-in
; 2 NEWPROJ.CMD 7-Mar-95,0:13:08,`PAULG/EDMSUB1' Initial check-in
; 3 NEWPROJ.CMD 9-Mar-95,22:21:36,`PAULG/EDMSUB1' Final for EDM submission
; 3:1 NEWPROJ.CMD 5-Apr-95,12:00:30,`PAULG/EDMSUB1' Add new email address
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
If POS(TRANSLATE(params),"-?"'00'x"/?"'00'x"-HELP"'00'x"/HELP") > 0 Then Do
  Call HelpInfo
  Signal ExitProc
End

/*-----------------------------------------------------------------------------
; Start user procedure
;----------------------------------------------------------------------------*/

                                  /* sign-on message */

  Say programNameStr versionStr
  Say copyrightStr

  Author = 'Paul Gallagher'
  FullAuthor = Author '(paulpg@ibm.net)'

                                  /* get root directory for project files from
                                     an environment variable called "PrjRoot";
                                     if PrjRoot not defined, create in C:\ */

  prjRoot = VALUE('PrjRoot',,'OS2ENVIRONMENT')
  If LENGTH(prjRoot)=0 Then
    prjRoot="C:\"

                                  /* get project name */

  Say
  Say 'Enter project name (which will be used as the project directory name)'
  Say 'The name must therefore meet file system directory naming conventions'
  Call CHAROUT ,'> '
  Pull projectName
  prjDir = prjRoot''projectName
  Say

                                  /* make Poject directory */
  Say "DIRECTORIES"
  Say ".. Creating project directory..."
  Call SysMkDir prjDir
                                  /* make OS/2,DOS & WIN dirs */
  Say ".. Creating DOS,OS/2 and WIN project subdirectories..."
  Call SysMkDir prjDir'\DOS'
  Call SysMkDir prjDir'\OS2'
  Call SysMkDir prjDir'\WIN'

                                  /* cd to project directory */
  Call DIRECTORY prjDir

                                  /* make workplace shell folder,
                                     populate it with icons */

  Say "WORKPLACE SHELL OBJECTS"
  Call CreateFolder projectName, prjDir

/*-----------------------------------------------------------------------------
; General exit procedure
;----------------------------------------------------------------------------*/
ExitProc:
  Drop Author FullAuthor
  Drop prjRoot projectName prjDir
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
  Say " This script demonstrates the range of tasks that REXX may be used"
  Say " for in setting up a new project."
  Say " This script actually DOES NOTHING."
  Say "*======================================================================*"
Return

/*-----------------------------------------------------------------------------
; routine to create WP folder with appropriate icons/shadows
; Parameters:
;     1: project name
;     2: project directory
;----------------------------------------------------------------------------*/
CreateFolder: Procedure
n = ARG(1)
d = ARG(2)
                                  /* create folder to collect all the "REXX - The developer's
                                     best friend stuff */

Say '.. Creating a "REXX - The developer''s best friend" folder...'
Call SysCreateObject "WPFolder", "REXX - The developer's best friend", "<WP_DESKTOP>",,
                     "OBJECTID=<REXX-TDBF>;"

                                  /* create folder for the project being initialised 
                                     - if this process fails, end the procedure now */

Say ".. Creating project folder..."
If SysCreateObject("WPFolder", n "Project", "<REXX-TDBF>",,
                   "OBJECTID=<SPRJ-"n">;WORKAREA=YES;","UPDATE") Then Do

                                  /* create icon for BC++ (OS/2) */

  Say ".. Creating Borland C++ (OS/2) icon..."
  Call SysCreateObject "WPProgram", "Borland C++ (OS/2)", "<SPRJ-"n">",,
                   "EXENAME=c:\bcos2\bin\bc.exe;STARTUPDIR="d"\OS2;","UPDATE"

                                  /* create icon for BC++ (DOS) */

  Say ".. Creating Borland C++ (DOS) icon..."
  Call SysCreateObject "WPProgram", "Borland C++ (DOS)", "<SPRJ-"n">",,
                   "EXENAME=c:\bc\bin\bc.exe;STARTUPDIR="d"\DOS;"||,
                   "PROGTYPE=VDM;"||,
                   "SET DPMI_DOS_API=ENABLED;","UPDATE"

                                  /* create icon for BC++ (Windows) */

  Say ".. Creating Borland C++ (Win) icon..."
  Call SysCreateObject "WPProgram", "Borland C++ (Win)", "<SPRJ-"n">",,
                   "EXENAME=c:\bc\bin\bcw.exe;STARTUPDIR="d"\WIN;"||,
                   "PROGTYPE=WINDOWEDWIN;","UPDATE"

                                  /* command prompt that starts up in the project
                                     directory */

  Say ".. Creating OS/2 Command Prompt icon..."
  Call SysCreateObject "WPProgram", "OS/2 Command Prompt", "<SPRJ-"n">",,
                   "EXENAME=*;STARTUPDIR="d";","UPDATE"

                                  /* Create a shadow for the project directory */

  Say ".. Creating project directory shadow in the project folder..."
  Call SysCreateShadow d, "<SPRJ-"n">"

                                  /* Open the project directory */

  Say ".. opening the new project folder..."
  Call SysOpenObject "<SPRJ-"n">", "ICON", TRUE

End
Drop n d rc
Return

