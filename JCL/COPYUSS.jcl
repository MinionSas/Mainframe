//00000000 JOB 0-000-0-000,'Copy to USS     ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//**********************************************************************
//*
//* Copy a dataset to USS file using OCOPY with Special table
//*
//**********************************************************************
//*
//STEP01   EXEC PGM=IKJEFT1A
//SYSUDUMP DD SYSOUT=*
//SYSTSPRT DD SYSOUT=*
//SYSTSIN  DD *
  ALLOC FI(IMVS) +
   DA('DATASET') SHR
  ALLOC FI(OMVS) +
   PATHDISP(KEEP) +
   PATHMODE(SIRWXU,SIRWXG,SISGID) +
   PATHOPTS(OWRONLY,OCREAT) +
   FILEDATA(TEXT) +
   PATH +
  ('/home/user/file.xls')
  OCOPY INDD(IMVS) OUTDD(OMVS) +
   CONVERT((BPXFX311)) PATHOPTS(OVERRIDE) FROM1047
//*
