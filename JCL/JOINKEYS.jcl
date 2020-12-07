//00000000 JOB 0-000-0-000,'SORT JoinKeys  ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//*
//JOINTRGT EXEC PGM=SORT
//SOURCE    DD DISP=SHR,DSN=TEST.LIST
//TARGET    DD DISP=SHR,DSN=TEST.OUT
//SORTOUT   DD DSN=TEST.COMB,
//             DISP=(NEW,CATLG),
//             DATACLAS=DCSMALL,
//             RECFM=FB,LRECL=150,BLKSIZE=0
//SYSOUT    DD SYSOUT=*
//SYSIN     DD *
 JOINKEYS F1=SOURCE,FIELDS=(48,8,A)
 JOINKEYS F2=TARGET,FIELDS=(48,8,A)
 JOIN UNPAIRED,F1,ONLY
 REFORMAT FIELDS=(F1:1,133)
 OPTION COPY
/*