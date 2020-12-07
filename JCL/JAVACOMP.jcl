//00000000 JOB 0-000-0-000,'Java Compile',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//*
//E1       EXPORT SYMLIST=(JZIPHOME)
//         SET JZIPHOME='/var/javazip'
//*
//STEP01  EXEC PGM=BPXBATCH,COND=(0,NE)
//STDOUT   DD   SYSOUT=*
//STDERR   DD   SYSOUT=*
//STDPARM  DD *,SYMBOLS=JCLONLY
sh

/usr/lpp/java/current_64/bin/javac
 -d &JZIPHOME/classes
 &JZIPHOME/src/ZipDatasetSource.java
 ;

//*
//STEP02  EXEC PGM=BPXBATCH,COND=(0,NE)
//STDOUT   DD   SYSOUT=*
//STDERR   DD   SYSOUT=*
//STDPARM  DD *,SYMBOLS=JCLONLY
sh

/usr/lpp/java/current_64/bin/javac
 -cp &JZIPHOME/classes
 -d &JZIPHOME/classes
 &JZIPHOME/src/ZipDatasetSourceBin.java
 ;

//*
//STEP03  EXEC PGM=BPXBATCH,COND=(0,NE)
//STDOUT   DD   SYSOUT=*
//STDERR   DD   SYSOUT=*
//STDPARM  DD *,SYMBOLS=JCLONLY
sh

/usr/lpp/java/current_64/bin/javac
 -cp &JZIPHOME/classes
 -d &JZIPHOME/classes
 &JZIPHOME/src/ZipDatasets.java
 ;

//*
