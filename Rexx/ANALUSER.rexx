/******************************* rexx *********************************/
/*   Program Name:    ANALUSER                                        */
/*                                                                    */
/*   Description:     This exec analyses RACF User Report. It builds  */
/*                    DD names for different purposes. For example,   */
/*                    SPECIAL DD is for all users with SPECIAL attr.  */
/*                    See below for INPUT and OUTPUT DDs that are     */
/*                    required.                                       */
/*                                                                    */
/*   Invocation:      Batch                                           */
/*                                                                    */
/*   //STEP01   EXEC PGM=IKJEFT1A,PARM='ANALUSER'                     */
/*   //SYSEXEC  DD   DISP=SHR,DSN=EXEC.LIBRARY                        */
/*   //INPUT01  DD   DISP=SHR,DSN=RACF.USER.LIST                      */
/*   //INPUT02  DD   DISP=SHR,DSN=RACF.USER.TSOINFO                   */
/*   //INPUT03  DD   DISP=SHR,DSN=RACF.USER.OMVSINFO                  */
/*   //ACCDATE  DD   *          This is the date for access           */
/*   2010-01-01                                                       */
/*   2019-01-01                                                       */
/*   //PASSDATE DD   *          Password date before user changed     */
/*   2010-01-01                                                       */
/*   2019-01-01                                                       */
/*   //REVOKED  DD   SYSOUT=*    List of Revoked Users                */
/*   //SPECIAL  DD   SYSOUT=*    List of SPECIAL Users                */
/*   //OPERATN  DD   SYSOUT=*    List of OPERATIONS Users             */
/*   //AUDITOR  DD   SYSOUT=*    List of AUDITOR Users                */
/*   //ROAUDIT  DD   SYSOUT=*    List of ROAUDIT Users                */
/*   //UAUDIT   DD   SYSOUT=*    List of Users with UAUDIT            */
/*   //PROTECT  DD   SYSOUT=*    List of Users with No Pass           */
/*   //ACCESSA  DD   SYSOUT=*    Accessed System after date           */
/*   //ACCESSB  DD   SYSOUT=*    Accessed System before date          */
/*   //PASSCHGA DD   SYSOUT=*    Changed Password after date          */
/*   //PASSCHGB DD   SYSOUT=*    Changed Password before date         */
/*   //PASSINT  DD   SYSOUT=*    List of users with specific Passint  */
/*   //UNSUCC   DD   SYSOUT=*    Users with more than 1 unsuccesful   */
/*   //TSO      DD   SYSOUT=*    Users with TSO segment.              */
/*   //OMVS     DD   SYSOUT=*    Users with OMVS segment.             */
/*   //SYSTSPRT DD   SYSOUT=*                                         */
/*   //SYSTSIN  DD   DUMMY                                            */
/*                                                                    */
/*   Return:          0 - Successful                                  */
/*                    8 - Unsuccessful. Messages follow.              */
/*                                                                    */
/*   Modifications:   YY/MM/DD - Initials - Description               */
/*                                                                    */
/**********************************************************************/
trace off
numeric digits 20
ERR_RC = 8

CVT      = C2d(Storage(10,4))                /* point to CVT         */
CVTRAC   = C2d(Storage(D2x(CVT + 992),4))    /* point to RACF CVT    */
RCVT     = CVTRAC                            /* use RCVT name        */
RCVTPINV  = C2d(Storage(D2x(RCVT + 155),1))  /* PWD Change Interval */


"execio 0 diskr INPUT01"
if (rc \= 0) then do
  say "Could not find INPUT01 DD name in the JCL."
  exit 8
end

"execio 0 diskr INPUT02"
if (rc \= 0) then do
  say "Could not find INPUT02 DD name in the JCL."
  exit 8
end

"execio 0 diskr INPUT03"
if (rc \= 0) then do
  say "Could not find INPUT03 DD name in the JCL."
  exit 8
end

"execio 0 diskr OMVS"
if (rc \= 0) then do
  say "Could not find OMVS DD name in the JCL."
  exit 8
end

"execio 0 diskr TSO"
if (rc \= 0) then do
  say "Could not find TSO DD name in the JCL."
  exit 8
end

"execio * diskr ACCDATE (stem accdate. finis"
if (rc \= 0) then do
  say "Could not find ACCDATE DD name in the JCL."
  exit 8
end
else do
  accDateB = space(translate(accDate.1,'','-'),0)
  accDateB = date('B',accDateB,'S')
  accDateA = space(translate(accDate.2,'','-'),0)
  accDateA = date('B',accDateA,'S')
end

"execio * diskr PASSDATE (stem passdate. finis"
if (rc \= 0) then do
  say "Could not find PASSDATE DD name in the JCL."
  exit 8
end
else do
  passDateB = space(translate(passDate.1,'','-'),0)
  passDateB = date('B',passDateB,'S')
  passDateA = space(translate(passDate.2,'','-'),0)
  passDateA = date('B',passDateA,'S')
end

"execio 0 diskr PASSINT"
if (rc \= 0) then do
  say "Could not find PASSINT DD name in the JCL."
  exit 8
end

"execio 0 diskr REVOKED"
if (rc \= 0) then do
  say "Could not find REVOKED DD name in the JCL."
  exit 8
