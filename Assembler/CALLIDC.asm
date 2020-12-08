         TITLE 'CALL IDCAMS'
***********************************************************************
*                                                                     *
*            PROGRAM    CALLIDC                                       *
*                                                                     *
*        FUNCTION:      THIS PROGRAM TESTS A CALL TO IDCAMS           *
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
CALLIDC  CSECT
         STM   R14,R12,12(R13)
         LR    R12,R15
         USING CALLIDC,R12
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
         ST    R13_32,IOLIST+12             SYSIN DATA
         LINK  EP=IDCAMS,                                              X
               PARAM=(IDCAMSPRM,DDNAMES,PAGELIST,IOLIST),              X
               VL=1
         LTR   R15,R15                      TEST RETURN CODE
         BZ    RETURN                       IF ZERO THEN ALIAS FOUND
***********************************************************************
*                   PROGRAM EXIT                                      *
***********************************************************************
         SPACE 1
RETWTOE  DS    0H
         WTO   'IDCAMS FAILED',ROUTCDE=(11),DESC=(7)
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
* PARAMETER LIST FOR IDCAMS                                          *
*                                                                    *
**********************************************************************
*
IDCAMSADR   DC A(IDCAMSPRM)
IDCAMSPRM   DC H'0'
DDNAMES     DC H'0'
PAGELIST    DC H'0'
IOLIST      DC F'1'               ONE GROUP OF I/O LISTS FOLLOW
            DC A(SYSINID)         POINTER TO ID FOR SYSIN
            DC A(IOROUT)          POINTER TO I/O ROUTINE
            DC A(USRDATA)         ADDR OF USER DATA AREA
SYSINID     DC CL10'DDSYSIN   '   INDICATE WE WISH TO MANAGE SYSIN
USRDATA  DC    2F'0'              USER DATA AREA
**********************************************************************
*                                                                    *
* MODULE ID/REASON CODE/RETURN CODE                                  *
*                                                                    *
**********************************************************************
*
*
         EJECT
         END   CALLIDC
