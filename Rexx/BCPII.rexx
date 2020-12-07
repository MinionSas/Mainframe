/* rexx */

"ALLOC F(HWICIREX) DA('SYS1.MACLIB(HWICIREX)') SHR REUS"
"execio * diskr "HWICIREX" (stem  linelist.  finis   "
"FREE F(HWICIREX)"
do x = 1 to linelist.0
  interpret linelist.x
end
drop linelist.

"ALLOC F(HWIC2REX) DA('SYS1.MACLIB(HWIC2REX)') SHR REUS"
"execio * diskr "HWIC2REX" (stem  linelist.  finis   "
"FREE F(HWIC2REX)"
do x = 1 to linelist.0
  interpret linelist.x
end
drop linelist.


/* Enable 'address bcpii' for ISV REXX environments                  */
rc=HWIHOST('ON')

ListType = HWI_LIST_CPCS
CPCList. = 'CPC names will be listed here'
address bcpii "hwilist ",
              "ReturnCode ",
              "ConnectToken ",
              "ListType ",
              "CPCList. ",
              "DiagArea."

REXXHostRc = RC
say '        REXXHostRc  = ' d2x(REXXHostRc)
say '        HWILIST rc  = ' d2x(ReturnCode)

If REXXHostRC <>0 | ReturnCode <> 0 then do
    say '        DiagArea.Diag_Index    = '  DiagArea.Diag_Index
    say '        DiagArea.Diag_Key      = '  DiagArea.Diag_Key
    say '        DiagArea.Diag_Actual   = '  DiagArea.Diag_Actual
    say '        DiagArea.Diag_Expected = '  DiagArea.Diag_Expected
    say '        DiagArea.Diag_CommErr  = '  DiagArea.Diag_CommErr
    say '        DiagArea.Diag_Text     = '  DiagArea.Diag_Text
    say
end
else do
 /* ----------------------------------------------------------- */
 /* Report the number of CPCs returned.                         */
 /* ----------------------------------------------------------- */
 say '        Number of CPCs found = 'CPCList.0
 say

 /* ----------------------------------------------------------- */
 /* Write the list of CPCs returned.                            */
 /* ----------------------------------------------------------- */
 Do i = 1 to CPCList.0
   say '        CPC 'i' = 'CPCList.i
   call ConnecttoCPC CPCList.i
   If REXXHostRC = 0 & ReturnCode = 0 Then do
    call QueryCPCAttr CPCConnectToken
    call ListImages CPCConnectToken
    If REXXHostRC = 0 & ReturnCode = 0 Then do
     Do j = 1 to ImageList.0
      call ConnectToImage CPCConnectToken, ImageList.j
      If REXXHostRC = 0 & ReturnCode = 0 Then do
       call QueryIMAGEAttr ImageConnectToken
       call ReleaseConnection 'Image', ImageConnectToken
      end
     end
    end
   end
   call ReleaseConnection 'CPC', CPCConnectToken
 End
 say
end

exit 0

