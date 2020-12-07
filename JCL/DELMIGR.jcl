//00000000 JOB 0-000-0-000,'Delete Migrate  ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//**********************************************************************
//*
//* Delete migrated datasets
//*
//**********************************************************************
//STEP01   EXEC PGM=IKJEFT1A
//SYSEXEC  DD   DISP=SHR,DSN=REXX.LIBRARY
//OUTPUT   DD   SYSOUT=*
//SYSTSPRT DD   SYSOUT=*
//SYSTSIN  DD   *
%DELMIGR XXXXXXX.**
/*
//*
//
