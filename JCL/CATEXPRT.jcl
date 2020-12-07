//00000000 JOB 0-000-0-000,'Catalog Export  ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//**********************************************************************
//*
//* Export Catalog for backup
//*
//**********************************************************************
//*
//STEP01   EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//DDEXPORT DD DSN=&SYSUID..MCAT.BK,
//            DISP=(NEW,CATLG,DELETE),UNIT=3390
//SYSIN    DD *,SYMBOLS=JCLONLY
 EXPORT MCAT.NAME -
        OUTFILE(DDEXPORT) TEMPORARY
