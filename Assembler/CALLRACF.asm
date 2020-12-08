CALLRACF TITLE 'CALLRACF - PROGRAM TO CHECK RACF PROFILE'
***********************************************************************
***********************************************************************
***                                                                 ***
***      MODULE - CALLRACF                                          ***
***                                                                 ***
***      This program is a sample to use when checking a specific   ***
***      RACF resource for access.                                  ***
***                                                                 ***
***      The program checks access to a spcific FACILITY class prof.***
***                                                                 ***
***      If a user has READ access to the profile above they can    ***
***      get RC=0. Otherwise, they get RC=8.                        ***
***                                                                 ***
***      RETURN CODES:                                              ***
***         0  - If user is allowed.                                ***
***         8  - If user is rejected.                               ***
***                                                                 ***
***********************************************************************
***********************************************************************
         EJECT
         SPACE 2
***********************************************************************
***********************************************************************
***                                                                 ***
***      MAPPING MACROS            MACRO LIBRARY                    ***
***      --------------            -------------                    ***
***      IHAACEE                   SYS1.MACLIB                      ***
***                                                                 ***
***      LOAD MODULE NAME          SYSTEM LIBRARY                   ***
***      ----------------          --------------                   ***
***      CALLRACF (RENT)           LINKLIB concatenation            ***
***       AMODE(31) RMODE(ANY)                                      ***
***                                                                 ***
***********************************************************************
***********************************************************************
         EJECT
CALLRACF CSECT ,
CALLRACF AMODE 31
CALLRACF RMODE ANY
CALLRACF CSECT
         STM   R14,R12,12(R13)
         LR    R12,R15
         USING CALLRACF,R12
         LA    R11,SAVEAREA
         ST    R13,4(R11)
         ST    R11,8(R13)
         LR    R13,R11
         XR    R15,R15
         XR    R7,R7               initialize return code register
*
*
* Check RACF authority for user.
*
         RACROUTE REQUEST=AUTH,MF=S,                                   X
               CLASS='FACILITY',                                       X
               ENTITYX=ENTITYX,                                        X
               ATTR=READ,                                              X
               WORKA=RACWORK,                                          X
               RELEASE=7780
         LTR   R15,R15               ACCESS AUTHORIZED?
         BZ    GOODRC                YES...RETURN with RC=0
         EJECT
*
*
* Bad return code 8. User does not have access.
*
         SPACE 1
BADRC    DS    0H
         WTO   'You do not have access.',ROUTCDE=(11),DESC=(7)
         LA    R7,8
         B     RETPGM
         SPACE 1
*
*
* Bad return code 8. User does not exist.
*
         SPACE 1
BADRC2   DS    0H
         WTO   'User ID does not exist.',ROUTCDE=(11),DESC=(7)
         LA    R7,8
         B     RETPGM
         SPACE 1
*
*
* Good return code 0. User does have access.
*
GOODRC   DS    0H
         WTO   'You do have access.',ROUTCDE=(11),DESC=(7)
         LA    R7,0
         SPACE 1
*
*
* return back
*
RETPGM   DS    0H
         LR    R15,R7              copy return code
         L     R13,4(R13)
         L     R14,12(R13)
         LM    R0,R12,20(R13)
         BR    R14
         EJECT
*
*
* static data
*
RACCLASS DC    CL8'FACILITY'                  RACF CLASS
ENTITYX  DC    AL2(0,L'RACPROF)
RACPROF  DC    CL13'BPX.SUPERUSER'            RACF PROFILE
RACWORK  DS    CL512
SAVEAREA DS    18F
*
*
* equates
*
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
         LTORG
*
*
* mappings
*
         END   CALLRACF
