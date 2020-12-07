//00000000 JOB 0-000-0-000,'Sort Copy        ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//*
//DELETE1  EXEC PGM=IEFBR14,
//             COND=(0,NE)
//IDEL01   DD  DSN=&SYSUID..OUTPUT,
//             DISP=(MOD,DELETE,DELETE),
//             UNIT=3390,
//             SPACE=(TRK,0)
//*
//SORT1    EXEC PGM=SORT
//SORTIN   DD  DISP=SHR,DSN=&SYSUID..INPUT
//SORTOUT  DD  DSN=&SYSUID..OUTPUT,
//             DISP=(NEW,CATLG,DELETE),
//             UNIT=3390,
//             SPACE=(CYL,(10,10),RLSE),
//             DCB=(RECFM=FB,LRECL=310)
//SYSOUT   DD  SYSOUT=*
//SYSUDUMP DD  SYSOUT=*
//SYSIN    DD  *
 SORT    FIELDS=COPY
/*
