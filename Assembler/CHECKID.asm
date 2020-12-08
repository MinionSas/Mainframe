         TITLE 'CHECK USERID PROGRAM'
***********************************************************************
*                                                                     *
*            PROGRAM    CHECKID                                       *
*                                                                     *
*        FUNCTION:      THIS PROGRAM CHECKS A USER ID OF BATCH JOB    *
*                                                                     *
*        NOTE: TESTPGM CAN RESIDE ANYWHERE IN MEMORY                  *
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
CHECKID  CSECT
         STM   R14,R12,12(R13)
         LR    R12,R15
         USING CHECKID,R12
         LA    R11,SAVEAREA
         ST    R13,4(R11)
         ST    R11,8(R13)
         LR    R13,R11
         SPACE 1
         XR    R15,R15                      SET RETURN CODE TO ZERO
         SPACE 1
***********************************************************************
*                                                                     *
***********************************************************************
         L     R15,PSAAOLD-PSA         LOAD A(ASCB)
         L     R15,ASCBASXB-ASCB(,R15)    A(ASXB) AND
         L     R15,ASXBSENV-ASXB(,R15)       A(ACEE)
         LTR   R15,R15
         BZ    RETWTOE
         MVC   USERID,ACEEUSRI-ACEE(R15) GET USERID
         MVC   GRPID,ACEEGRPN-ACEE(R15) GET GROUP ID
         EJECT
***********************************************************************
* SCAN USER TABLE TO VERIFY AUTHENTICATION
***********************************************************************
         XR    R8,R8                        SET R8 TO ZERO
         LA    R8,AUTHNAME                  LOAD ADDR OF AUTH NAMES
AUTHLOOP CLI   0(R8),X'FF'                  END OF AUTHNAME TABLE?
         BE    RETWTOE                      YES, GET OUT
         CLC   0(8,R8),GRPID                SEE IF RACF GROUP IN TABLE
         BE    RETWTO1                      YES, GO DO THE REST
         CLC   0(8,R8),USERID               IS THIS USER IN THE TABLE
         BE    RETWTO1                      YES, GO DO THE REST
         LA    R8,8(,R8)                    INCREMENT TO NEXT ENTRY
         B     AUTHLOOP                     LOOP UNTIL DONE
***********************************************************************
*                   PROGRAM EXIT                                      *
***********************************************************************
         SPACE 1
RETWTO1  DS    0H
         MVC   MSG1+4(8),USERID
         MVC   MSG1+14(8),GRPID
         WTO   MF=(E,MSG1)
         B     RETURN
         SPACE 1
RETWTOE  DS    0H
         WTO   'USERID NOT FOUND.',ROUTCDE=(11),DESC=(7)
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
USERID   DS    CL8
GRPID    DS    CL8
AUTHNAME DS    0CL8
         DC    CL8'USERID1'
AUTHNEND DC    8XL1'FF'
MSG1     WTO   '                                                       X
               ',MF=L,ROUTCDE=(11),DESC=(7)
SAVEAREA DS    18F
         LTORG
         EJECT
***********************************************************************
*           COMMUNICATION VECTOR TABLE (CVT) DUMMY SECTION            *
***********************************************************************
         CVT   DSECT=YES
         EJECT
***********************************************************************
*           PREFIXED SAVE AREA (PSA) DUMMY SECTION                    *
***********************************************************************
         IHAACEE                        ACEE
         IHAPSA                         PSA
         IHAASCB                        ASCB
         IHAASXB                        ASXB
         IKJTCB                         TCB
         EJECT
         END   CHECKID
