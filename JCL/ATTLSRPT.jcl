//00000000 JOB 0-000-0-000,'AT-TLS Report   ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//**********************************************************************
//*
//* This job produces an AT-TLS report based on Server App
//*
//**********************************************************************
//*
//STEP01   EXEC PGM=IKJEFT1A,PARM='ATTLSRPT TN3270'
//SYSEXEC  DD DISP=SHR,DSN=REXX.LIBRARY
//OUTPUT   DD SYSOUT=*
//SYSTSPRT DD SYSOUT=*
//SYSTSIN  DD DUMMY
