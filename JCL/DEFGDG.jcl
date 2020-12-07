//00000000 JOB 0-000-0-000,'DEFINE A GDG    ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//**********************************************************************
//*
//* Define a GDG
//*
//**********************************************************************
//STEP1    EXEC PGM=IDCAMS
//SYSPRINT DD   SYSOUT=*
//SYSIN    DD   *
     DEFINE GENERATIONDATAGROUP -
           (NAME(DATASET.GDG.BASE) -
           SCRATCH                           -
           NOEMPTY                           -
           LIMIT(7))
/*
//*
