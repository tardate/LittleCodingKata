/*****************************************************************************/
/* PM Archive Interface for OS/2 v2.x                                        */
/* (c) Paul Gallagher 1992                                                   */
/* This REXX/VREXX script is copywrite, but freely distributable.            */
/* See VArc.txt for notes on usage, implementation and enhancement.          */
/* Comments are welcome - mail to paulg@a1.resmel.bhp.com.au                 */
/* {snail mail: PO Box 731 Mt Waverley 3149 Australia}                       */
/*****************************************************************************/
'@echo off'
versionStr='v1.0b3'
/*---------------------------------------------------------------------------*/
/* Load REXXUTIL and VREXX                                                   */
/*---------------------------------------------------------------------------*/
If RxFuncQuery('SysLoadFuncs') \= 0 Then
  If RxFuncAdd('SysLoadFuncs','RexxUtil','SysLoadFuncs') <>0 Then Do
    Say 'Unable to init REXX Utility function loader.'
    Exit
  End
Call SysLoadFuncs
/* register VREXX procedures as necessary */
Call RxFuncAdd 'VInit', 'VREXX', 'VINIT'
If VInit()='ERROR' Then Do
  Say 'This script requires VREXX running under OS/2 v2.0'
  Say 'If VREXX is installed on this machine, then it is likely that a prior'
  Say 'VREXX process has terminated uncleanly. Restart your workstation to fix'
  Say 'this problem.'
  Exit
End

/*---------------------------------------------------------------------------*/
/* init some variables                                                       */
/*---------------------------------------------------------------------------*/
dir.home=Directory()
dir.work=dir.home
options.0=2
options.1='Include subdirectories'
options.1.state='YES'
options.2='Always display archive utility output             '
options.2.state='NO'

arcfile=''
msgwin='CLOSED'
mainwin='CLOSED'

/*---------------------------------------------------------------------------*/
/* Set error traps                                                           */
/*---------------------------------------------------------------------------*/
signal on failure name ExitProc
signal on halt name ExitProc
signal on syntax name ExitProc

/*---------------------------------------------------------------------------*/
/* Set initial dialog position                                               */
/*---------------------------------------------------------------------------*/
call VDialogPos 60, 50

/*---------------------------------------------------------------------------*/
/* Do initial parse of command line and call help message if required        */
/*---------------------------------------------------------------------------*/
/* get the command line arguments */
Parse Arg params
/* call help routine if required */
If Pos(Translate(params),"/?/HELP") > 0 Then Do
  Call HelpInfo
  Signal ExitProc
End

/*---------------------------------------------------------------------------*/
/* Setup archive utility parameters and the main window                      */
/*---------------------------------------------------------------------------*/
Call SetArcParams
Call SetupMainWin

/*---------------------------------------------------------------------------*/
/* get a temp file name to use for communication with archive utilities      */
/*---------------------------------------------------------------------------*/
tempfile=SysTempFileName(dir.home'\VARC???.TMP','?')
If tempfile='' Then Call ErrorExit 'Failed file operation'

/*---------------------------------------------------------------------------*/
/* get an initial archive file                                               */
/*---------------------------------------------------------------------------*/
logged='NO'
Do While logged='NO'
  arcfile=SelectArchive(params)
  If arcfile='' Then Signal ExitProc
  logged=LogArchive()
  If logged='NO' Then params=arcmask
End

/*---------------------------------------------------------------------------*/
/* main program loop - process the menu commands                             */
/*---------------------------------------------------------------------------*/
Do Forever
  action=GetAction()
  Select
    When action='Add/update a file' Then
      If AddFile()=0 Then Call LogArchive
    When action='Add/update some files' Then
      If MAddFile()=0 Then Call LogArchive
    When action='Extract all files' Then
      Call ExAllFile
    When action='Extract some files' Then
      Call MExFile
    When action='Delete a file' Then
      If DelFile()=0 Then Call LogArchive
    When action='Show output of last operation' Then
      'e' tempfile
    When action='Set options' Then Do
      Call SetOptions
      Call UpdateDisplay
    End
    When action='Set working directory' Then Call XWorkDir
    When action='Another archive' Then Do
      logged='NO'
      Do While logged='NO'
        arctemp=SelectArchive(arcmask)
        If arctemp\='' Then Do
          arcfile=arctemp
          logged=LogArchive()
        End
        Else logged='-'
      End
    End
    When action='QUIT' Then
      Signal ExitProc
    Otherwise
      If arcnew='YES' Then Call InfoMsg('New archive - nothing to display.')
      Else
        Call VTableBox  arcfile 'Archive Contents', arcdata, 1, 70, 10, 1
  End
