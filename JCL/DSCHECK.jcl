//00000000 JOB 0-000-0-000,'DSVERIFY      ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//**********************************************************************
//*
//* MAKE SURE THE DATASETS IN DSLIST ARE ON PROPER VOLUMES
//*
//**********************************************************************
//*
//CHECKDS  EXEC PGM=IKJEFT1A,PARM='DSCHECK'
//SYSEXEC  DD   DISP=SHR,DSN=REXX.LIBRARY
//SYSTSPRT DD   SYSOUT=*
//SYSTSIN  DD   DUMMY
//ERRORS   DD   SYSOUT=*
//VOLIST   DD   *
XXXX
//DSLIST   DD   *
DATASET1
DATASET2
ETC
