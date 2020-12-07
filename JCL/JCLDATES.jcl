//00000000 JOB 0-000-0-000,'Date Symbols   ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//*
//STEP01   EXEC PGM=IEBGENER
//SYSUT1   DD *,SYMBOLS=EXECSYS
Current Date                    : &YR4./&MON./&DAY.
Current Day                     : &DAY
Julian Day                      : &JDAY
Current Local Time (EST)        : &LHHMMSS
Current Time (UTC)              : &HR.&MIN.&SEC
Current Local YYMMDD            : &LYYMMDD
Current Local Day               : &LDAY
Current Local Hour              : &LHR
Current Local Minute            : &LMIN
Current Local Month             : &LMON
Current Local Seconds           : &LSEC
Current Local Day of the Week   : &LWDAY
Current Local 4 Digit Year      : &LYR4
Current Local 2 Digit Year      : &LYR2
//SYSUT2   DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
//SYSIN    DD DUMMY
