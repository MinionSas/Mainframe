/******************************* rexx *********************************/
/*   Program Name:    ISDAY                                           */
/*   Date:            Dec 2019                                        */
/*                                                                    */
/*   Description:     This program checks the day of the week and     */
/*                    compares it to the argument provided. If it's   */
/*                    the date passed then it returns with RC=2,      */
/*                    otherwise it's RC=0                             */
/*                                                                    */
/*   Invocation:      Batch (PGM=IKJEFT1A)                            */
/*                                                                    */
/*   Return Code:     0 - Different day from argument                 */
/*                    2 - Same day as argument                        */
/*                                                                    */
/**********************************************************************/
/*                                                                    */
/*   Modifications:   yy/mm/dd - in - description                     */
/*                                                                    */
/**********************************************************************/
parse arg day .

dayofweek = translate(date('W'))
say 'Today is 'dayofweek

if (day = dayofweek) then do
 exit 2
end

exit 0
