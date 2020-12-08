RACFCMDS TITLE 'RACFCMDS - IRREVX01 EXIT ROUTINE'
***********************************************************************
***********************************************************************
***                                                                 ***
***      MODULE - RACFCMDS                                          ***
***                                                                 ***
***      An IRREVX01 command exit routine                           ***
***                                                                 ***
***      This exit is invoked with most RACF commands. The only     ***
***      commands which don't use this exit are BLKUPD, RVARY,      ***
***      RACDCERT, RACMAP, RACLINK, RACPRIV.                        ***
***                                                                 ***
***      For all other commands, only specific users will be        ***
***      allowed to enter those commands.                           ***
***                                                                 ***
***      Users with SPECIAL attribute are allowed to issue all      ***
***      RACF commands. Users with AUDITOR attribute will be        ***
***      allowed to enter READ only commands. All other users       ***
***      are not allowed to issue any RACF commands.                ***
***                                                                 ***
***      REQUIREMENTS:                                              ***
***      1. The exit routine must be added to the IRREVX01 exit     ***
***         point via OS/390(MVS) Dynamic Exit Services.  For       ***
***         the routine to take effect at IPL time, have an         ***
***         entry in the PROGxx member of SYS1.PARMLIB, as          ***
***         pointed to by PROG= in the IEASYSxx member of           ***
***         SYS1.PARMLIB.  See OS/390(MVS) Initialization and       ***
***         Tuning Reference for details.                           ***
***                                                                 ***
***         EXAMPLE:                                                ***
***          In the PROGxx member:                                  ***
***           EXIT ADD                                              ***
***                EXITNAME(IRREVX01)                               ***
***                MODNAME(RACFCMDS)                                ***
***                STATE(ACTIVE)                                    ***
***          Or from the console:                                   ***
***           SETPROG EXIT,ADD,EXITNAME=IRREVX01,MODNAME=RACFCMDS   ***
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
***      IRREVXP                   SYS1.MODGEN                      ***
***      IHAACEE                   SYS1.MACLIB                      ***
***      IHASDWA                   SYS1.MACLIB                      ***
***                                                                 ***
***      LOAD MODULE NAME          SYSTEM LIBRARY                   ***
***      ----------------          --------------                   ***
***      RACFCMDS (RENT,REFR)      LINKLIB concatenation            ***
***       AMODE(31) RMODE(ANY)                                      ***
***                                                                 ***
***********************************************************************
***********************************************************************
         EJECT
RACFCMDS CSECT ,                   an IRREVX01 exit routine
RACFCMDS AMODE 31
RACFCMDS RMODE ANY
RACFCMDS CSECT
         SAVE  (14,12),,RACFCMDS-&SYSDATE-&SYSTIME
         LR    R12,R15             program addressability
         USING RACFCMDS,R12        set base register
         LR    R10,R1              save parameter address
         USING EVXPL,R10           base parameter map
         USING ACEE,R3             temporarily R3 bases ACEE
         SR    R7,R7               initialize return code register
*
* check if ACEE addr available(i.e. not from RACF parameter library)
*
         L     R3,EVXACEE          load ACEE address
         LTR   R3,R3               Do we have an ACEE?
         BNZ   PRECHCK             yes - continue checking
         B     RETURN              quick return
*
*
* check if this is a pre-exit invocation
*
PRECHCK  L     R4,EVXFLAGS
         TM    0(R4),EVXPRE        pre-exit ?
         BNO   RETURN              No - post-processing, then exit
*
*
* check for SPECIAL , PRIVILEGED, and AUDITOR attributes
*
SPECCHCK TM    ACEEFLG1,ACEESPEC   Is this a special user?
         BO    RETURN              yes - no more checking done
         TM    ACEEFLG1,ACEEPRIV   Privileged?
         BO    RETURN              yes - no more checking done
*
* Get user's ID and verify if it's in user table
*
         XR    R8,R8
         LA    R8,AUTHNAME
AUTHLOOP CLI   0(R8),X'FF'                  END OF AUTHNAME TABLE?
         BE    AUDITCHK                     YES, GET OUT
         CLC   0(8,R8),ACEEUSRI             IS THIS USER IN THE TABLE
         BE    RETURN                       YES, GO DO THE REST
         LA    R8,8(,R8)                    INCREMENT TO NEXT ENTRY
         B     AUTHLOOP                     LOOP UNTIL DONE
*
* Check for auditor
*
AUDITCHK TM    ACEEFLG1,ACEEAUDT   Auditor?
         BO    COMMCHCK            yes - check the command used
         TM    ACEEFLG1,ACEEROA    Read-Only Auditor?
         BO    COMMCHCK            yes - check the command used
         B     BADRC               no - user not allowed
*
*
* if the command specified is one of the following, do nothing
*
* LISTDSD, LISTGRP, LISTUSER, RLIST, SEARCH
*
COMMCHCK L     R5,EVXCALLR
         TM    0(R5),EVXSETRO         Is this SETROPTS?
         BO    RETURN                 yes - no more checking, exit
         TM    0(R5),EVXPERMI         Is this PERMIT?
         BO    BADRC                  yes - exit with bad RC
         TM    0(R5),EVXLISTD         Is this LISTDSD?
         BO    RETURN                 yes - no more checking, exit
         TM    0(R5),EVXLISTG         Is this LISTGRP?
         BO    RETURN                 yes - no more checking, exit
         TM    0(R5),EVXLISTU         Is this LISTUSER?
         BO    RETURN                 yes - no more checking, exit
         TM    0(R5),EVXRLIST         Is this RLIST?
         BO    RETURN                 yes - no more checking, exit
         TM    0(R5),EVXSEARC         Is this SEARCH?
         BO    RETURN                 yes - no more checking, exit
*
*
* Bad return code 8. User cannot issue the command.
*
BADRC    L     R6,EVXMSSG          load address of additional text
         MVC   MSGINFO+5(8),ACEEUSRI     get user id
         MVC   0(MSGINFOL,R6),MSGINFO    copy the text in
         LA    R7,8
*
*
* return back
*
RETURN   EQU   *
         WTO   'IRREXV01 Exit has been entered.',ROUTCDE=(11)
         LR    R15,R7              copy return code
         RETURN (14,12),T,RC=(15)
         EJECT
*
*
* List of special users who can issue commands
*
AUTHNAME DS    0CL8
         DC    CL8'USERID1 '
         DC    CL8'USERID2 '
AUTHNEND DC    8XL1'FF'
*
* Output message information
*
MSGINFO  DC    C'User         is not allowed to issue the command.'
MSGINFOL EQU   *-MSGINFO
         LTORG
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
*
* mappings
*
         IRREVXP
         EJECT
         IHAACEE
         EJECT
         ICHRUTKN
         EJECT
         IHASDWA
         END   RACFCMDS
