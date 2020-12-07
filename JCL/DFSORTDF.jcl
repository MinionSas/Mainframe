//00000000 JOB 0-000-0-000,'DFSort Defaults ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//**********************************************************************
//*
//* List the DFSORT Defaults
//*
//**********************************************************************
//*
//STEP01   EXEC PGM=ICETOOL
//TOOLMSG   DD SYSOUT=*
//DFSMSG    DD SYSOUT=*
//OUT       DD SYSOUT=*
//TOOLIN    DD *
  DEFAULTS LIST(OUT)
/*