/* ================================================================ */
/* ConnectToCPC                                                     */
/*                                                                  */
/*  Call HWICONN to connect to a CPC to obtain a connect token.     */
/*                                                                  */
/* ================================================================ */
ConnectToCPC:

 PARSE ARG ConnectTypeValue

 /* InConnectToken is ignored when connecting to a CPC.             */
 /* --------------------------------------------------------------- */

 /* --------------------------------------------------------------- */
 /* Set HWICONN parameters.                                         */
 /* --------------------------------------------------------------- */
 ConnectType = HWI_CPC

 /* --------------------------------------------------------------- */
 /* Call HWICONN.                                                   */
 /* --------------------------------------------------------------- */
 say ' =>> HWICONN - Connect to CPC 'ConnectTypeValue         /*@01C*/

 address bcpii "hwiconn ",
               "ReturnCode ",
               "InConnectToken ",
               "OutConnectToken ",
               "ConnectType ",
               "ConnectTypeValue ",
               "DiagArea."                                    /*@03C*/

 /* --------------------------------------------------------------- */
 /* Save value returned as REXX special variable, RC.               */
 /* --------------------------------------------------------------- */
 REXXHostRc = RC

 /* --------------------------------------------------------------- */
 /* Report HWICONN results.                                         */
 /* --------------------------------------------------------------- */
 say '        REXXHostRc  = ' d2x(REXXHostRc)
 say '        HWICONN rc  = ' d2x(ReturnCode)
 say

 /* --------------------------------------------------------------- */
 /* If HWICONN fails, report diagnostic information.                */
 /* --------------------------------------------------------------- */
 If REXXHostRC <>0 | ReturnCode <> 0 Then
   Do
     say '        DiagArea.Diag_Index    = '  DiagArea.Diag_Index
     say '        DiagArea.Diag_Key      = '  DiagArea.Diag_Key
     say '        DiagArea.Diag_Actual   = '  DiagArea.Diag_Actual
     say '        DiagArea.Diag_Expected = '  DiagArea.Diag_Expected
     say '        DiagArea.Diag_CommErr  = '  DiagArea.Diag_CommErr
     say '        DiagArea.Diag_Text     = '  DiagArea.Diag_Text
     say
   End
 Else
   Do
     CPCConnectToken = OutConnectToken
   End

return /* end ConnectToCPC */

/* ================================================================ */
/* QueryCPCAttr                                                     */
/*                                                                  */
/*  Call HWIQUERY to retrieve SE/HMC managed data for a CPC         */
/*  which is represented by the input connect token.                */
/*                                                                  */
/*  By changing the query parm, you may change or add any           */
/*  attributes to retrieve.                                         */
/*                                                                  */
/*  The following steps are necessary to change the query           */
/*  parameters:                                                     */
/*    1. Declare the attribute values                               */
/*    2. Set the number of the attributes for the request           */
/*    3. Set the query parm                                         */
/*                                                                  */
/* ================================================================ */

QueryCPCAttr:

 PARSE ARG ConnectToken


 say ' =>> HWIQUERY - Query CPC attributes '                  /*@01C*/
 /* --------------------------------------------------------------- */
 /* Build QueryParm structure to query CPC attributes.  QueryParm   */
 /* index 0 contains the number of attributes to be queried.        */
 /* --------------------------------------------------------------- */
 QueryParm.0 = 3

 QueryParm.1.ATTRIBUTEIDENTIFIER = HWI_MMODEL
 QueryParm.2.ATTRIBUTEIDENTIFIER = HWI_SNAADDR
 QueryParm.3.ATTRIBUTEIDENTIFIER = HWI_NUMGPP                 /*@01A*/

 /* --------------------------------------------------------------- */
 /* Call HWIQUERY.                                                  */
 /* --------------------------------------------------------------- */
 address bcpii "hwiquery ",
               "ReturnCode ",
               "ConnectToken ",
               "QueryParm. ",
               "DiagArea."                                    /*@03C*/

 /* --------------------------------------------------------------- */
 /* Save value returned as REXX special variable, RC.               */
 /* --------------------------------------------------------------- */
 REXXHostRc = RC

 /* --------------------------------------------------------------- */
 /* Report HWIQUERY results.                                        */
 /* --------------------------------------------------------------- */
 say '        REXXHostRc  = ' d2x(REXXHostRc)
 say '        HWIQUERY rc = ' d2x(ReturnCode)
 say

 /* --------------------------------------------------------------- */
 /* If HWIQUERY fails, report diagnostic information.               */
 /* --------------------------------------------------------------- */
 If REXXHostRC <>0 | ReturnCode <> 0 Then
   Do
     say '        DiagArea.Diag_Index    = '  DiagArea.Diag_Index
     say '        DiagArea.Diag_Key      = '  DiagArea.Diag_Key
     say '        DiagArea.Diag_Actual   = '  DiagArea.Diag_Actual
     say '        DiagArea.Diag_Expected = '  DiagArea.Diag_Expected
     say '        DiagArea.Diag_CommErr  = '  DiagArea.Diag_CommErr
     say '        DiagArea.Diag_Text     = '  DiagArea.Diag_Text
     say
   End
 Else                                                         /*@01A*/
   Do                                                         /*@01A*/
    /* ------------------------------------------------------------ */
    /* Report the returned attribute values.                        */
    /* ------------------------------------------------------------ */
    say '      > Model Number is ' QueryParm.1.ATTRIBUTEVALUE /*@01C*/
    say '      > SNA Addr is     ' QueryParm.2.ATTRIBUTEVALUE /*@01C*/
    say '      > Num GPP is      ' QueryParm.3.ATTRIBUTEVALUE /*@01A*/
    say
   End                                                        /*@01A*/

