//00000000 JOB 0-000-0-000,'Pasearch        ',
//             CLASS=D,REGION=0M,MSGCLASS=X,TIME=NOLIMIT,
//             NOTIFY=&SYSUID
//**********************************************************************
//*
//* This is a pasearch utility
//*
//**********************************************************************
//STEP01  EXEC PGM=BPXBATCH
//STDOUT   DD   SYSOUT=*
//STDERR   DD   SYSOUT=*
//STDPARM  DD *
sh

echo '=================================';
echo '=        General Rules          =';
echo '=================================';
pasearch -c;
echo '=================================';
echo '=          IDS Rules            =';
echo '=================================';
pasearch -i;
echo '=================================';
echo '=        AT-TLS Rules           =';
echo '=================================';
pasearch -t;
echo '=================================';
echo '=        IPSec Rules            =';
echo '=================================';
pasearch -v a;

/*
//*
//
