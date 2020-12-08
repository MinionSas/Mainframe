         TITLE 'ISSUE COMMAND THROUGH EMCS'
***********************************************************************
*                                                                     *
*            PROGRAM    DOCMD                                         *
*                                                                     *
*        FUNCTION:      THIS PROGRAM DOES A COMMAND THROUGH EMCS      *
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
DOCMD    CSECT
DOCMD    AMODE 31
DOCMD    RMODE ANY
         STM   R14,R12,12(R13)
         LR    R12,R15
         USING DOCMD,R12
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
         MODESET MF=(E,SUP)         SET SUP STATE TO ACTIVATE CONSOLE
         MCSOPER REQUEST=ACTIVATE,  ACTIVATE THE CONSOLE               X
                 NAME=CNAME,        ACTIVATE NAME FOUND IN CNAME       X
                 TERMNAME=CNAME,    USE CNAME FOR THE TERMNAME AUDIT   X
                 MSGECB=ECB,        ECB TO BE POSTED WHEN MSG IS QUEUEDX
                 MCSCSA=CSA,        RETURNED STATUS AREA ADDRESS       X
                 MCSCSAA=CSAALET,   RETURNED STATUS AREA ALET          X
                 CONSID=CNID,       RETURNED CONSOLE ID                X
                 RTNCODE=RC,        SAVE RETURN CODE                   X
                 RSNCODE=RSN        SAVE REASON CODE
         MODESET MF=(E,PROB)        BACK TO PROBLEM STATE
         ICM     R15,15,RC          GET RETURN CODE
         BNZ     RETWTOE            IF NO ZERO THEN PROBLEM
         L       R1,L'CMD           OBTAIN LENGTH OF COMMAND
         STH     R1,TEXTLEN         SAVE THE LENGTH IN COMMAND AREA
         MVC     TEXTCMD(L'CMD),CMD PUT THE COMMAND IN THE COMMAND AREA
         MGCRE   TEXT=TEXTAREA,     TEXTAREA CONTAINS THE COMMAND      X
                 CONSID=CNID,       CONSOLE ID                         X
                 CART=USER_DEF_CART COMMAND/RESPON
         LTR     R15,R15
         BNZ     RETWTO2
         MCSOPER REQUEST=DEACTIVATE,  DEACTIVATE THE CONSOLE           X
                 NAME=CNAME           CONSOLE NAME
         B       RETURN
***********************************************************************
*                   PROGRAM EXIT                                      *
***********************************************************************
         SPACE 1
RETWTOE  DS    0H
         WTO   'MCSOPER MACRO FAILED.',ROUTCDE=(11),DESC=(7)
         LA    R15,8
         B     RETURN
RETWTO2  DS    0H
         WTO   'MGCRE FAILED.',ROUTCDE=(11),DESC=(7)
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
* PARAMETER LIST FOR EMCS                                            *
*                                                                    *
**********************************************************************
*
CNAME   DC     C'CONSTST '        CONSOLE NAME TO ACTIVATE
ECB     DC     F'0'               MESSAGE ECB
CSA     DS     A                  ADDR(MCSCSA)
CSAALET DS     F                  ALET(MCSCSA)
CNID    DC     F'0'               CONSOLE ID
RC      DS     F                  RETURN CODE FROM MCSOPER/MCSOPMSG
RSN     DS     F                  REASON CODE FROM MCSOPER/MCSOPMSG
TEXTAREA       DS        0CL128                  COMMAND AREA
TEXTLEN        DS        H                       LENGTH OF COMMAND
TEXTCMD        DS        CL126                   THE COMMAND
CMD            DC        C'D T'
USER_DEF_CART  DS    CL8
SUP     MODESET MODE=SUP,MF=L     MODESET PARM LIST FOR SUP STATE
SUP0    MODESET MODE=SUP,                                              X
               KEY=ZERO,MF=L      MODESET PARM LIST FOR SUP, KEY 0
PROB    MODESET MODE=PROB,                                             X
               KEY=NZERO,MF=L MODESET PARM LIST FOR PROBLEM STATE
**********************************************************************
*                                                                    *
* MODULE ID/REASON CODE/RETURN CODE                                  *
*                                                                    *
**********************************************************************
*
*
         EJECT
         END   DOCMD