end

"execio 0 diskr SPECIAL"
if (rc \= 0) then do
  say "Could not find SPECIAL DD name in the JCL."
  exit 8
end

"execio 0 diskr OPERATN"
if (rc \= 0) then do
  say "Could not find OPERATN DD name in the JCL."
  exit 8
end

"execio 0 diskr AUDITOR"
if (rc \= 0) then do
  say "Could not find AUDITOR DD name in the JCL."
  exit 8
end

"execio 0 diskr UAUDIT"
if (rc \= 0) then do
  say "Could not find UAUDIT DD name in the JCL."
  exit 8
end

"execio 0 diskr REVOKED"
if (rc \= 0) then do
  say "Could not find REVOKED DD name in the JCL."
  exit 8
end

"execio 0 diskr PROTECT"
if (rc \= 0) then do
  say "Could not find PROTECT DD name in the JCL."
  exit 8
end

"execio 0 diskr ACCESSA"
if (rc \= 0) then do
  say "Could not find ACCESSA DD name in the JCL."
  exit 8
end

"execio 0 diskr ACCESSB"
if (rc \= 0) then do
  say "Could not find ACCESSB DD name in the JCL."
  exit 8
end

"execio 0 diskr PASSCHGB"
if (rc \= 0) then do
  say "Could not find PASSCHGB DD name in the JCL."
  exit 8
end

"execio 0 diskr PASSCHGA"
if (rc \= 0) then do
  say "Could not find PASSCHGA DD name in the JCL."
  exit 8
end

"execio 0 diskr UNSUCC"
if (rc \= 0) then do
  say "Could not find UNSUCC DD name in the JCL."
  exit 8
end

"execio 0 diskr ROAUDIT"
if (rc \= 0) then do
  say "Could not find ROAUDIT DD name in the JCL."
  exit 8
end

/* Read and analyse the RACF dataset list input */
eof = 'NO'

do while eof = 'NO'
 "execio 1 diskr INPUT01"
 if (rc <> 0) then EOF = 'YES'
 else do
  parse pull record

  userid    = strip(substr(record,1,8))
  revoked   = strip(substr(record,70,3))
  special   = strip(substr(record,93,3))
  operation = strip(substr(record,116,3))
  auditor   = strip(substr(record,139,3))
  uaudit    = strip(substr(record,162,3))
  lastAcc   = strip(substr(record,185,10))
  revokeDat = strip(substr(record,208,10))
  PassInt   = strip(substr(record,231,3))
  lastPass  = strip(substr(record,254,10))
  protected = strip(substr(record,277,3))
  unsuccess = strip(substr(record,300,3))
  roaudit   = strip(substr(record,323,3))

  if (revoked = 'YES') then do
   rc = writeOut('REVOKED')
  end

  if (special = 'YES') then do
   rc = writeOut('SPECIAL')
  end

  if (operation = 'YES') then do
   rc = writeOut('OPERATN')
  end

  if (auditor = 'YES') then do
   rc = writeOut('AUDITOR')
  end

  if (uaudit = 'YES') then do
   rc = writeOut('UAUDIT')
  end

  if (roaudit = 'YES') then do
   rc = writeOut('ROAUDIT')
  end

  if (protected = 'PRO') then do
   rc = writeOut('PROTECT')
  end

  if (unsuccess > 0) then do
   message = userid unsuccess
   rc = writeOut2('UNSUCC',message)
  end

  if (RCVTPINV \= PassInt) then do
   message = userid PassInt
   rc = writeOut2('PASSINT',message)
  end

  if (lastAcc \= '') then do
   lastACCC = space(translate(lastAcc,'','-'),0)
   lastACCC = date('B',LastACCC,'S')

   if (lastACCC < accDateB) then do
    message = userid lastAcc
    rc = writeOut2('ACCESSB',message)
   end

   if (lastACCC >= accDateA) then do
    message = userid lastAcc
    rc = writeOut2('ACCESSA',message)
   end
  end

  if (lastPass \= '') then do
   lastPasss = space(translate(lastPass,'','-'),0)
   lastPasss = date('B',lastPasss,'S')

   if (lastPasss < passDateB) then do
    message = userid lastPass
    rc = writeOut2('PASSCHGB',message)
   end
   else if (lastPasss >= passDateA) then do
    message = userid lastPass
    rc = writeOut2('PASSCHGA',message)
   end
  end

 end
end

eof = 'NO'

do while eof = 'NO'
 "execio 1 diskr INPUT02"
 if (rc <> 0) then EOF = 'YES'
 else do
  parse pull record

  userid    = strip(substr(record,1,8))
  rc = writeOut('TSO')
 end
end

eof = 'NO'

do while eof = 'NO'
 "execio 1 diskr INPUT03"
 if (rc <> 0) then EOF = 'YES'
 else do
  parse pull record

  message = strip(record)
  rc = writeOut2('OMVS',message)
 end
end

exit 0

writeOut:
 parse arg outdd .
 outline = userid
 push outline
 "execio 1 diskw "outdd
return 0

writeOut2:
 parse arg outdd,msg
 push msg
 "execio 1 diskw "outdd
return 0

