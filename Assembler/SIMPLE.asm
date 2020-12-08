         TITLE 'SIMPLE PROGRAM'
***********************************************************************
*                                                                     *
*            PROGRAM    SIMPLE                                        *
*                                                                     *
*        FUNCTION:      THIS PROGRAM IS A DUMMY PROGRAM THAT DOES     *
*                       NOTHING                                       *
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
SIMPLE   CSECT
         XR    R15,R15        SET RETURN CODE 0
         BR    R14            RETURN TO CALLER
         END
