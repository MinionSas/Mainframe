         TITLE 'GET UCB INFORMATION BASED ON DEVICE NUMBER'
*
GETUCBI  START 0
GETUCBI  AMODE  31
GETUCBI  RMODE  ANY
*
         SAVE  (14,12)                 ENTRY LINKAGE AND BASE
         BALR  R12,0                     REGISTER ESTABLISHMENT.
         USING *,R12                     .
         ST    R13,SAVEAREA+4            .
         LA    R13,SAVEAREA              .
*
******** PROGRAM INITIALIZATION ***************************************
*
         XR    R7,R7                   CLEAR RETURN CODE.
*
******** SCAN UCB *****************************************************
*
GETUCB   DS    0H
         MODESET KEY=ZERO,MODE=SUP
         UCBLOOK DEVN=DEVNUM,                                          X
               UCBPTR=UCBPTR,                                          X
               DYNAMIC=YES,                                            X
               RANGE=ALL,                                              X
               LOC=ANY,                                                X
               NOPIN,                                                  X
               RETCODE=RTNCD,                                          X
               RSNCODE=RSNCD,                                          X
               MF=(E,LOOKLIST)
         ST    R15,SAVER15             Stash the RC
         MODESET KEY=NZERO,MODE=PROB
         L     R15,SAVER15
         LTR   R15,R15                 ZERO RETURN CODE.
         BZ    READUCB                 READ THE INFORMATION
         B     BADEND                  ELSE, NOT FOUND.
*
******** READ UCB *****************************************************
*
READUCB  DS    0H
         L     R5,UCBPTR               GET POINTER TO UCB COMMON AREA
         USING UCBCMSEG,R5             Estabilish addressability
         MVC   VOLSER,SRTEVOLI         Move in VOLSER
         MVC   MSG1+4(6),VOLSER
         WTO   MF=(E,MSG1)
         LA    R7,0
         WTO   'GETUCBI was Successful.',                              X
               ROUTCDE=(11),DESC=(7)
         B     FINISH
*
******** BAD END ******************************************************
*
BADEND   DS    0H
         LA    R7,8
         MVC   MSG1+4(8),RTNCD
         MVC   MSG1+14(8),RSNCD
         WTO   MF=(E,MSG1)
         WTO   'Error Occured in GETUCBI.',                            X
               ROUTCDE=(11),DESC=(7)

******** FINISH LINE **************************************************
*
FINISH   LR    R15,R7                  SET RETURN CODE.
         L     R13,SAVEAREA+4          RESTORE REGISTERS AND END.
         RETURN  (14,12),T,RC=(15)      .
         EJECT
*
******** PROGRAM WORKING STORAGE **************************************
*
SAVEAREA DS    18F
UCBPTR   DS    F                      UCB pointer
RTNCD    DS    F                      Return Code
RSNCD    DS    F                      Reason Code
SAVER15  DS    F
DEVNUM   DC    X'0768'
VOLSER   DS    CL8
MSG1     WTO   'AAA                                                    X
               ',MF=L,ROUTCDE=(11),DESC=(7)
GETUCBIL UCBLOOK MF=(L,LOOKLIST)   List form of GETUCBI
*
         EJECT
         CVT   LIST=NO,DSECT=YES
*
         EJECT
         DSECT
         IEFUCBOB LIST=YES
*
******** REGISTER DEFINITIONS *****************************************
*
         EJECT
R0       EQU   0
R1       EQU   1
R2       EQU   2
R3       EQU   3
R4       EQU   4
R5       EQU   5
R6       EQU   6
R7       EQU   7
R8       EQU   8
R9       EQU   9
R10      EQU   10
R11      EQU   11
R12      EQU   12
R13      EQU   13
R14      EQU   14
R15      EQU   15
*
         END