End

/*---------------------------------------------------------------------------*/
/* Error exit procedure                                                      */
/*---------------------------------------------------------------------------*/
ErrorExit:
  Call LineOut tempfile
  msg.0 = 1
  msg.1 = ARG(1)
  call VMsgBox 'Error', msg, 1
  Drop msg.

/*---------------------------------------------------------------------------*/
/* "normal" exit procedure                                                   */
/*---------------------------------------------------------------------------*/
ExitProc:
  If mainwin\='CLOSED' Then Call VCloseWindow mainwin
  If msgwin\='CLOSED' Then Call VCloseWindow msgwin

  Call Directory dir.home

  If SysFileTree(tempfile, 'file', 'F') > 0 Then Call ErrorExit 'Not enough memory'
  Else If file.0>0 Then Do
    /* just to make sure the temp file is closed */
    Call LineIn tempfile
    Call LineOut tempfile
    /* delete it */
    Call SysFileDelete tempfile
  End
  Drop tempfile file.

  /* cleanup VREXX lib */
  Call VExit

  /* drop variables */
  Drop params
  Drop dir. options.
  Drop msgwin mainwin
  Drop arcfile arcdata. arcnew
  Drop arcproto. arcselect arcmask
  Drop logged
  Drop versionStr
Exit
/*****************************************************************************/

/*****************************************************************************/
/* Routine to get user action                                                */
/*****************************************************************************/
GetAction: Procedure Expose arcfile
  list.0 = 10
  list.1 = 'Show contents                   '
  list.2 = 'Add/update a file'
  list.3 = 'Add/update some files'
  list.4 = 'Extract all files'
  list.5 = 'Extract some files'
  list.6 = 'Delete a file'
  list.7 = 'Show output of last operation'
  list.8 = 'Set working directory'
  list.9 = 'Set options'
  list.10= 'Another archive'
  If VRadioBox('Select action for' FileSpec("N",arcfile), list, 3)<>'CANCEL' Then ret = list.vstring
  Else ret='QUIT'
  Drop list.
Return ret

/*****************************************************************************/
/* Routine to get user to select an archive                                  */
/*****************************************************************************/
SelectArchive:
  arcnew='NO'
  arctemp=ARG(1)
  file.0=2

  /* if something passed as parameter, lets see what we can do with it */
  IF Length(arctemp)>0 Then Do
    /* if no ext, add default */
    If Pos('.',arctemp)=0 Then arctemp=arctemp''arcproto.arcselect.ext
    /* if no match, and mask a valid filename then see if create new */
    If SysFileTree(arctemp, 'file', 'FO') > 0 Then Call ErrorExit 'Not enough memory'
    If (file.0=0) & (ValidFile(arctemp)='YES') Then Do
      If MsgDlg('Help me...','Create a new archive ('arctemp')?', 6)\='YES' Then Do
        file.0=2
        arctemp=arcmask
      End
      Else arcnew='YES'
    End
    Else
      If ValidFile(arctemp)='YES' Then file.0=1
      Else file.0=2
  End
  Else arctemp=arcmask

  Do While file.0>1
    If VFileBox('Select an archive file...', arctemp, 'name')='OK' Then Do
      arctemp=name.vstring
      If SysFileTree(arctemp, 'file', 'FO') > 0 Then Call ErrorExit 'Not enough memory'
      If (file.0=0) & (ValidFile(arctemp)='YES') Then
        If MsgDlg('Help me...','Create a new archive ('arctemp')?', 6)\='YES' Then Do
          file.0=2
          arctemp=arcmask
        End
        Else arcnew='YES'
    End
    Else Do
      file.0=0
      arctemp=''
    End
  End

  If arctemp\='' Then Do
    /* if existing file, get proper path spec */
    If file.0=1 Then Parse Upper Var file.1 arctemp
    Else arctemp=Translate(arctemp)

    /* see if we can handle the specified file */
    i=0
    cont='Y'
    Do While cont='Y'
      i=i+1
      If i>arcproto.number Then cont='F'
      Else
        If Pos(arcproto.i.ext,arctemp)>0 Then Do
          If (SysSearchPath('PATH',arcproto.i.arcexe)\='') & (SysSearchPath('PATH',arcproto.i.unarcexe)\='') Then Do
            arcselect=i
            cont='S'
          End
        End
    End
    If cont='F' Then Do
      Call FindError FileSpec("N",arctemp)
      arctemp=''
    End
  End
  Drop cont
