//00000000 JOB 0-000-0-000,'Compress PDS    ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//**********************************************************************
//*
//* Compress a PDS (even if in use)
//*
//**********************************************************************
//COMPRESS EXEC  PGM=IEBCOPY,PARM='COMPRESS'
//SYSUT2   DD  DISP=SHR,DSN=PDS.NAME
//SYSUT3   DD  UNIT=WORK,SPACE=(CYL,(10,10))
//SYSUT4   DD  UNIT=WORK,SPACE=(CYL,(10,10))
//SYSPRINT DD  SYSOUT=*
//SYSIN    DD  *
  COPY
//*
