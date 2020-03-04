/*****************************************************************************/
/* Directory Size Survey                                                     */
/* (c) Paul Gallagher 1993                                                   */
/*****************************************************************************/

'@echo off'
versionStr='v1.0'
Say "DirSize" versionStr "(c) Paul Gallagher 1993 {paulg@a1.resmel.bhp.com.au}"
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

/* see if /d [list in order of size] used */
If Pos('/D',Translate(params)) > 0 Then Do
  sort=1
  params=Delstr(params,pos('/D',Translate(params)),2)
End
Else sort=0

/* see if /mXXXXX [mask by size] used */
Parse Value Translate(params) With guff'/M'minsize
masksize=Datatype(minsize,'N')
If Pos('/M',Translate(params)) > 0 Then
  params=Delstr(params,pos('/M',Translate(params)))

/*---------------------------------------------------------------------------*/
/* Start user procedure                                                      */
/*---------------------------------------------------------------------------*/

'dir 'params'/s|RXQUEUE'
'echo **QENDS**|RXQUEUE'

If (sort) Then Do
  temp1=SysTempFileName('dirsize.I??','?')
  If temp1='' Then Call ErrorMsg 'Failed file operation'
  temp2=SysTempFileName('dirsize.O??','?')
  If temp2='' Then Call ErrorMsg 'Failed file operation'
End

data=''
dir='*ns*'
totalsize=0
totalshown=0
Do While (first\='**QENDS**')
  Parse Pull first second data dummy.1
  If first='Directory' Then dir=data
  If (second='file(s)') & (dir\='*ns*') Then Do
    If (sort) Then Call LineOut temp1,Format(data,12)'	'dir
    Else If \(masksize & (data<minsize)) Then Do
      Say dir'	'data 'bytes'
      totalshown=totalshown+data
    End
    totalsize=totalsize+data
    dir='*ns*'
  End
End

If (sort) Then Do
  Call LineOut temp1
  'type 'temp1' | sort/r > 'temp2
  Do While Lines(temp2)>0
    Parse Value Strip(LineIn(temp2),'L') With data' 'dir
    If \(masksize & (data<minsize)) Then Do
      Say Strip(dir,'L')'	'data 'bytes'
      totalshown=totalshown+data
    End
  End
  Call LineOut temp2
  If SysFileTree(temp1, 'file', 'F') > 0 Then Call ErrorMsg 'Not enough memory'
  Else If file.0>0 Then 'del' temp1
  If SysFileTree(temp2, 'file', 'F') > 0 Then Call ErrorMsg 'Not enough memory'
  Else If file.0>0 Then 'del' temp2
End

Say
If (masksize) Then
  Say 'Size of listed directories:' totalshown 'bytes'
Say 'Size of directory tree:' totalsize 'bytes'

/*---------------------------------------------------------------------------*/
/* General exit procedure                                                    */
/*---------------------------------------------------------------------------*/
ExitProc:
  Drop temp1 temp2 sort totalsize
  Drop dummy. first second data
  Drop params versionStr
Exit
/*****************************************************************************/
/* end of main routine                                                       */
/*****************************************************************************/

/*****************************************************************************/
/* routine to display help message                                           */
/*****************************************************************************/
HelpInfo: Procedure
  Say " Summarises disk usage on a directory by directory basis"
  Say " Usage:"
  Say "        DirSize [filespec] [dir options] [/D] [/Mxxx]"
  Say " Where:"
  Say "        filespec and dir options are as per DIR command"
  Say "        /D - list directories in descending order of size"
  Say "        /Mxxx - only display directories with size > xxx bytes"
  Say
Return