Return arctemp

/*****************************************************************************/
/* Routine to change working directory                                       */
/*****************************************************************************/
XWorkDir:
  prompt.0=1
  prompt.1='Enter new working directory  '
  prompt.vstring=dir.work
  If VInputBox('Set working directory...',prompt,40,3)='OK' Then Do
    dir.work=prompt.vstring
    Call Directory dir.work
    Call UpdateDisplay
  End
  Drop prompt. file.
Return

/*****************************************************************************/
/* Routine to log archive contents                                           */
/*****************************************************************************/
LogArchive:
  Call UpdateDisplay
  If SysFileTree(arcfile, 'file', 'FO') > 0 Then Call ErrorExit 'Not enough memory'
  If (file.0\=1) Then Do
    arcnew='YES'
    Return arcnew
  End
  Else arcnew='NO'

  Call ExecMsgWin 'Loading archive details...'
  status='-'
  /* just to make sure the temp file is closed */
  Call LineIn tempfile
  Call LineOut tempfile

  /* construct 'list' command from archive prototype */
  listcmd=arcproto.arcselect.list '>' tempfile
  /* get rid of '~filemask~' */
  listcmd=DelWord(listcmd,WordPos('~filemask~',listcmd),1)
  /* replace '~archive~' with archive file name */
  i=Pos('~archive~',listcmd)
  listcmd=DelStr(listcmd,i,Length('~archive~'))
  listcmd=Insert(arcfile,listcmd,i-1)

  /* do list command */
  listcmd

  /* lets process the list */
  arcdata.cols = 3
  arcdata.label.1 = 'Size'
  arcdata.label.2 = 'Date'
  arcdata.label.3 = 'Name'
  arcdata.width.1 = 10
  arcdata.width.2 = 15
  arcdata.width.3 = 150

  /* find first line with "----" in it */
  Do While status='-'
    dummy=LineIn(tempfile)
    If Pos(arcproto.arcselect.startdelim,Dummy)>0 Then status='YES'
    If Lines(tempfile)=0 Then Do
      Call ErrorMsg 'Incompatible version of' arcproto.arcselect.unarcexe 'or corrupt archive.'
      status='NO'
    End
  End

  If status='YES' Then Do
    i=0
    status='-'
    Do While status='-'
      dummy=LineIn(tempfile)
      Select
      When Lines(tempfile)=0 Then Do
        status='NO'
        Call ErrorMsg 'Incompatible version of' arcproto.arcselect.unarcexe
      End
      When Pos(arcproto.arcselect.enddelim,Dummy)>0 Then status='YES'
      Otherwise
          Interpret 'Parse Var dummy 'arcproto.arcselect.parse
          i=i+1
          arcdata.i.1=fsize
          arcdata.i.2=fyy'/'fmm'/'fdd
          arcdata.i.3=fname
      End
    End
    arcdata.rows=i
  End

  Call LineOut tempfile
  Call ExecMsgWin
  Drop fsize fdd fmm fyy fname d.
  Drop i dummy
  Drop listcmd
Return status

/*****************************************************************************/
/* Routine to add a single file to archive                                   */
/*****************************************************************************/
AddFile:
  If VFileBox('Select a file to add to this archive...', '*.*', 'prompt')\='OK' Then Return 1
  Call DoArcCmd prompt.vstring, arcproto.arcselect.arcnosub, 'Adding' FileSpec('N',prompt.vstring) 'to archive...'
  Drop prompt.
Return 0

