//00000000 JOB 0-000-0-000,'PDFSAS          ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//**********************************************************************
//*
//* CONVERT FILE TO PDS USING SAS
//*
//**********************************************************************
//STEP01   EXEC PGM=IEFBR14
//DD1      DD DISP=(MOD,DELETE,DELETE),DSN=&SYSUID..TEST.PDF,
//            SPACE=(TRK,(1,1))
//*
//STEP01   EXEC SAS
//INPUT    DD  DISP=SHR,DSN=INPUT.DS
//OUTPUT   DD  DSN=&SYSUID..TEST.PDF,
//             DISP=(,CATLG),
//             UNIT=3390,
//             SPACE=(CYL,(10,15),RLSE),
//             DCB=(LRECL=259,RECFM=VB,BLKSIZE=27998)
//SYSIN    DD  DISP=SHR,DSN=SAS(GENPDF)
