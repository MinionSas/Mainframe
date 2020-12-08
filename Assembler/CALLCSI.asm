         TITLE 'CHECK CATALOG ENTRY'
***********************************************************************
*                                                                     *
*            PROGRAM    CALLCSI                                       *
*                                                                     *
*        FUNCTION:      THIS PROGRAM CHECKS IF AN ALIAS EXISTS        *
*                                                                     *
*        NOTE:                                                        *
*                                                                     *
*        PARAMETER: NONE                                              *
*                                                                     *
*        CONTROL BLOCKS INVOLVED:                                     *
*           CVT ===> COMMUNICATION VECTOR TABLE                       *
*           PSA ===> PREFIXED SAVE AREA                               *
*                                                                     *
*        RETURN CODE:                                                 *
*           00            SUCCESSFUL RETURN                           *
*                                                                     *
*           04 OR 08      FAILED RETURN                               *
*                                                                     *
*MODIFICATIONS                                                        *
*                                                                     *
* DD/MM/YYYY -IN- -PUT YOUR COMMENT HERE                              *
*                                                                     *
***********************************************************************
         EJECT
R0       EQU   0           *    R
R1       EQU   1           *      E
R2       EQU   2           *        G
R3       EQU   3           *          I
R4       EQU   4           *            S
R5       EQU   5           *              T
R6       EQU   6           *                E
R7       EQU   7           *                  R
R8       EQU   8           *                    S
R9       EQU   9           *    E
R10      EQU   10          *      Q
R11      EQU   11          *        U
R12      EQU   12          *          A
R13      EQU   13          *            T
R14      EQU   14          *              E
R15      EQU   15          *                S
         EJECT
***********************************************************************
*                                                                     *
*                          PROGRAM ENTRY                              *
*                                                                     *
***********************************************************************
         SPACE 1
CALLCSI  CSECT
         STM   R14,R12,12(R13)
         LR    R12,R15
         USING CALLCSI,R12
         LA    R11,SAVEAREA
         ST    R13,4(R11)
         ST    R11,8(R13)
         LR    R13,R11
         SPACE 1
         XR    R15,R15                      SET RETURN CODE TO ZERO
         SPACE 1
***********************************************************************
*  MAIN LOGIC                                                         *
***********************************************************************
MAIN     EQU   *
         LA    R1,PARMLIST
         CALL  IGGCSI00
         LTR   R15,R15                      TEST RETURN CODE
         BZ    RETURN                       IF ZERO THEN ALIAS FOUND
***********************************************************************
*                   PROGRAM EXIT                                      *
***********************************************************************
         SPACE 1
RETWTOE  DS    0H
         WTO   'CSI INTERFACE FAILED',ROUTCDE=(11),DESC=(7)
         LA    R15,8
         SPACE 1
RETURN   DS    0H
         L     R13,4(R13)
         L     R14,12(R13)
         LM    R0,R12,20(R13)
         BR    R14
         EJECT
***********************************************************************
*                  WORKING STORAGE                                    *
***********************************************************************
SAVEAREA DS    18F
         LTORG
         EJECT
**********************************************************************
*                                                                    *
* PARAMETER LIST FOR IGGCSI00 INVOCATION                             *
*                                                                    *
**********************************************************************
*
PARMLIST DS    0D
         DC    A(MODRSNRT)                MODULE/REASON/RETURN
         DC    A(CSIFIELD)
         DC    A(DATAAREA)
**********************************************************************
*                                                                    *
* MODULE ID/REASON CODE/RETURN CODE                                  *
*                                                                    *
**********************************************************************
*
MODRSNRT    DS 0F
PARMRC      DS 0CL4
MODID       DC XL2'0000'     MODULE ID
RSNCODE     DC XL1'00'       REASON CODE
RTNCODE     DC XL1'00'       RETURN CODE
**********************************************************************
*                                                                    *
* PARAMETER FIELDS FOR CATALOG SEARCH INTERFACE (CSI)                *
*                                                                    *
**********************************************************************
*
CSIFIELD    DS 0F
CSIFILTK    DC CL44'ALIASNA'     FILTER   KEY
CSICATNM    DC CL44' '        CATALOG NAME OR BLANKS
CSIRESNM    DC CL44' '        RESUME NAME OR BLANKS
CSIDTYPD    DS 0CL16          ENTRY TYPES
CSIDTYPS    DC CL16'X               '
CSIOPTS     DS 0CL4           CSI OPTIONS
CSICLDI     DC CL1'N'         RETURN D&I IF C A MATCH Y OR BLNK
CSIRESUM    DC CL1' '         RESUME FLAG         Y OR BLANK
CSIS1CAT    DC CL1'Y'         SEARCH CATALOG      Y OR BLANK
CSIRESRV    DC XL1'00'        RESERVED
CSINUMEN    DC H'1'           NUMBER OF ENTRIES FOLLOWING
CSIENTS     DS 0CL8           VARIABLE NUMBER OF ENTRIES FOLLOW
CSIFLDNM    DC CL8'CATTR   '  FIELD NAME
*
DATAAREA DS    0F
         DC    F'65535'
         DS    XL65535
*
DATARET  DSECT
DWORKLEN DS    F
DREQLEN  DS    F
DUSEDLEN DS    F
DPFPLS   DS    H
DCATFLGS DS    CL1
DCATTYPE DS    CL1
DCATNAME DS    CL44
DRETCD   DS    0CL1
DMODID   DS    CL2
DRSNCOD  DS    CL1
DRETCOD  DS    CL1
DATAEND  DS    0F
*
*
         EJECT
         END   CALLCSI
