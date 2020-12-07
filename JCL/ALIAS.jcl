//00000000 JOB 0-000-0-000,'Create Alias    ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//**********************************************************************
//*
//* Create an Alias
//*
//**********************************************************************
//*
//STEP01   EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
 LISTCAT ENTRIES('XXXXXXX')
 IF LASTCC GT 0 THEN DO
  SET MAXCC = 0
  DEFINE ALIAS(NAME(XXXXXXX) RELATE(CATALOG.USER))
 END
/*