/*****************************************************************************/
/* Routine to add a multiple files to archive                                */
/*****************************************************************************/
MAddFile:
  prompt.0=1
  prompt.1='Enter file mask  '
  prompt.vstring='*'
  If VInputBox('Add files to archive...',prompt,40,3)\='OK' Then Return 1
  /* construct 'archive' command from archive prototype
  - assume options.1 is 'Include subdirectories' */
  If options.1.state='YES' Then
    Call DoArcCmd prompt.vstring, arcproto.arcselect.arc, 'Adding' FileSpec('N',prompt.vstring) 'to archive...'
  Else
    Call DoArcCmd prompt.vstring, arcproto.arcselect.arcnosub, 'Adding' FileSpec('N',prompt.vstring) 'to archive...'
  Drop prompt.
Return 0

/*****************************************************************************/
/* Routine to extract a single file from archive                             */
/*****************************************************************************/
ExAllFile:
  /* construct 'archive' command from archive prototype
  - assume options.1 is 'Include subdirectories' */
  If options.1.state='YES' Then
    Call DoArcCmd '', arcproto.arcselect.unarc, 'Extracting all files from archive...'
  Else
    Call DoArcCmd '', arcproto.arcselect.unarcnosub, 'Extracting all files from archive...'
Return

/*****************************************************************************/
/* Routine to extract multiple files from archive                            */
/*****************************************************************************/
MExFile:
  prompt.0=1
  prompt.1='Enter file mask  '
  prompt.vstring='*'
  If VInputBox('Extract files from archive...',prompt,40,3)\='OK' Then Return
  /* construct 'archive' command from archive prototype
  - assume options.1 is 'Include subdirectories' */
  If options.1.state='YES' Then
    Call DoArcCmd prompt.vstring, arcproto.arcselect.unarc, 'Extracting' FileSpec('N',prompt.vstring) 'from archive...'
  Else
    Call DoArcCmd prompt.vstring, arcproto.arcselect.unarcnosub, 'Extracting' FileSpec('N',prompt.vstring) 'from archive...'
  Drop prompt.
Return

/*****************************************************************************/
/* Routine to delete a selected file from archive                            */
/*****************************************************************************/
DelFile:
  If VTableBox('Select file to delete from' arcfile, arcdata, 1, 70, 10, 1)='CANCEL' Then Return 1
  i=arcdata.vstring
  Call DoArcCmd arcdata.i.3, arcproto.arcselect.del, 'Deleting' FileSpec('N',arcdata.i.3) 'from archive...'
  Drop i prompt.
Return 0

/*****************************************************************************/
/* Generic archive command                                                   */
/* ARG(1) = filemask                                                         */
/* ARG(2) = command line prototype                                           */
/* ARG(3) = message to display while working                                 */
/*****************************************************************************/
DoArcCmd:
  Call ExecMsgWin ARG(3)
  status='-'
  /* just to make sure the temp file is closed */
  Call LineIn tempfile
  Call LineOut tempfile

  /* construct 'extract' command */
  cmd=ARG(2) '>' tempfile
  /* replace '~filemask~' with speced file */
  i=Pos('~filemask~',cmd)
  cmd=DelStr(cmd,i,Length('~filemask~'))
  cmd=Insert(ARG(1),cmd,i-1)
  /* replace '~archive~' with archive file name */
  i=Pos('~archive~',cmd)
  cmd=DelStr(cmd,i,Length('~archive~'))
  cmd=Insert(arcfile,cmd,i-1)

  /* do list command */
  cmd
  Call ExecMsgWin

  /* potential to show archive output in tempfile (not implemented) */
  Call LineIn tempfile
  Call LineOut tempfile
  If options.2.state='YES' Then 'e' tempfile

  Drop cmd
Return

/*****************************************************************************/
/* Set options                                                               */
/*****************************************************************************/
SetOptions: Procedure Expose options.
  j=0
  do i=1 to options.0
    list.i=options.i
    If options.i.state='YES' Then Do
       j=j+1
       sel.j=options.i
    End
  End
  list.0 = options.0
  Sel.0=j
  If VCheckBox('Set archiving options', list, sel, 3)<>'CANCEL' Then Do
    Do i=1 to options.0
      options.i.state='NO'
      If sel.0>0 Then Do j=1 to sel.0
        If options.i=sel.j Then options.i.state='YES'
      End
    End
  Drop i j list. sel.
Return

/*****************************************************************************/
/* setup main window  (with handle mainwin)                                  */
/*****************************************************************************/
SetupMainWin:
  win.left   = 2
  win.right  = 60
  win.top    = 98
  win.bottom = 65
  mainwin = VOpenWindow('VArc' versionStr '(c) Paul Gallagher 1992', 'YELLOW', win)
  Call UpdateDisplay
  Drop win.
