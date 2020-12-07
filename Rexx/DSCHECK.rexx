/******************************* rexx *********************************/
/*   Program Name:    DSCHECK                                         */
/*                                                                    */
/*   Description:     This exec checks a list of datasets and verifies*/
/*                    if the provided dataset list resides on the     */
/*                    correct list of volumes specified through a     */
/*                    volume list.                                    */
/*                                                                    */
/*   Invocation:      Batch                                           */
/*                                                                    */
/*   //CHECKDS  EXEC PGM=IKJEFT1A,PARM='DSCHECK'                      */
/*   //SYSEXEC  DD   DISP=SHR,DSN=YOUR-EXEC-LIBRARY                   */
/*   //SYSTSPRT DD   SYSOUT=*                                         */
/*   //SYSTSIN  DD   DUMMY                                            */
/*   //ERRORS   DD   SYSOUT=*                                         */
/*   //VOLIST   DD   *                                                */
/*   PHDA                                                             */
/*   PHDB                                                             */
/*   PHLO                                                             */
/*   PHP                                                              */
/*   //DSLIST   DD   *                                                */
/*   PROD.XXXXXXX                                                     */
/*                                                                    */
/*   Return:          0 - successful                                  */
/*                    8 - dataset not found or on incorrect volume    */
/*                                                                    */
/**********************************************************************/

rcJob = 0
errors.0 = 0
ex = errors.0

"execio * diskr DSLIST (stem dsList. finis)"
if (rc > 0) then do
  say 'Please specify a Dataset list through DSLIST DD'
  exit 8
end

"execio * diskr VOLIST (stem volList. finis)"
if (rc > 0) then do
  say 'Please specify a Valid Volume list through VOLIST DD'
  exit 8
end

say left('DSNAME',44) 'VOLSER'
say left('',44,'=') left('',6,'=')

do y = 1 to dsList.0
  if (substr(dsList.y,1,1) \= '*') then do
    hlq = strip(dsList.y)

    x = outtrap(listc.)
    "listcat entries('"hlq"') volume"
    listrc = rc
    xx = outtrap(off)

    if (listrc = 0) then do
      do i = 1 to listc.0
        volFlag = 0

        if index(listc.i,'NONVSAM --') > 0 | ,
           index(listc.i,'DATA --') > 0 | ,
           index(listc.i,'INDEX --') > 0 then do
           dsName = word(listc.i,3)
        end

        if index(listc.i,'VOLSER-') > 0 then do
          dsVolLine = word(listc.i,1)
          lineLength = length(dsVolLine)
          dsVol = substr(dsVolLine,lineLength - 5)

          if (dsVol \= '-----*') then
            volFlag = 1
        end

        if (volFlag = 1) then do
          volFound = 0
          say left(dsName,44) dsVol
          do zz = 1 to volList.0
            if index(dsVol,strip(volList.zz)) > 0 then do
              volFound = 1
              zz = volList.0
            end
          end

          if (volFound = 0) then do
            rcJob = 8
            say 'Dataset 'dsName' is not on a valid Prod volume 'dsVol
            ex = errors.0 + 1
            errors.ex = 'Dataset ' || dsName || ,
                        ' is not on a valid Prod volume ' || dsVol
            errors.0 = ex
          end
        end
      end
    end
    else do
      say 'Dataset 'hlq' not found.'
      ex = errors.0 + 1
      errors.ex = 'Dataset ' || hlq || ' not found.'
      errors.0 = ex
      rcJob = 8
    end
  end
end

"execio * diskw ERRORS (stem errors. finis)"

exit rcJob
