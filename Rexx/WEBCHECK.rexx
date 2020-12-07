/******************************* rexx *********************************/
/*   Program Name:    WEBCHECK                                        */
/*                                                                    */
/*   Description:     This program takes a list of URLs and verifies  */
/*                    if a URL is OK (i.e. HTTP 200  status code)     */
/*                    The program uses cURL to test the URL.          */
/*                                                                    */
/*   Invocation:      Batch (PGM=IKJEFT01)                            */
/*                                                                    */
/*   Input:          INPUT  DD - List of URLs                         */
/*                                                                    */
/*   Output:          SYSOUT                                          */
/*                                                                    */
/*   Return Code:     0 - Successful                                  */
/*                    8 - Something with a URL not right              */
/*                                                                    */
/*--------------------------------------------------------------------*/
/*   MODIFICATIONS:                                                   */
/*--------------------------------------------------------------------*/
/*                                                                    */
/**********************************************************************/
exitcode = 0

"execio 0 diskr INPUT (open"
if (rc \= 0) then do
  msg = "Could not open INPUT DD in JCL. RC: "rc
  exit 8
end

EOF = 'NO'
do While EOF='NO'
  "execio 1 diskr INPUT"
  if (rc <> 0) then EOF = 'YES'
  else do
    parse pull url
    url = strip(url)
    if (word(url,1) = '*') then iterate

    cmd = '/usr/lpp/tools/bin/curl -k -I 'url
    if usscmd(cmd,cmdout.) = 0 then do
     if (strip(word(cmdout.1,2)) = '200') then do
      say 'URL is OK: 'url
     end
     else do
      say 'Status 'strip(cmdout.1)'. URL not OK: 'url
      exitcode = 8
     end
    end
    else do
     say 'Issue with cURL command: 'cmd
     exitcode = 8
    end
  end
end

exit exitcode

/**********************************************************************/
/*                                                                    */
/*  Name:         ussCMD                                              */
/*  Summary:      Subroutine to execute a USS command.                */
/*  Parameters:   argument 1:  the command to be executed             */
/*                argument 2:  the output for the command             */
/*  Return:       0 - Successful                                      */
/*                8 - Unsucessful                                     */
/*                                                                    */
/**********************************************************************/
ussCMD:
  env.0 = 2
  env.1 = '_BPX_SHAREAS=YES'
  env.2 = '_BPX_SPAWN_SCRIPT=NO'

  rcUSS = bpxwunix(arg(1),,''arg(2)'','err.','env.')
  if rcUSS <> 0 then do
     say ''
     say 'Command failed with RC: 'rcUSS
     say ''
     do i = 1 to err.0
        say err.i
     end
  end
return rcUSS