Return

UpdateDisplay:
  call VClearWindow mainwin
  call VForeColor mainwin, 'BLUE'
  Call VSetFont mainwin, 'HELVB', 18
  call VSay mainwin, 10, 900, 'LZH-ZIP-ZOO-ARC Archive Manager'
  call VForeColor mainwin, 'BLACK'
  Call VSetFont mainwin, 'TIME', 14
  call VSay mainwin, 10, 720, 'Work Directory    :' dir.work
  call VSay mainwin, 10, 600, 'Current Archive   :' arcfile
  call VSay mainwin, 10, 480, 'Program Options'
  Call VSetFont mainwin, 'HELV', 10
  call VSay mainwin, 10, 830, 'REXX / VREXX Rules!'
  y=400
  do i=1 to options.0
    Call VSay mainwin, 40, y, options.i ':' options.i.state
    y=y-100
  End
  Drop i y
Return

/*****************************************************************************/
/* exec message window  (with handle msgwin)                                 */
/*****************************************************************************/
ExecMsgWin: Procedure Expose msgwin
  If msgwin='CLOSED' Then Do
    mwin.left   = 25
    mwin.right  = 75
    mwin.top    = 55
    mwin.bottom = 45
    msgwin = VOpenWindow('VArc says...', 'CYAN', mwin)
    /* do some initial stuff in the window */
    call VForeColor msgwin, 'BLACK'
    Call VSetFont msgwin, 'HELVB', 16
    call VSay msgwin, 10, 500, ARG(1)
    Drop mwin.
  End
  Else Do
    Call VCloseWindow msgwin
    msgwin='CLOSED'
  End
Return

/*****************************************************************************/
/* set parameters for using the archive programs                             */
/*****************************************************************************/
SetArcParams:
  arcmask='*.*z*'
  arcproto.number=5  /* number of different archive programs supported */
  arcselect=1  /* current config selected */
  /* settings for LH */
  arcproto.1.ext='.LZH'
  arcproto.1.arcexe='LH.EXE'
  arcproto.1.unarcexe='LH.EXE'
  arcproto.1.arc='lh a ~archive~ ~filemask~ /os'
  arcproto.1.arcnosub='lh a ~archive~ ~filemask~ /o'
  arcproto.1.unarc='lh x ~archive~ ~filemask~ /os'
  arcproto.1.unarcnosub='lh x ~archive~ ~filemask~ /o'
  arcproto.1.list='lh l ~archive~ ~filemask~ /o'
  arcproto.1.del='lh d ~archive~ ~filemask~ /o'
  arcproto.1.parse="fsize fyy'-'fmm'-'fdd fname"
  arcproto.1.startdelim='---'
  arcproto.1.enddelim='---'
  /* settings for ZIP/UNZIP */
  arcproto.2.ext='.ZIP'
  arcproto.2.arcexe='ZIP.EXE'
  arcproto.2.unarcexe='UNZIP.EXE'
  arcproto.2.arc='zip -r ~archive~ ~filemask~'
  arcproto.2.arcnosub='zip -j ~archive~ ~filemask~'
  arcproto.2.unarc='unzip -o ~archive~ ~filemask~'
  arcproto.2.unarcnosub='unzip -jo ~archive~ ~filemask~'
  arcproto.2.list='unzip -v ~archive~ ~filemask~'
  arcproto.2.del='zip -d ~archive~ ~filemask~'
  arcproto.2.parse="fsize d.1 d.2 d.3  fdd'-'fmm'-'fyy d.4 d.5  fname"
  arcproto.2.startdelim='---'
  arcproto.2.enddelim='---'
  /* settings for PKZIP2/PKUNZIP2 */
  arcproto.3.ext='.ZIP'
  arcproto.3.arcexe='PKZIP2.EXE'
  arcproto.3.unarcexe='PKUNZIP2.EXE'
  arcproto.3.arc='pkzip2 -apr ~archive~ ~filemask~'
  arcproto.3.arcnosub='pkzip2 ~archive~ ~filemask~'
  arcproto.3.unarc='pkunzip2 -o -d ~archive~ ~filemask~'
  arcproto.3.unarcnosub='pkunzip2 -o ~archive~ ~filemask~'
  arcproto.3.list='pkunzip2 -vb ~archive~ ~filemask~'
  arcproto.3.del='pkzip2 -d ~archive~ ~filemask~'
  arcproto.3.parse="fsize d.1 d.2 d.3 fmm'-'fdd'-'fyy d.4 fname"
  arcproto.3.startdelim='---'
  arcproto.3.enddelim='---'
  /* settings for ZOO */
  arcproto.4.ext='.ZOO'
  arcproto.4.arcexe='ZOO.EXE'
  arcproto.4.unarcexe='ZOO.EXE'
  arcproto.4.arc='zoo a ~archive~ ~filemask~'
  arcproto.4.arcnosub='zoo a: ~archive~ ~filemask~'
  arcproto.4.unarc='zoo x.O ~archive~ ~filemask~'
  arcproto.4.unarcnosub='zoo x:O ~archive~ ~filemask~'
  arcproto.4.list='zoo -l ~archive~ ~filemask~'
  arcproto.4.del='zoo DP ~archive~ ~filemask~'
  arcproto.4.parse="fsize d.1 d.2 fdd fmm fyy d.3 d.4 fname"
  arcproto.4.startdelim='---'
  arcproto.4.enddelim='---'
  /* settings for ARC */
  arcproto.5.ext='.ARC'
  arcproto.5.arcexe='ARC.EXE'
  arcproto.5.unarcexe='ARC.EXE'
  arcproto.5.arc='arc a ~archive~ ~filemask~'
  arcproto.5.arcnosub='arc a ~archive~ ~filemask~'
  arcproto.5.unarc='arc x ~archive~ ~filemask~'
  arcproto.5.unarcnosub='arc x ~archive~ ~filemask~'
  arcproto.5.list='arc l ~archive~ ~filemask~'
  arcproto.5.del='arc d ~archive~ ~filemask~'
  arcproto.5.parse="fname fsize fdd fmm fyy"
  arcproto.5.startdelim='==='
  arcproto.5.enddelim='==='
