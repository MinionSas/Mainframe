//00000000 JOB 0-000-0-000,'Test HTTP URLs  ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//*
//STEP01   EXEC PGM=IKJEFT1A,PARM='WEBCHECK'
//SYSEXEC  DD DISP=SHR,DSN=REXX.LIBRARY
//SYSTSPRT DD SYSOUT=*
//SYSTSIN  DD DUMMY
//INPUT    DD *
* Google
https://google.com
* Github
https://github.com
* Amazon
https://amazon.com
/*
