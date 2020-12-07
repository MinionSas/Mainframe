//00000000 JOB 0-000-0-000,'FIND Jar        ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//**********************************************************************
//*
//* Find Jar files in a specific directory
//*
//**********************************************************************
//*
//STEP01   EXEC PGM=IEBGENER
//SYSPRINT DD   SYSOUT=*
//SYSIN    DD   DUMMY
//SYSUT1   DD   *
#!/bin/sh
find $1 -name "*.jar" | while read -r FILE
do
echo 'checking jar file ' $FILE
jar -tvf "$FILE" | grep $2
done
# end script
//SYSUT2  DD PATH='/tmp/script.sh',
//           FILEDATA=TEXT,
//           PATHOPTS=(OWRONLY,OCREAT,OTRUNC),
//           PATHMODE=(SIRWXU,SIRWXG,SISGID)
//*
//STEP02  EXEC PGM=BPXBATCH,COND=(0,NE)
//STDOUT   DD   SYSOUT=*
//STDERR   DD   SYSOUT=*
//STDPARM  DD *
sh

/tmp/script.sh /usr/lpp/cics/tsxxx/lib ByteArray                      ;

rm /tmp/script.sh                                                     ;

/*
