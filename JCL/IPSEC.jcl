//00000000 JOB 0-000-0-000,'IPSec Policies  ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//**********************************************************************
//*
//* Display the IPSec Policies
//*
//**********************************************************************
//*
//STEP01  EXEC PGM=BPXBATCH
//STDOUT   DD   SYSOUT=*
//STDERR   DD   SYSOUT=*
//STDPARM  DD *
sh

echo '=================================';
echo '=        IPSec Policies         =';
echo '=================================';
ipsec -f display;
ipsec -p TCPIP -F display;

/*
//*
//
