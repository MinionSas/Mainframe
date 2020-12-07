//00000000 JOB 0-000-0-000,'List all CERTS  ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//**********************************************************************
//*
//* List Certificates using RACF commands
//*
//**********************************************************************
//*
//STEP01    EXEC PGM=IKJEFT1A
//SYSTSPRT  DD   SYSOUT=*
//SYSTSIN   DD   *
SEARCH CLASS(DIGTCERT) LIST ALL
SEARCH CLASS(DIGTRING) LIST ALL
/*
//STEP02    EXEC PGM=IKJEFT1A
//SYSTSPRT  DD   SYSOUT=*
//SYSTSIN   DD   *
RACDCERT LIST CERTAUTH
/*
//STEP03    EXEC PGM=IKJEFT1A
//SYSTSPRT  DD   SYSOUT=*
//SYSTSIN   DD   *
RACDCERT LIST SITE
/*
//STEP04    EXEC PGM=IKJEFT1A
//SYSTSPRT  DD   SYSOUT=*
//SYSTSIN   DD   *
RACDCERT LIST ID(xxxxxxx)
/*
