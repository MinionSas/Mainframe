         TITLE 'PRODUCE AN OUTPUT OF ALL ONLINE DASD'
*
GETVOLS  START 0
*
         SAVE  (14,12)                 ENTRY LINKAGE AND BASE
         BALR  R12,0                     REGISTER ESTABLISHMENT.
         USING *,R12                     .
         ST    R13,SAVEAREA+4            .
         LA    R13,SAVEAREA              .
*
******** PROGRAM INITIALIZATION ***************************************
*
         XC    CCODE,CCODE             CLEAR RETURN CODE.
*
******** SCAN UCB CHAIN ***********************************************
*
         OPEN  (SYSOUT,OUTPUT)
*
*
GETUCB   DS    0H
         IOCINFO IOCTOKEN=TOKEN
         XC    SCANWORK,SCANWORK
UCBLOOP  UCBSCAN COPY,UCBAREA=UCBCOPY,WORKAREA=SCANWORK,DYNAMIC=YES,   X
               RANGE=ALL,IOCTOKEN=TOKEN,                               X
               MF=(E,SCANLIST),DEVCLASS=DASD
         LTR   R15,R15                 ZERO RETURN CODE.
         BZ    LOADUCB                 IS NOT DONE, GO GET A(UCB)
         B     ENDHERE                 ELSE, NOT FOUND.
*
LOADUCB  DS    0H                                                TL99
         LA    R4,UCBCOPY              LOAD A(UCB)               TL99
         USING UCBOB,R4                ADDRESSABILITY.
         TM    UCBSTAT,UCBONLI         IS IT ONLINE?
         BNO   UCBLOOP                 NO, GET NEXT ONE
         CLC   UCBVOLI(6),=6X'00'      REAL DASD?
         BE    UCBLOOP                 NO (DUMMY) - GET NEXT
         AP    VOLCTR,=P'1'            ADD TO VOLUME COUNT.
         MVC   UT2VOL,UCBVOLI          GET UNIT VOLSER.
         $MSG  'VOLUME: ',UT2VOL
         B     UCBLOOP
*
ENDHERE  DS    0H
         $MSG  'ONLINE VOLUME COUNT:    ',VOLCTR
*
         CLOSE (SYSOUT)
*
******** FINISH LINE **************************************************
*
FINISH   LH    R15,CCODE               SET RETURN CODE.
         L     R13,SAVEAREA+4          RESTORE REGISTERS AND END.
         RETURN  (14,12),T,RC=(15)       .
         EJECT
*
******** PROGRAM WORKING STORAGE **************************************
*
SAVEAREA DS    18F
CCODE    DC    H'0'
VOLCTR   DC    PL4'0'                  ON-LINE VOLUME COUNT
TOKEN    DS    CL48
UCBCOPY  DS    CL48
UT2VOL   DS    CL6
LSCAN    UCBSCAN MF=(L,SCANLIST)
SCANWORK DS    CL100
SYSOUT   $MSG  MF=D                    MESSAGE DATASET.
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