return /* end QueryCPCAttr */

/* ================================================================ */
/* ListImages                                                       */
/*                                                                  */
/*  Call HWILIST to list the images on the CPC that is represented  */
/*  by the input connect token.  Save the returned list in          */
/*  List_of_Images array.                                           */
/*                                                                  */
/* ================================================================ */
ListImages:

 PARSE ARG ConnectToken

 /* --------------------------------------------------------------- */
 /* Report HWILIST is starting.                                     */
 /* --------------------------------------------------------------- */
 say ' =>> HWILIST - List images '                            /*@01C*/

 /* --------------------------------------------------------------- */
 /* Set HWILIST parameters.                                         */
 /* --------------------------------------------------------------- */
 ListType = HWI_LIST_IMAGES

 /* --------------------------------------------------------------- */
 /* Initialize AnswerArea.                                          */
 /* --------------------------------------------------------------- */
 ImageList. = 'Image names will be listed here'

 /* --------------------------------------------------------------- */
 /* Call HWILIST.                                                   */
 /* --------------------------------------------------------------- */
 address bcpii "hwilist ",
               "ReturnCode ",
               "ConnectToken ",
               "ListType ",
               "ImageList. ",
               "DiagArea."                                    /*@03C*/

 /* --------------------------------------------------------------- */
 /* Save value returned as REXX special variable, RC.               */
 /* --------------------------------------------------------------- */
 REXXHostRc = RC

 /* --------------------------------------------------------------- */
 /* Report HWILIST results.                                         */
 /* --------------------------------------------------------------- */
 say '        REXXHostRc  = ' d2x(REXXHostRc)
 say '        HWILIST rc  = ' d2x(ReturnCode)
 say

 /* --------------------------------------------------------------- */
 /* If HWILIST fails, report diagnostic information.                */
 /* --------------------------------------------------------------- */
 If REXXHostRC <>0 | ReturnCode <> 0 Then
   Do
     say '        DiagArea.Diag_Index    = '  DiagArea.Diag_Index
     say '        DiagArea.Diag_Key      = '  DiagArea.Diag_Key
     say '        DiagArea.Diag_Actual   = '  DiagArea.Diag_Actual
     say '        DiagArea.Diag_Expected = '  DiagArea.Diag_Expected
     say '        DiagArea.Diag_CommErr  = '  DiagArea.Diag_CommErr
     say '        DiagArea.Diag_Text     = '  DiagArea.Diag_Text
     say
     ImageList.0=0
   End

 Else
   Do /* images returned */
     /* ----------------------------------------------------------- */
     /* Report the number of images returned.                       */
     /* ----------------------------------------------------------- */
     say '        Number of images found = 'ImageList.0       /*@01C*/
     say

     /* ----------------------------------------------------------- */
     /* Write the list of images returned.                          */
     /* ----------------------------------------------------------- */
     Do j = 1 to ImageList.0
       say '        Image 'j' = 'ImageList.j                  /*@01C*/
     End
     say
   End /* end images returned */

