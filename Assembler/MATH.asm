         TITLE 'MATH PROGRAM'
***********************************************************************
*                                                                     *
*            PROGRAM    MATH                                          *
*                                                                     *
*        FUNCTION:      THIS IS A SIMPLE MATH PROGRAM                 *
*                                                                     *
*        NOTE: MATH    CAN RESIDE ANYWHERE IN MEMORY                  *
*                                                                     *
*        PARAMETER: NONE                                              *
*                                                                     *
*        RETURN CODE:                                                 *
*           00            SUCCESSFUL RETURN                           *
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
MATH     CSECT
         STM   R14,R12,12(R13)
         LR    R12,R15
         USING MATH,R12
         LA    R11,SAVEAREA
         ST    R13,4(R11)
         ST    R11,8(R13)
         LR    R13,R11
         SPACE 1
         XR    R15,R15                      SET RETURN CODE TO ZERO
         SPACE 1
***********************************************************************
* MATH FUNCTIONS                                                      *
***********************************************************************
         LA    R2,10                  INITIALIZE R2 TO 10
         LA    R3,10                  INITIALIZE R3 TO 10
         AR    R2,R3                  ADD THE 2 REGISTERS
         S     R2,NUMBER1             SUBTRACT NUMBER1 FROM R2
         MR    R2,R3                  MULTIPLY R2 AND R3
         DR    R2,R3                  DIVIDE R2 BY R3
***********************************************************************
*                   PROGRAM EXIT                                      *
***********************************************************************
RETURN   DS    0H
         L     R13,4(R13)
         L     R14,12(R13)
         LM    R0,R12,20(R13)
         BR    R14
         EJECT
***********************************************************************
*                  WORKING STORAGE                                    *
***********************************************************************
NUMBER1  DC    F'14'
SAVEAREA DS    18F
         LTORG
         EJECT
         END   MATH
