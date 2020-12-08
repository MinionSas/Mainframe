         TITLE '  ASM PARM           '
***********************************************************************
*                                                                     *
*        THIS PROGRAM TAKES SOME PARAMETERS AND DISPLAYS THEM.        *
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
ASMPARM  CSECT
         STM   R14,R12,12(R13)
         LR    R12,R15
         USING ASMPARM,R12
         LA    R11,SAVEAREA
         ST    R13,4(R11)
         ST    R11,8(R13)
         LR    R13,R11
         SPACE 1
         XR    R15,R15                      SET RETURN CODE TO ZERO
         SPACE 1
***********************************************************************
*                   MAIN LOGIC                                        *
***********************************************************************
CODE00   DS    0H
         LR    R11,R1                       SAVE PARM PTR
         LM    R8,R10,0(R11)
*                                       R8  = A(USERID)
*                                       R9  = A(PASSWORD)
*                                       R10 = A(STATUS)
         MVC   USERID,0(R8)
         MVC   PASSWORD,0(R9)
         MVC   MSG1+1(8),USERID
         MVC   MSG1+10(8),PASSWORD
         WTO   MF=(E,MSG1)
         B     RETURN
***********************************************************************
*                   PROGRAM EXIT                                      *
***********************************************************************
BADRET   LA    R15,8
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
PASSWORD DS    CL8
STATUS   DS    CL4
MSG1     WTO   '                          ',MF=L,ROUTCDE=(11),DESC=(7)
SAVEAREA DS    18F
*
         EJECT
         END   ASMPARM
