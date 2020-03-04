/*****************************************************************************/
/* Show long filenames                                                       */
/* By Paul Gallagher 1993                                                    */
/*****************************************************************************/

'@echo off'
versionStr='v1.0'
Say "ShowLong" versionStr "by Paul Gallagher 1993 {paulg@a1.resmel.bhp.com.au}"
Say

/*---------------------------------------------------------------------------*/
/* Load REXXUTIL                                                             */
/*---------------------------------------------------------------------------*/
If RxFuncQuery('SysLoadFuncs') <> 0 Then
  If RxFuncAdd('SysLoadFuncs','RexxUtil','SysLoadFuncs') <>0 Then Do
    Say 'Unable to init REXX Utility function loader.'
    Exit
  End
Call SysLoadFuncs

/*---------------------------------------------------------------------------*/
/* Set error traps                                                           */
/*---------------------------------------------------------------------------*/
signal on failure name ExitProc
signal on halt name ExitProc
signal on syntax name ExitProc

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
/* Start user procedure                                                      */
/*---------------------------------------------------------------------------*/
validchars="ABCDEFGHIJKLMNOPQRSTUVWXYZ~!@#$%^&()-_{}'0123456789"

'dir 'params'/s/b|RXQUEUE'
'echo **QENDS**|RXQUEUE'

Parse Pull fullpath
Do While (fullpath\='**QENDS**')
  Parse Value FileSpec("name",fullpath) with name'.'ext
  If (Length(name)>8) | (Length(ext)>3) | (Verify(TRANSLATE(name''ext),validchars)\=0)Then Do
    Say fullpath
  End
  Parse Pull fullpath
End

/*---------------------------------------------------------------------------*/
/* General exit procedure                                                    */
/*---------------------------------------------------------------------------*/
ExitProc:
  Drop name ext fullpath validchars
  Drop params versionStr
Exit
/*****************************************************************************/
/* end of main routine                                                       */
/*****************************************************************************/

/*****************************************************************************/
/* routine to display help message                                           */
/*****************************************************************************/
HelpInfo: Procedure
  Say " Lists all files/directories in a directory tree with"
  Say " long (HPFS) filenames. This includes names that use"
  Say " characters not normally allowed by DOS."
  Say
  Say " Usage:"
  Say "        ShowLong [RootDir]"
  Say
Return
