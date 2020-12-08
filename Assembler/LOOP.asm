         TITLE 'LOOP PROGRAM'
***********************************************************************
*                                                                     *
*            PROGRAM    LOOP                                          *
*                                                                     *
*        FUNCTION:      THIS IS A SIMPLE LOOP PROGRAM                 *
*                                                                     *
*        NOTE: LOOP    CAN RESIDE ANYWHERE IN MEMORY                  *
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
LOOP     CSECT
         STM   R14,R12,12(R13)
         LR    R12,R15
         USING LOOP,R12
         LA    R11,SAVEAREA
         ST    R13,4(R11)
         ST    R11,8(R13)
         LR    R13,R11
         SPACE 1
         XR    R15,R15                      SET RETURN CODE TO ZERO
         SPACE 1
***********************************************************************
* SIMPLE LOOP FROM 0 TO 10                                            *
***********************************************************************
         LA    R2,0                   INITIALIZE COUNTER TO 0
MYLOOP   AHI   R2,1                   ADD 1 TO COUNTER
         WTO   'HELLO'                SAY HELLO
         CHI   R2,10                  IS THE COUNTER 10?
         BL    MYLOOP                 IF LESS THAN 10, LOOP AGAIN
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
SAVEAREA DS    18F
         LTORG
         EJECT
         END   LOOP
