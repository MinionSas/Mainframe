//00000000 JOB 0-000-0-000,'UNIQUE          ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//**********************************************************************
//*
//* Quick and dirty way to find unique values in specific column
//*
//**********************************************************************
//*
//STEP01    EXEC PGM=ICETOOL
//TOOLMSG   DD SYSOUT=*
//PRINT     DD SYSOUT=*
//SYSOUT    DD SYSOUT=*
//SYSPRINT  DD SYSOUT=*
//DFSMSG    DD SYSOUT=*
//INPUT     DD DISP=SHR,DSN=INPUT.DS
//OUTPUT    DD SYSOUT=*
//TOOLIN    DD *
 OCCUR FROM(INPUT) LIST(OUTPUT) ON(1,10,CH) ON(VALCNT,N08) NOHEADER
//*
