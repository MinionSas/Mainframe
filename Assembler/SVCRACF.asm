SVCRACF TITLE 'SVCRACF - SKELETON FOR SVCS TO CHECK RACF PROFILE'
***********************************************************************
***********************************************************************
***                                                                 ***
***      MODULE - SVCRACF                                           ***
***                                                                 ***
***      This program is a sample to use when checking a specific   ***
***      RACF resource for access. It should be used as a template  ***
***      for authorization checking to SVCs.                        ***
***                                                                 ***
***      The program checks access to a FACILITY profile SVCCHECK.  ***
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
***                                                                 ***
***      LOAD MODULE NAME          SYSTEM LIBRARY                   ***
***      ----------------          --------------                   ***
***      SVCRACF (RENT)            LINKLIB concatenation            ***
***       AMODE(31) RMODE(ANY)                                      ***
***                                                                 ***
***********************************************************************
***********************************************************************
         EJECT
SVCRACF  CSECT ,
SVCRACF  AMODE 31
SVCRACF  RMODE ANY
SVCRACF  CSECT
         STM   R14,R12,12(R13)
         LR    R12,R15
         USING SVCRACF,R12
         LA    R11,SAVEAREA
         ST    R13,4(R11)
         ST    R11,8(R13)
         LR    R13,R11
         XR    R15,R15
         XR    R7,R7               initialize return code register
*
*
* Get storage for local work area and initialize
*
         USING DYNDAT,R3           establish addressability for DSECT
         GETMAIN RC,LV=DYNDATL,SP=SUBPOOL0,LOC=ANY   get storage
         LTR   R15,R15               Did it work?
         BNZ   BADGET                No, exit the program.
         LR    R3,R1
         MVC   REQAUTHD(REQAUTHL),REQAUTHS
*
*
* Check RACF authority for user.
*
         RACROUTE REQUEST=AUTH,MF=(E,REQAUTHD),                        X
               WORKA=RACWORK,                                          X
               RELEASE=7780
         LTR   R15,R15               ACCESS AUTHORIZED?
         BZ    GOODRC                YES...RETURN with RC=0
         B     BADRC
         EJECT
*
*
* Could not getmain
*
         SPACE 1
BADGET   DS    0H
         WTO   'Could not obtain storage.',ROUTCDE=(11),DESC=(7)
         LA    R7,8
         B     RETPGM
         SPACE 1
*
*
* Bad return code 8. User does not have access.
*
         SPACE 1
BADRC    DS    0H
         WTO   'You do not have access to SVC.',ROUTCDE=(11),DESC=(7)
         LA    R7,8
         B     RETPGM
         SPACE 1
*
*
* Good return code 0. User does have access.
*
GOODRC   DS    0H
         WTO   'You have access to SVC.',ROUTCDE=(11),DESC=(7)
         LA    R7,0
         SPACE 1
*
*
* return back
*
RETPGM   DS    0H
         FREEMAIN RC,LV=DYNDATL,A=(R3),SP=SUBPOOL0
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
RACPROF  DC    CL8'SVCCHECK'                  RACF PROFILE
SAVEAREA DS    18F
REQAUTHS RACROUTE REQUEST=AUTH,MF=L,                                   X
               CLASS='FACILITY',                                       X
               ENTITYX=ENTITYX,                                        X
               ATTR=READ,                                              X
               RELEASE=7780
REQAUTHL EQU   *-REQAUTHS
*
*
* Dynamic data
*
DYNDAT   DSECT
SUBPOOL0 EQU   0
REQAUTHD RACROUTE REQUEST=AUTH,MF=L,                                   X
               CLASS='FACILITY',                                       X
               ENTITYX=ENTITYX,                                        X
               ATTR=READ,                                              X
               RELEASE=7780
RACWORK  DS    CL512
DYNDATL  EQU   *-DYNDAT
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
         END   SVCRACF