return /* end ListImages */

/* ================================================================ */
/* QueryIMAGEAttr                                                   */
/*                                                                  */
/*  Call HWIQUERY to retrieve SE/HMC managed data for an image      */
/*  which is represented by the input connect token.                */
/*                                                                  */
/*  By changing the query parm, you may change or add any           */
/*  attributes to retrieve.                                         */
/*                                                                  */
/*  The following steps are necessary to change the query           */
/*  parameters                                                      */
/*    1. Declare the attribute values                               */
/*    2. Set the number of the attributes for the request           */
/*    3. Set the query parm                                         */
/*                                                                  */
/* ================================================================ */

QueryIMAGEAttr:

 PARSE ARG ConnectToken

 /* --------------------------------------------------------------- */
 /* Report HWIQUERY is starting.                                    */
 /* --------------------------------------------------------------- */
 say ' =>> HWIQUERY - Query image attributes   '              /*@01A*/

 /* --------------------------------------------------------------- */
 /* Build a QueryParm structure to query an image attribute.        */
 /* QueryParm index 0 contains the number of attributes to be       */
 /* queried.                                                        */
 /* --------------------------------------------------------------- */
 QueryParm.0 = 2

 QueryParm.1.ATTRIBUTEIDENTIFIER = HWI_OSTYPE
 QueryParm.2.ATTRIBUTEIDENTIFIER = HWI_MSGSTAT

 /* --------------------------------------------------------------- */
 /* Call HWIQUERY.                                                  */
 /* --------------------------------------------------------------- */
 address bcpii "hwiquery ",
               "ReturnCode ",
               "ConnectToken ",
               "QueryParm. ",
               "DiagArea."                                    /*@03C*/

 /* --------------------------------------------------------------- */
 /* Save value returned as REXX special variable, RC.               */
 /* --------------------------------------------------------------- */
 REXXHostRc = RC

 /* --------------------------------------------------------------- */
 /* Report HWIQUERY results.                                        */
 /* --------------------------------------------------------------- */
 say '        REXXHostRc  = ' d2x(REXXHostRc)
 say '        HWIQUERY rc = ' d2x(ReturnCode)
 say

 /* --------------------------------------------------------------- */
 /* If HWIQUERY fails, report diagnostic information.               */
 /* --------------------------------------------------------------- */
 If REXXHostRC <>0 | ReturnCode <> 0 Then
   Do
     say '        DiagArea.Diag_Index    = '  DiagArea.Diag_Index
     say '        DiagArea.Diag_Key      = '  DiagArea.Diag_Key
     say '        DiagArea.Diag_Actual   = '  DiagArea.Diag_Actual
     say '        DiagArea.Diag_Expected = '  DiagArea.Diag_Expected
     say '        DiagArea.Diag_CommErr  = '  DiagArea.Diag_CommErr
     say '        DiagArea.Diag_Text     = '  DiagArea.Diag_Text
     say
   End
 Else                                                         /*@01A*/
   Do                                                         /*@01A*/
    /* ------------------------------------------------------------ */
    /* Report the returned attribute values.                        */
    /* ------------------------------------------------------------ */
    say '      > OS Type is    ' QueryParm.1.ATTRIBUTEVALUE   /*@01C*/
    say '      > MSG STAT is   ' QueryParm.2.ATTRIBUTEVALUE   /*@01A*/
    say
   End

return /* end QueryIMAGEAttr */

/* ================================================================ */
/* ReleaseConnection                                                */
/*                                                                  */
/*  Call HWIDISC to disconnect a connection which is represented    */
/*  by the input connect token.                                     */
/*                                                                  */
/* ================================================================ */

