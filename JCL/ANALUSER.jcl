//00000000 JOB 0-000-0-000,'Analyze Racf User',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//**********************************************************************
//*
//* This job uses the IRRDBU00 utility output and builds different
//* reports with the ANALUSER Rexx Exec.
//*
//**********************************************************************
//STEP01   EXEC PGM=ICETOOL
//INPUT    DD DISP=SHR,DSN=IRRDBU00.INPUT
//OUTPUT   DD DSN=&&USERINFO,
//            DISP=(,PASS),SPACE=(CYL,(20,20),RLSE),UNIT=3390,
//            DCB=(RECFM=FB,LRECL=310,BLKSIZE=0)
//TEMP0001 DD DISP=(NEW,DELETE,DELETE),SPACE=(CYL,(50,50)),UNIT=3390
//SYSOUT   DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
//DFSMSG   DD DUMMY
//TOOLMSG  DD DUMMY
//TOOLIN   DD *
 SORT    FROM(INPUT) TO(TEMP0001) USING(RACF)
 DISPLAY FROM(TEMP0001) LIST(OUTPUT) NOHEADER NOCC -
         ON(10,8,CH) -
         ON(79,20,CH) -
         ON(100,8,CH) -
         ON(54,4,CH)  -
         ON(44,4,CH)  -
         ON(49,4,CH)  -
         ON(390,4,CH) -
         ON(385,4,CH) -
         ON(118,10,CH) -
         ON(462,10,CH) -
         ON(64,3,CH) -
         ON(68,10,CH) -
         ON(395,4,CH) -
         ON(409,4,CH) -
         ON(638,4,CH)
/*
//RACFCNTL  DD *
 SORT    FIELDS=(10,8,CH,A)
 INCLUDE COND=(5,4,CH,EQ,C'0200')
 OPTION  VLSHRT
/*
//********************************************************************
//*ICETOOL: EXTRACT RACF USER TSO INFO FROM IRRDBU00 REPORT
//********************************************************************
//STEP02   EXEC PGM=ICETOOL,COND=(0,NE)
//INPUT    DD DISP=SHR,DSN=IRRDBU00.INPUT
//OUTPUT   DD DSN=&&USERTSO,
//            DISP=(,PASS),SPACE=(CYL,(20,20),RLSE),UNIT=3390,
//            DCB=(RECFM=FB,LRECL=310,BLKSIZE=0)
//TEMP0001 DD DISP=(NEW,DELETE,DELETE),SPACE=(CYL,(50,50)),UNIT=3390
//SYSOUT   DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
//DFSMSG   DD DUMMY
//TOOLMSG  DD DUMMY
//TOOLIN   DD *
 SORT    FROM(INPUT) TO(TEMP0001) USING(RACF)
 DISPLAY FROM(TEMP0001) LIST(OUTPUT) NOHEADER NOCC -
         ON(10,8,CH) -
         ON(154,8,CH) -
         ON(163,10,CH) -
         ON(176,10,CH)
/*
//RACFCNTL  DD *
 SORT    FIELDS=(10,8,CH,A)
 INCLUDE COND=(5,4,CH,EQ,C'0220')
 OPTION  VLSHRT
/*
//********************************************************************
//*ICETOOL: EXTRACT RACF USER OMVS INFO FROM IRRDBU00 REPORT
//********************************************************************
//STEP03   EXEC PGM=ICETOOL,COND=(0,NE)
//INPUT    DD DISP=SHR,DSN=IRRDBU00.INPUT
//OUTPUT   DD DSN=&&USEROMVS,
//            DISP=(,PASS),SPACE=(CYL,(20,20),RLSE),UNIT=3390,
//            DCB=(RECFM=FB,LRECL=310,BLKSIZE=0)
//TEMP0001 DD DISP=(NEW,DELETE,DELETE),SPACE=(CYL,(50,50)),UNIT=3390
//SYSOUT   DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
//DFSMSG   DD DUMMY
//TOOLMSG  DD DUMMY
//TOOLIN   DD *
 SORT    FROM(INPUT) TO(TEMP0001) USING(RACF)
 DISPLAY FROM(TEMP0001) LIST(OUTPUT) NOHEADER NOCC -
         ON(10,8,CH) -
         ON(19,10,CH) -
         ON(30,30,CH) -
         ON(1054,30,CH)
/*
//RACFCNTL  DD *
 SORT    FIELDS=(19,10,CH,A)
 INCLUDE COND=(5,4,CH,EQ,C'0270')
 OPTION  VLSHRT
/*
//STEP04   EXEC PGM=IKJEFT1A,PARM='ANALUSER',COND=(0,NE)
//SYSEXEC  DD   DISP=SHR,DSN=REXX.LIBRARY
//INPUT01  DD   DISP=SHR,DSN=&&USERINFO
//INPUT02  DD   DISP=SHR,DSN=&&USERTSO
//INPUT03  DD   DISP=SHR,DSN=&&USEROMVS
//ACCDATE  DD   *          This is the date for access
2010-01-01
2018-01-01
//PASSDATE DD   *          Password date before user changed
2010-01-01
2018-01-01
//REVOKED  DD   DUMMY       List of Revoked Users
//SPECIAL  DD   DUMMY       List of SPECIAL Users
//OPERATN  DD   DUMMY       List of OPERATIONS Users
//AUDITOR  DD   DUMMY       List of AUDITOR Users
//ROAUDIT  DD   DUMMY       List of ROAUDIT Users
//UAUDIT   DD   DUMMY       List of Users with UAUDIT
//PROTECT  DD   DUMMY       List of Users with No Pass
//ACCESSA  DD   SYSOUT=*    Accessed System after date
//ACCESSB  DD   SYSOUT=*    Accessed System before date
//PASSCHGA DD   SYSOUT=*    Changed Password after date
//PASSCHGB DD   SYSOUT=*    Changed Password before date
//PASSINT  DD   DUMMY       List of users with specific Passint
//UNSUCC   DD   DUMMY       Users with more than 1 unsuccesful
//TSO      DD   DUMMY       Users with TSO segment.
//OMVS     DD   DUMMY       Users with OMVS segment.
//SYSTSPRT DD   SYSOUT=*
//SYSTSIN  DD   DUMMY
