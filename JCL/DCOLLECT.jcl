//00000000 JOB 0-000-0-000,'DCOLLECT        ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//**********************************************************************
//*
//* SAMPLE DCOLLECT FOR ALL ONLINE VOLUMES
//*
//**********************************************************************
//*
//IDCAMS EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//DCOUT    DD DSN=&SYSUID..DCOL.OUT,
//            DISP=(,CATLG),SPACE=(CYL,(50,50),RLSE),
//            DSORG=PS,RECFM=VB,LRECL=600,AVGREC=K
//SYSIN    DD *
 DCOLLECT  -
      OUTFILE(DCOUT)  -
      VOLUMES(*)
//*
