//00000000 JOB 0-000-0-000,'Allocate VSAM',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//*
//*
//* ESDS
//*
//IDCAMS   EXEC PGM=IDCAMS
//SYSPRINT DD  SYSOUT=*
//SYSIN    DD  *
         DEFINE CLUSTER (                                   -
               NAME(VSAM.ESDS)                              -
               VOLUMES(SASF01)                              -
               RECORDSIZE(22 22)                            -
               RECORDS(100 100)                             -
               NONINDEXED )                                 -
         DATA (                                             -
               NAME(VSAM.ESDS.DATA) )
/*
//
//*
//* KSDS
//*
//IDCAMS   EXEC PGM=IDCAMS
//SYSPRINT DD  SYSOUT=*
//SYSIN    DD  *
         DEFINE CLUSTER (                                   -
               NAME(VSAM.KSDS)                              -
               VOLUME(SASF01)                               -
               RECORDSIZE(24642 24642)                      -
               KEYS(32 0)                                   -
               BUFSP(47616)                                 -
               SHAREOPTIONS(2))                             -
        DATA                                                -
          (NAME(VSAM.KSDS.DATA)                             -
               CYLINDERS(1 1))                              -
        INDEX                                               -
          (NAME(VSAM.KSDS.INDEX))
//*
//* RRDS
//*
//IDCAMS   EXEC PGM=IDCAMS
//SYSPRINT DD  SYSOUT=*
//SYSIN    DD  *
  DEFINE CLUSTER (                                          -
                 NAME(VSAM.RRDS)                            -
                 VOLUMES(SASF01)                            -
                 RECORDSIZE(30 30)                          -
                 RECORDS(100 100)                           -
                 NUMBERED                                   -
                 REUSE )                                    -
           DATA (                                           -
                 NAME(VSAM.RRDS.DATA) )
//*
//