Return

/*****************************************************************************/
/* reports error for file not on path                                        */
/* ARG(1) = name of file                                                     */
/*****************************************************************************/
FindError:
  msg.0 = 2
  msg.1 = 'Cannot process' ARG(1)
  msg.2 = 'Archive utility not found on PATH'
  call VMsgBox 'Error', msg, 1
  Drop msg.
Return

/* standard routines */
/*****************************************************************************/
/* routine to display help message                                           */
/*****************************************************************************/
HelpInfo: Procedure Expose versionStr
  msg.0 = 5
  msg.1 ='VArc Archive Manager' versionStr
  msg.2 ='(c) Paul Gallagher 1992,1993'
  msg.3 ='Problems: paulg@a1.resmel.bhp.com.au'
  msg.4 ='Requires OS/2 versions of the appropriate archive'
  msg.5 ='utilities on the PATH to work.'
  call VMsgBox 'Info', msg, 1
  Drop msg.
Return

/*****************************************************************************/
/* info message procedure                                                    */
/* ARG(1) = message to display                                               */
/*****************************************************************************/
InfoMsg: Procedure
  msg.0 = 1
  msg.1 = ARG(1)
  call VMsgBox 'Info', msg, 1
  Drop msg.
Return

/*****************************************************************************/
/* error message procedure                                                    */
/* ARG(1) = message to display                                               */
/*****************************************************************************/
ErrorMsg: Procedure
  msg.0 = 1
  msg.1 = ARG(1)
  call VMsgBox 'Error', msg, 1
  Drop msg.
Return

/*****************************************************************************/
/* question procedure                                                        */
/* ARG(1) = dialog box title                                                 */
/* ARG(2) = message to display                                               */
/* ARG(3) = buttons required (value)                                         */
/* returns button name pressed                                               */
/*****************************************************************************/
MsgDlg: Procedure
  msg.0 = 1
  msg.1 = ARG(2)
  ret = VMsgBox(ARG(1), msg, ARG(3))
  Drop msg.
Return ret

/*****************************************************************************/
/* determine if filename valid                                               */
/* ARG(1) = filename                                                         */
/*****************************************************************************/
ValidFile:
  If (Pos('*',ARG(1))>0) | (Pos('?',ARG(1))>0) Then ans='NO'
  Else ans='YES'
Return ans
