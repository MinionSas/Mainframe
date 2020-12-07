//00000000 JOB 0-000-0-000,'BCPII TEST      ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//**********************************************************************
//*
//* TEST BCPII INTERFACE USING SYSTEM REXX
//*
//**********************************************************************
//*
//         SET BCPIIOUT=&SYSUID..BCPII.OUTPUT
//*
//DELETE   EXEC PGM=IEFBR14
//DD1     DD   DISP=(MOD,DELETE,DELETE),DSN=&BCPIIOUT,
//             SPACE=(TRK,(1,1))
//*
//ALLOCATE EXEC PGM=IEFBR14,COND=(0,NE)
//DD1     DD   DISP=(NEW,CATLG),DSN=&BCPIIOUT,
//             UNIT=3390,SPACE=(TRK,(10,10,50)),
//             DCB=(LRECL=80,RECFM=FB),DSNTYPE=LIBRARY
//*
//STEP01  EXEC PGM=HWIREXX,COND=(0,NE),
//   PARM=('NAME=BCPII',
//             'DSN=&BCPIIOUT',
//             'TSO=Y',
//             'SYNC=Y',
//             'TIMELIM=N',
//             'TIME=40')
//SYSPRINT DD  SYSOUT=*
