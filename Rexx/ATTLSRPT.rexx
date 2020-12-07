/******************************* rexx *********************************/
/*   Program Name:    ATTLSRPT                                        */
/*                                                                    */
/*   Description:     This exec reports the CIPHER and TLS version    */
/*                    for all active connections through ATTLS. You   */
/*                    must choose which application to inspect.       */
/*                                                                    */
/*   Invocation:      Batch                                           */
/*                                                                    */
/*   //COMPARE  EXEC PGM=IKJEFT1A,PARM='ATTLSRPT TN3270'              */
/*   //SYSEXEC  DD   DISP=SHR,DSN=EXEC.LIBRARY                        */
/*   //OUTPUT   DD   SYSOUT=*                                         */
/*   //SYSTSPRT DD   SYSOUT=*                                         */
/*   //SYSTSIN  DD   DUMMY                                            */
/*                                                                    */
/*   Parameters:     OUTPUT DD - Output of inspection                 */
/*                                                                    */
/*   Return:          0 - Successful                                  */
/*                    8 - Unsuccessful. Messages follow.              */
/*                                                                    */
/*   Modifications:   YY/MM/DD - Initials - Description               */
/*                                                                    */
/**********************************************************************/
parse arg appl .

LPAR = mvsvar('sysname')
appl = strip(appl)

"execio 0 diskw OUTPUT (open"
if (rc \= 0) then do
  say "Could not find OUTPUT DD in JCL. RC: "rc
  exit 8
end

x = outtrap(ns.)
"netstat allconn"
rcns = rc
x = outtrap(off)

if (rcns = 0) then do
 do i = 1 to ns.0
  applid = strip(word(ns.i,2))
  connid = strip(word(ns.i,3))
  status = strip(word(ns.i,6))

  if (appl = applid) & (status = 'Establ') then do
   x = outtrap(ttls.)
   "netstat TTLS CONN "connid
   x = outtrap(off)

   do j = 1 to ttls.0
    if (index(ttls.j,'LocalSocket:') > 0) then do
     lsock = word(ttls.j,2)
     dot = index(lsock,'..')
     lsock = substr(lsock,1,dot-1)
    end
    else if (index(ttls.j,'RemoteSocket:') > 0) then do
     rsock = word(ttls.j,2)
     dot = index(rsock,'..')
     rsock = substr(rsock,1,dot-1)
    end
    else if (index(ttls.j,'SecLevel:') > 0) then
     tlsver = strip(substr(ttls.j,16,length(ttls.j)))
    else if (index(ttls.j,'Cipher:') > 0) then do
     cipher = word(ttls.j,3)
     leave
    end
   end

   outrec = left(lsock,15) left(rsock,15) left(cipher,40) tlsver
   push outrec
   "execio 1 diskw OUTPUT"
  end
 end
end
else do
 say "Netstat Command failed."
 exit 8
end

exit 0
