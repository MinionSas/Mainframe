//0000000A JOB 0-000-0-000,'SNMP OSA ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//*
//STEP01  EXEC PGM=BPXBATCH
//STDOUT   DD   SYSOUT=*
//STDERR   DD   SYSOUT=*
//STDPARM  DD *
sh

snmp -h 127.0.0.1 -c public -v walk ibmOSAExp5SPortTable
;