ReleaseConnection:

 PARSE ARG ReleaseType, ConnectToken

 /* --------------------------------------------------------------- */
 /* Report HWIDISC is starting.                                     */
 /* --------------------------------------------------------------- */
 say ' =>> HWIDISC - Release 'ReleaseType' connection '       /*@01C*/
 /* --------------------------------------------------------------- */
 /* Call HWIDISC.                                                   */
 /* --------------------------------------------------------------- */
 address bcpii "hwidisc ",
               "ReturnCode ",
               "ConnectToken ",
               "DiagArea."                                    /*@03C*/

 /* --------------------------------------------------------------- */
 /* Save value returned as REXX special variable, RC.               */
 /* --------------------------------------------------------------- */
 REXXHostRc = RC

 /* --------------------------------------------------------------- */
 /* Report HWIDISC results.                                         */
 /* --------------------------------------------------------------- */
 say '        REXXHostRc  = ' d2x(REXXHostRc)
 say '        HWIDISC rc  = ' d2x(ReturnCode)
 say

 /* --------------------------------------------------------------- */
 /* If HWIDISC fails, report diagnostic information.                */
 /* --------------------------------------------------------------- */
 If REXXHostRC <>0 | ReturnCode <> 0 Then
   Do;
     say '        DiagArea.Diag_Index    = '  DiagArea.Diag_Index
     say '        DiagArea.Diag_Key      = '  DiagArea.Diag_Key
     say '        DiagArea.Diag_Actual   = '  DiagArea.Diag_Actual
     say '        DiagArea.Diag_Expected = '  DiagArea.Diag_Expected
     say '        DiagArea.Diag_CommErr  = '  DiagArea.Diag_CommErr
     say '        DiagArea.Diag_Text     = '  DiagArea.Diag_Text
   End;

return /* end ReleaseConnection */

/* ================================================================ */
/* ConnectToImage                                                   */
/*                                                                  */
/*  Call HWICONN to connect to an image.                            */
/*                                                                  */
/* ================================================================ */

ConnectToImage:

 PARSE ARG InConnectToken, ConnectTypeValue


 /* --------------------------------------------------------------- */
 /* Set HWICONN parameters.                                         */
 /* --------------------------------------------------------------- */
 ConnectType = HWI_IMAGE

 /* --------------------------------------------------------------- */
 /* Call HWICONN.                                                   */
 /* --------------------------------------------------------------- */
 say ' =>> HWICONN - Connect to image 'ConnectTypeValue       /*@01C*/

 address bcpii "hwiconn ",
               "ReturnCode ",
               "InConnectToken ",
               "OutConnectToken ",
               "ConnectType ",
               "ConnectTypeValue ",
               "DiagArea."                                    /*@03C*/

 /* --------------------------------------------------------------- */
 /* Save value returned as REXX special variable, RC.               */
 /* --------------------------------------------------------------- */
 REXXHostRc = RC

 /* --------------------------------------------------------------- */
 /* Report HWICONN results.                                         */
 /* --------------------------------------------------------------- */
 say '        REXXHostRc  = ' d2x(REXXHostRc)
 say '        HWICONN rc  = ' d2x(ReturnCode)
 say

 /* --------------------------------------------------------------- */
 /* If HWICONN fails, report diagnostic information.                */
 /* --------------------------------------------------------------- */
 If REXXHostRC <>0 | ReturnCode <> 0 Then
   Do
     say '        DiagArea.Diag_Index    = '  DiagArea.Diag_Index
     say '        DiagArea.Diag_Key      = '  DiagArea.Diag_Key
     say '        DiagArea.Diag_Actual   = '  DiagArea.Diag_Actual
     say '        DiagArea.Diag_Expected = '  DiagArea.Diag_Expected
     say '        DiagArea.Diag_CommErr  = '  DiagArea.Diag_CommErr
     say '        DiagArea.Diag_Text     = '  DiagArea.Diag_Text
     say
   End
 Else
   ImageConnectToken = OutConnectToken

return /* end ConnectToImage */

